import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:auragrids/local_ai_key.dart' as local_key;

// Build-time injection: flutter build ... --dart-define=AI_API_KEY=your_key
const String _kAiApiKeyFromEnv = String.fromEnvironment('AI_API_KEY', defaultValue: '');

class GoogleAiService {
  final String? _apiKey;
  // Default model to use for generation
  final String _url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  // Helpful recommended models (taken from ListModels response)
  static const List<String> recommendedModels = [
    'models/gemini-2.5-flash',
    'models/gemini-2.5-pro',
    'models/gemini-flash-latest',
  ];

  GoogleAiService({String? apiKey}) : _apiKey = apiKey;

  Future<String> _resolveApiKey() async {
    if (_kAiApiKeyFromEnv.isNotEmpty) return _kAiApiKeyFromEnv;
    if (_apiKey != null && _apiKey.isNotEmpty) return _apiKey;
    try {
      final local = local_key.LocalAiKey.apiKey;
      if (local.isNotEmpty) return local;
    } catch (_) {}
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('ai_api_key');
    if (stored != null && stored.isNotEmpty) return stored;
    throw Exception('AI API key not set. Add a Google Cloud API key in app settings.');
  }

  Future<String> getNameSuggestions(String currentName, int driver, int conductor, {String? userPrompt, List<int>? missingNumbers}) async {
    final buffer = StringBuffer();
    buffer.writeln('User Name: $currentName');
    buffer.writeln('Driver: $driver, Conductor: $conductor.');
    if (missingNumbers != null && missingNumbers.isNotEmpty) {
      buffer.writeln('Missing grid numbers: ${missingNumbers.join(', ')}.');
    }
    if (userPrompt != null && userPrompt.isNotEmpty) {
      buffer.writeln('User prompt: $userPrompt');
    }
    buffer.writeln('Suggest 3 name spelling corrections.');
    buffer.writeln('Rules: Chaldean system, avoid ending in B,K,R. Totals should be friendly to $driver.');
    buffer.writeln('Format: Return ONLY a JSON array of objects with keys: name, total, and reason.');

    final prompt = buffer.toString();
    final key = await _resolveApiKey();

    try {
      final response = await http.post(
        Uri.parse('$_url?key=$key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [ {"parts": [{"text": prompt}] }],
          "generationConfig": {
            "responseMimeType": "application/json"
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // The API returns candidates -> content -> parts -> text (string)
        return data['candidates'][0]['content']['parts'][0]['text'];
      }

      // Helpful guidance when API key is not valid for this endpoint
      if (response.statusCode == 401 || response.statusCode == 403) {
        final body = response.body;
        // If the response mentions OpenAI, likely an OpenAI key was used by mistake
        if (body.contains('platform.openai.com') || body.contains('invalid_api_key') || body.contains('Incorrect API key')) {
          throw Exception('Unauthorized: It looks like an OpenAI API key was provided. For Google Generative Language use a Google Cloud API key (create one at https://console.cloud.google.com/apis/credentials) and enable the Generative Language API for your project.');
        }
        throw Exception('Unauthorized: invalid Google API key (status ${response.statusCode}). Ensure the key is from Google Cloud and the Generative Language API is enabled.');
      }

      // For other non-successful responses, include the body to help debugging
      throw Exception('AI API error: ${response.statusCode} ${response.body}');
    } catch (e) {
      // Bubble up errors so callers can fallback to local logic
      rethrow;
    }
  }

  /// Validate that the provided API key can access the Generative Language API and
  /// return the list of available models. Throws on error.
  Future<List<String>> validateApiKey([String? apiKey]) async {
    final key = apiKey ?? await _resolveApiKey();
    final uri = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=$key');
    final resp = await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final models = (data['models'] as List<dynamic>?) ?? [];
      return models.map((m) => (m as Map<String, dynamic>)['name'] as String).toList();
    }

    if (resp.statusCode == 401 || resp.statusCode == 403) {
      throw Exception('Unauthorized: invalid Google API key (status ${resp.statusCode}). Ensure the key is from Google Cloud and the Generative Language API is enabled.');
    }

    throw Exception('ListModels error: ${resp.statusCode} ${resp.body}');
  }
}