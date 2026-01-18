import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// This reads the key passed during: flutter build apk --dart-define=AI_API_KEY=...
const String _kAiApiKeyFromEnv = String.fromEnvironment('AI_API_KEY', defaultValue: 'AIzaSyAuDhSOYPUE0etKcrLJoQ-8w44kiKjiL14');

class GoogleAiService {
  final String? _manualKey;
  final String _url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  static const List<String> recommendedModels = [
    'models/gemini-2.5-flash',
    'models/gemini-2.5-pro',
    'models/gemini-flash-latest',
  ];

  GoogleAiService({String? apiKey}) : _manualKey = apiKey;

  /// Logic to find the best available API key
  Future<String> _resolveApiKey() async {
    // 1. Priority: Check if passed during build time (GitHub Actions)
    if (_kAiApiKeyFromEnv.isNotEmpty) return _kAiApiKeyFromEnv;

    // 2. Secondary: Check if passed to the constructor
    if (_manualKey != null && _manualKey!.isNotEmpty) return _manualKey!;

    // 3. Tertiary: Check local storage (Settings page)
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('ai_api_key');
    if (stored != null && stored.isNotEmpty) return stored;

    throw Exception('AI API key not set. Please add a key in Settings.');
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
        return data['candidates'][0]['content']['parts'][0]['text'];
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception('Unauthorized: Invalid Google API key.');
      }

      throw Exception('AI API error: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> validateApiKey([String? apiKey]) async {
    final key = apiKey ?? await _resolveApiKey();
    final uri = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=$key');
    final resp = await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final models = (data['models'] as List<dynamic>?) ?? [];
      return models.map((m) => (m as Map<String, dynamic>)['name'] as String).toList();
    }
    throw Exception('Validation failed');
  }
}