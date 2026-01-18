// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../calculator.dart';
import '../widgets/loshu_grid.dart';
import '../widgets/lucky_compass_card.dart';
import '../widgets/remedy_card.dart';
import '../widgets/enhanced_number_card.dart';
import '../widgets/grid_analysis_card.dart';
import '../widgets/expandable_card.dart';
import '../l10n/app_localizations.dart';
import '../utils/localized_data.dart';
import '../utils/enhanced_calculator.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
// Using `printing` for PDF sharing/export
import 'package:screenshot/screenshot.dart';
import '../utils/name_corrector.dart';
import '../utils/mobile_analyzer.dart';
import '../utils/position_numerology.dart';
import '../models/number_info.dart';
import 'compatibility_screen.dart';
// import 'package:auragrids/services/ai_service.dart';
import 'package:auragrids/services/google_ai_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLanguage;
  final Locale currentLocale;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.onToggleLanguage,
    required this.currentLocale,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _aiPromptController = TextEditingController();
  DateTime? _selectedDate;
  Gender _selectedGender = Gender.male;
  Map<int, int> _gridData = {};

  // Enhanced number info objects
  NumberInfo? _driverInfo;
  NumberInfo? _conductorInfo;
  NumberInfo? _kuaInfo;
  NameAnalysis? _nameAnalysis;
  GridAnalysis? _gridAnalysis;
  List<ArrowPattern> _arrowPatterns = [];
  // New analyses
  NamePositionResult? _nicknamePositionResult;
  MobileAdvancedAnalysis? _mobileAdvanced;
  NamePositionResult? _fullNamePositionResult;
  // AI name suggestion state
  bool _isAiLoading = false;
  List<dynamic>? _nameSuggestions; // List<NameCorrection> or raw fallback

  // Legacy numbers for compatibility
  int _kuaNumber = 0, _personalYear = 0, _personalMonth = 0;

  bool _showResults = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Expansion states for collapsible sections
  bool _expandedGrid = true;
  bool _expandedCoreNumbers = true;
  bool _expandedNameAnalysis = true;
  bool _expandedGridAnalysis = true;
  bool _expandedArrowPatterns = true;
  bool _expandedLuckyCompass = true;
  bool _expandedStrengths = true;
  bool _expandedRemedies = true;
  bool _expandedNameCorrection = false;
  bool _expandedMobileAnalysis = false;
  // Screenshot controller for exporting a visual of the results
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('saved_name');
    final savedMobile = prefs.getString('saved_mobile');
    final savedNickname = prefs.getString('saved_nickname');
    if (savedName != null && savedName.isNotEmpty) {
      setState(() {
        _nameController.text = savedName;
        _nameAnalysis = EnhancedCalculator.analyzeFullName(savedName);
      });
    }
    if (savedMobile != null && savedMobile.isNotEmpty) {
      setState(() {
        _mobileController.text = savedMobile;
      });
    }
    if (savedNickname != null && savedNickname.isNotEmpty) {
      setState(() => _nicknameController.text = savedNickname);
    }
  }



  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (_selectedDate == null) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.selectDateError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      // Enhanced calculations with master numbers and double digits
      _driverInfo = EnhancedCalculator.getDriverNumberInfo(_selectedDate!.day);
      _conductorInfo = EnhancedCalculator.getConductorNumberInfo(
        _selectedDate!.day,
        _selectedDate!.month,
        _selectedDate!.year,
      );

      // Complete name analysis
      if (_nameController.text.trim().isNotEmpty) {
        _nameAnalysis =
            EnhancedCalculator.analyzeFullName(_nameController.text);
      }

      // Kua number (enhanced with NumberInfo)
      _kuaNumber =
          AuraCalculator.calculateKua(_selectedDate!.year, _selectedGender);
      int kuaSum = _selectedDate!.year
          .toString()
          .split('')
          .map(int.parse)
          .reduce((a, b) => a + b);
      int kuaReduced = EnhancedCalculator.reduceWithMaster(kuaSum).reducedValue;
      int kuaFinal =
          _selectedGender == Gender.male ? (11 - kuaReduced) : (kuaReduced + 4);
      _kuaInfo = EnhancedCalculator.reduceWithMaster(kuaFinal);

      // Personal Year and Month
      _personalYear = AuraCalculator.calculatePersonalYear(
          _selectedDate!.day, _selectedDate!.month);
      _personalMonth = EnhancedCalculator.reduceWithMaster(
              _personalYear + DateTime.now().month)
          .reducedValue;

      // Lo Shu Grid - only from birth date digits
      _gridData = AuraCalculator.calculateLoShu(
        _selectedDate!.day,
        _selectedDate!.month,
        _selectedDate!.year,
      );

      // Add Kua number to grid (important in Lo Shu Grid system)
      _gridData[_kuaNumber] = (_gridData[_kuaNumber] ?? 0) + 1;

      // Grid analysis (missing/excessive numbers)
      _gridAnalysis = EnhancedCalculator.analyzeGrid(_gridData);

      // Arrow patterns detection
      _arrowPatterns = EnhancedCalculator.detectArrowPatterns(_gridData);

      _showResults = true;
    });

    // Persist nickname (if any)
    final prefs = await SharedPreferences.getInstance();
    if (_nicknameController.text.trim().isNotEmpty) {
      await prefs.setString('saved_nickname', _nicknameController.text.trim());
    }

    // Compute nickname position analysis and mobile advanced analysis
    if (_nicknameController.text.trim().isNotEmpty) {
      _nicknamePositionResult =
          analyzeNamePosition(_nicknameController.text.trim());
    } else {
      _nicknamePositionResult = null;
    }

    _mobileAdvanced =
        MobileAnalyzer.analyzeMobileAdvanced(_mobileController.text.trim());
    // Full name age-phase analysis
    if (_nameController.text.trim().isNotEmpty) {
      _fullNamePositionResult =
          analyzeNamePosition(_nameController.text.trim());
    } else {
      _fullNamePositionResult = null;
    }

    _animationController.forward(from: 0);
  }

  // Trigger the AI agent to fetch name correction suggestions asynchronously.
  Future<void> _fetchNameCorrections() async {
    if (_nameController.text.trim().isEmpty || _driverInfo == null || _conductorInfo == null) return;

    setState(() {
      _isAiLoading = true;
      _nameSuggestions = null;
    });

    final google = GoogleAiService();
    try {
      final raw = await google.getNameSuggestions(
        _nameController.text.trim(),
        _driverInfo!.reducedValue,
        _conductorInfo!.reducedValue,
      );

      // raw is expected to be a JSON array string
      List<dynamic> parsed = [];
      try {
        parsed = jsonDecode(raw) as List<dynamic>;
      } catch (_) {
        // attempt to extract JSON array if AI returned text before/after
        final start = raw.indexOf('[');
        final end = raw.lastIndexOf(']');
        if (start != -1 && end != -1 && end > start) {
          final jsonText = raw.substring(start, end + 1);
          parsed = jsonDecode(jsonText) as List<dynamic>;
        }
      }

      final List<NameCorrection> aiCorrections = parsed.map((s) {
        return NameCorrector.fromAiJson(
            Map<String, dynamic>.from(s),
            _nameController.text.trim(),
            EnhancedCalculator.calculateNameNumberInfo(_nameController.text.trim()),
            _driverInfo!.reducedValue,
            _conductorInfo!.reducedValue);
      }).toList();

      if (!mounted) return;
      setState(() {
        _nameSuggestions = aiCorrections;
        _isAiLoading = false;
      });
    } catch (e) {
      // fallback to local suggestions
      final fallback = NameCorrector.analyzeName(
        _nameController.text.trim(),
        _driverInfo!.reducedValue,
        _conductorInfo!.reducedValue,
      );
      if (!mounted) return;
      setState(() {
        _nameSuggestions = fallback;
        _isAiLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AI error: $e — using local suggestions')));
    }
  }

  // Centralized helper to call Google AI and parse suggestions into NameCorrection
  Future<void> _fetchAgentSuggestions() async {
    if (_nameController.text.trim().isEmpty || _driverInfo == null || _conductorInfo == null) return;

    setState(() {
      _isAiLoading = true;
      _nameSuggestions = null;
    });

    final service = GoogleAiService();
    final raw = await service.getNameSuggestions(
      _nameController.text.trim(),
      _driverInfo!.reducedValue,
      _conductorInfo!.reducedValue,
      userPrompt: _aiPromptController.text.trim(),
      missingNumbers: _gridAnalysis?.missingNumbers ?? [],
    );

    try {
      List<dynamic> list = [];
      try {
        list = jsonDecode(raw) as List<dynamic>;
      } catch (_) {
        final start = raw.indexOf('[');
        final end = raw.lastIndexOf(']');
        if (start != -1 && end != -1 && end > start) {
          list = jsonDecode(raw.substring(start, end + 1)) as List<dynamic>;
        } else {
          throw FormatException('No JSON array found in AI response');
        }
      }

      final originalInfo = EnhancedCalculator.calculateNameNumberInfo(_nameController.text.trim());

    int localCalculateCompatibility(NumberInfo nameInfo, int driver, int conductor) {
          int score = 50;
          int nameNum = nameInfo.reducedValue;
          // Local copy of compatibility logic (kept in sync with NameCorrector)
          if (nameInfo.isMasterNumber) score += 30;
          if (NameCorrector.luckyNumbers.contains(nameNum)) score += 15;

          // Compatibility map (same as NameCorrector._areCompatible)
          const Map<int, List<int>> compatible = {
            1: [1, 2, 3, 9],
            2: [1, 2, 6, 9],
            3: [1, 3, 5, 6, 9],
            4: [1, 4, 6, 8],
            5: [1, 3, 5, 6, 9],
            6: [2, 3, 4, 5, 6, 9],
            7: [7],
            8: [4, 8],
            9: [1, 2, 3, 5, 6, 9],
          };

          bool areCompatible(int n1, int n2) => compatible[n1]?.contains(n2) ?? false;

          if (nameNum == driver) {
            score += 20;
          } else if (areCompatible(nameNum, driver)) {
            score += 10;
          }

          if (nameNum == conductor) {
            score += 20;
          } else if (areCompatible(nameNum, conductor)) {
            score += 10;
          }

          if (nameInfo.isKarmicDebt) score -= 15;
          return score.clamp(0, 100);
        }

      final suggestions = list.map((item) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(item);
        final suggested = map['name'] ?? map['suggested_name'] ?? map['suggestedName'] ?? '';
        final reason = map['reason'] ?? map['explanation'] ?? map['benefit'] ?? 'AI optimized vibration';
        final suggestedInfo = EnhancedCalculator.calculateNameNumberInfo(suggested);
        return NameCorrection(
          originalName: _nameController.text.trim(),
          suggestedName: suggested,
          originalNumber: originalInfo,
          suggestedNumber: suggestedInfo,
          reason: reason,
          compatibilityScore: localCalculateCompatibility(suggestedInfo, _driverInfo!.reducedValue, _conductorInfo!.reducedValue),
        );
      }).toList();

      if (!mounted) return;
      setState(() {
        _nameSuggestions = suggestions;
        _isAiLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isAiLoading = false;
        _nameSuggestions = NameCorrector.analyzeName(
          _nameController.text.trim(),
          _driverInfo!.reducedValue,
          _conductorInfo!.reducedValue,
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AI parse error: $e — using local suggestions')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.grid_4x4,
                color: Theme.of(context).appBarTheme.foregroundColor),
            const SizedBox(width: 8),
            Text(l10n.appTitle,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ],
        ),
        actions: [
          // Compatibility Calculator
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: l10n.translate('compatibility_calculator'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CompatibilityScreen()),
              );
            },
          ),

          // Language Toggle
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            tooltip: l10n.translate('change_language'),
            onSelected: (value) {
              widget.onToggleLanguage();
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'en',
                child: Row(
                  children: [
                    Text(widget.currentLocale.languageCode == 'en'
                        ? '✓ '
                        : '  '),
                    const Text('English'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'kn',
                child: Row(
                  children: [
                    Text(widget.currentLocale.languageCode == 'kn'
                        ? '✓ '
                        : '  '),
                    const Text('ಕನ್ನಡ (Kannada)'),
                  ],
                ),
              ),
            ],
          ),

          // Theme toggle
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: l10n.translate('toggle_theme'),
            onPressed: widget.onToggleTheme,
          ),

          // AI Settings
          IconButton(
            icon: const Icon(Icons.api),
            tooltip: 'AI Settings',
            onPressed: () async {
              final localContext = context; // capture context before any awaits
              final prefs = await SharedPreferences.getInstance();
              final controller = TextEditingController(
                  text: prefs.getString('ai_api_key') ?? '');
              final result = await showDialog<bool>(
                context: localContext,
                builder: (ctx) => AlertDialog(
                  title: Text('Set AI API Key'),
                  content: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Google API key (e.g. AIz...)'),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text('Cancel')),

                    // PDF font configuration (allows user to provide a local TTF path)
                    IconButton(
                      icon: const Icon(Icons.font_download),
                      tooltip: 'Configure PDF font',
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final current = prefs.getString('pdf_font_path') ?? '';
                        final controller = TextEditingController(text: current);
                        final saved = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('PDF Font Path'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                    'Enter a local path to a TTF file to embed in PDFs.'),
                                const SizedBox(height: 8),
                                TextField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                        hintText:
                                            '/path/to/NotoSans-Regular.ttf')),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(false),
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  child: const Text('Save')),
                            ],
                          ),
                        );
                        if (saved == true) {
                          await prefs.setString(
                              'pdf_font_path', controller.text.trim());
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('PDF font path saved')));
                        }
                      },
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text('Save')),
                  ],
                ),
              );
              if (result == true) {
                final candidate = controller.text.trim();
                // Quick local validation: reject obvious OpenAI keys
                if (candidate.startsWith('sk-')) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(localContext).showSnackBar(const SnackBar(content: Text('That looks like an OpenAI key (sk-...). Please provide a Google Cloud API key.')));
                } else if (candidate.isEmpty) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(localContext).showSnackBar(const SnackBar(content: Text('API key is empty.')));
                } else {
                  final service = GoogleAiService(apiKey: candidate);
                  try {
                    final models = await service.validateApiKey(candidate);
                    await prefs.setString('ai_api_key', candidate);
                    if (!mounted) return;
                    ScaffoldMessenger.of(localContext).showSnackBar(SnackBar(content: Text('AI API Key saved — ${models.length} models available')));
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(localContext).showSnackBar(SnackBar(content: Text('Failed to validate key: ${e.toString()}')));
                  }
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildInputSection(),
            if (_showResults) ...[
              const SizedBox(height: 30),
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildResultSection(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 8,
      shadowColor:
          Theme.of(context).primaryColor.withAlpha((0.3 * 255).round()),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.discoverDestiny,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.enterDetails,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.fullName,
                prefixIcon: const Icon(Icons.person_outline),
                hintText: l10n.nameHint,
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname (what people call you)',
                prefixIcon: const Icon(Icons.person),
                hintText: 'e.g., Sam, Balu',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                // On web, ensure the active input is unfocused before opening the picker
                FocusScope.of(context).unfocus();
                final localContext = context; // capture context before await
                DateTime? picked = await showDatePicker(
                  context: localContext,
                  initialDate: DateTime(1992, 6, 5),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (ctx, child) {
                    return Theme(
                      data: Theme.of(ctx).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Theme.of(ctx).primaryColor,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  if (!mounted) return;
                  setState(() => _selectedDate = picked);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? l10n.selectBirthDate
                            : "${l10n.dobLabel}: ${_selectedDate!.day.toString().padLeft(2, '0')} / ${_selectedDate!.month.toString().padLeft(2, '0')} / ${_selectedDate!.year}",
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: l10n.translate('mobile_number_optional'),
                prefixIcon: const Icon(Icons.phone),
                hintText: l10n.translate('mobile_hint'),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.gender,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.male, size: 18),
                        const SizedBox(width: 6),
                        Text(l10n.male),
                      ],
                    ),
                    selected: _selectedGender == Gender.male,
                    onSelected: (_) =>
                        setState(() => _selectedGender = Gender.male),
                    selectedColor: Colors.blue.shade200,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.female, size: 18),
                        const SizedBox(width: 6),
                        Text(l10n.female),
                      ],
                    ),
                    selected: _selectedGender == Gender.female,
                    onSelected: (_) =>
                        setState(() => _selectedGender = Gender.female),
                    selectedColor: Colors.pink.shade200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  await _calculate();
                  await _fetchNameCorrections();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      l10n.revealButton,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSection() {
    final l10n = AppLocalizations.of(context)!;
    final planesWithNumbers =
        AuraCalculator.getCompletedPlanesWithNumbers(_gridData);
    final remedies = AuraCalculator.getRemedies(_gridData);

    return Screenshot(
      controller: _screenshotController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Download PDF button row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await _exportPdf(planesWithNumbers, remedies);
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: Text(l10n.translate('download_pdf')),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Lo Shu Grid
          // Age-Phase Name Analysis (Origin / Destination)
          if (_fullNamePositionResult != null)
            ExpandableCard(
              title: 'Age-Phase Analysis',
              icon: Icons.timeline,
              isExpanded: true,
              onToggle: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Origin (First Letter): ${_fullNamePositionResult!.firstLetter} - ${_fullNamePositionResult!.firstTrait}'),
                  const SizedBox(height: 6),
                  Text(
                      'Destination (Last Letter): ${_fullNamePositionResult!.lastLetter} - ${_fullNamePositionResult!.lastTrait}'),
                  if (_fullNamePositionResult!.flags.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ..._fullNamePositionResult!.flags.map((f) => Text('⚠️ $f'))
                  ]
                ],
              ),
            ),

          ExpandableCard(
            title: l10n.loShuGrid,
            icon: Icons.grid_4x4,
            isExpanded: _expandedGrid,
            onToggle: () => setState(() => _expandedGrid = !_expandedGrid),
            child: LoShuGrid(gridData: _gridData, kuaNumber: _kuaNumber),
          ),

          // Core Numbers
          ExpandableCard(
            title: l10n.coreNumbers,
            icon: Icons.stars,
            isExpanded: _expandedCoreNumbers,
            onToggle: () =>
                setState(() => _expandedCoreNumbers = !_expandedCoreNumbers),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_driverInfo != null)
                  EnhancedNumberCard(
                    title: l10n.driverPsychic,
                    numberInfo: _driverInfo!,
                    icon: Icons.wb_sunny,
                  ),
                if (_conductorInfo != null)
                  EnhancedNumberCard(
                    title: l10n.conductorDestiny,
                    numberInfo: _conductorInfo!,
                    icon: Icons.route,
                  ),
                if (_kuaInfo != null)
                  EnhancedNumberCard(
                    title: l10n.kuaNumber,
                    numberInfo: _kuaInfo!,
                    icon: Icons.explore,
                  ),
                const SizedBox(height: 12),
                // Time cycles
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withAlpha((0.15 * 255).round()),
                        Colors.purple.withAlpha((0.05 * 255).round()),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.purple.withAlpha((0.3 * 255).round()),
                        width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  Colors.purple.withAlpha((0.2 * 255).round()),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.calendar_today,
                                color: Colors.purple, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${l10n.personalYear}: $_personalYear - ${LocalizedData.getPersonalYearMessage(l10n, _personalYear)}',
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Personal Month (${_getMonthName(DateTime.now().month)}): $_personalMonth',
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Name Analysis
          ExpandableCard(
            title: l10n.nameAnalysis,
            icon: Icons.person_search,
            isExpanded: _expandedNameAnalysis,
            onToggle: () =>
                setState(() => _expandedNameAnalysis = !_expandedNameAnalysis),
            child: _nameAnalysis != null
                ? NameAnalysisCard(
                    fullName: _nameController.text, analysis: _nameAnalysis!)
                : Text(l10n.enterNameToAnalyze),
          ),

          const SizedBox(height: 8),
          // Nickname position analysis (if provided)
          if (_nicknamePositionResult != null)
            ExpandableCard(
              title: 'Nickname Analysis',
              icon: Icons.chat_bubble,
              isExpanded: true,
              onToggle: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Nickname first letter: ${_nicknamePositionResult!.firstLetter} - ${_nicknamePositionResult!.firstTrait}'),
                  const SizedBox(height: 6),
                  Text(
                      'Nickname last letter: ${_nicknamePositionResult!.lastLetter} - ${_nicknamePositionResult!.lastTrait}'),
                  if (_nicknamePositionResult!.flags.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ..._nicknamePositionResult!.flags.map((f) => Text('⚠️ $f'))
                  ]
                ],
              ),
            ),

          const SizedBox(height: 12),

          // Lucky Compass
          ExpandableCard(
            title: l10n.luckyCompass,
            icon: Icons.explore,
            isExpanded: _expandedLuckyCompass,
            onToggle: () =>
                setState(() => _expandedLuckyCompass = !_expandedLuckyCompass),
            child: LuckyCompassCard(driver: _driverInfo?.reducedValue ?? 1),
          ),

          const SizedBox(height: 12),

          // Grid Frequency Analysis
          ExpandableCard(
            title: l10n.translate('grid_frequency_analysis'),
            icon: Icons.analytics,
            isExpanded: _expandedGridAnalysis,
            onToggle: () =>
                setState(() => _expandedGridAnalysis = !_expandedGridAnalysis),
            child: _gridAnalysis != null
                ? GridAnalysisCard(analysis: _gridAnalysis!)
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 12),

          // Arrow Patterns
          if (_arrowPatterns.isNotEmpty)
            ExpandableCard(
              title: l10n.translate('arrow_patterns'),
              icon: Icons.timeline,
              isExpanded: _expandedArrowPatterns,
              onToggle: () => setState(
                  () => _expandedArrowPatterns = !_expandedArrowPatterns),
              child: ArrowPatternsCard(patterns: _arrowPatterns),
            ),

          const SizedBox(height: 12),

          // Strengths & Planes
          if (planesWithNumbers.isNotEmpty)
            ExpandableCard(
              title: l10n.strengthsPlanes,
              icon: Icons.emoji_events,
              isExpanded: _expandedStrengths,
              onToggle: () =>
                  setState(() => _expandedStrengths = !_expandedStrengths),
              child: _buildPlanesCard(planesWithNumbers),
            ),

          const SizedBox(height: 12),

          // Remedies
          ExpandableCard(
            title: l10n.personalizedRemedies,
            icon: Icons.lightbulb,
            isExpanded: _expandedRemedies,
            onToggle: () =>
                setState(() => _expandedRemedies = !_expandedRemedies),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.strengthenMissing,
                    style:
                        TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 12),
                ...remedies.entries
                    .where((e) => !_gridData.containsKey(e.key))
                    .map((e) => RemedyCard(
                        number: e.key,
                        remedy: LocalizedData.getRemedy(l10n, e.key))),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Name Correction Suggestions
          ExpandableCard(
            title: l10n.nameCorrection,
            icon: Icons.auto_fix_high,
            isExpanded: _expandedNameCorrection,
            onToggle: () => setState(
                () => _expandedNameCorrection = !_expandedNameCorrection),
            child: _buildNameCorrectionSection(),
          ),

          const SizedBox(height: 12),

          // Mobile Number Analysis
          ExpandableCard(
            title: l10n.mobileAnalysis,
            icon: Icons.phone_android,
            isExpanded: _expandedMobileAnalysis,
            onToggle: () => setState(
                () => _expandedMobileAnalysis = !_expandedMobileAnalysis),
            child: _buildMobileAnalysisSection(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNameCorrectionSection() {
    final l10n = AppLocalizations.of(context)!;

    // Always show the AI prompt input on top so user can ask questions anytime.
    Widget aiInputArea = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _aiPromptController,
          decoration: InputDecoration(
            labelText: 'Ask AI for name suggestions',
            hintText:
                'e.g., Prefer names starting with A, or focusing on business success',
            prefixIcon: const Icon(Icons.question_answer),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                // Validate required inputs before calling AI
                if (_nameController.text.trim().isEmpty ||
                    _selectedDate == null) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please enter your full name and select DOB before asking AI.')),
                  );
                  return;
                }

                if (_driverInfo == null || _conductorInfo == null) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please press Reveal to compute your core numbers before asking AI.')),
                  );
                  return;
                }

                if (_aiPromptController.text.trim().isEmpty) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Please enter a prompt for AI to respond to.')),
                  );
                  return;
                }

                // Start loading state and show spinner
                setState(() {
                  _isAiLoading = true;
                  _nameSuggestions = null;
                });

                // Show transient loading dialog (helps on web for focus issues)
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  await _fetchAgentSuggestions();
                  if (mounted) Navigator.of(context).pop(); // close loading dialog
                } catch (e) {
                  // Close loading dialog if still open
                  if (mounted) Navigator.of(context).pop();

                  // Fallback to local logic
                  final fallback = NameCorrector.analyzeName(
                    _nameController.text.trim(),
                    _driverInfo!.reducedValue,
                    _conductorInfo!.reducedValue,
                  );

                  if (!mounted) return;
                  setState(() {
                    _nameSuggestions = fallback;
                    _isAiLoading = false;
                  });

                  final msg = e.toString();
                  if (msg.contains('Unauthorized') || msg.contains('API key') || msg.contains('not set')) {
                    // Show actionable snackbar to let user set/update API key
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('AI key error: ${msg.split('\n').first}'),
                      action: SnackBarAction(
                        label: 'Set API Key',
                        onPressed: () => _showAiKeyDialog(),
                      ),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('AI error: $e — using local suggestions')));
                  }
                }
              },
              child: Text('Ask AI'),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                _aiPromptController.clear();
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ],
    );

    // Existing static suggestions (fallback) - only shown if original analysis produces suggestions
    if (_nameController.text.trim().isEmpty ||
        _driverInfo == null ||
        _conductorInfo == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          aiInputArea,
          const SizedBox(height: 12),
          Text(l10n.enterNameToSuggest),
        ],
      );
    }

    // If AI is loading, show a spinner
    if (_isAiLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          aiInputArea,
          const SizedBox(height: 12),
          const Center(child: CircularProgressIndicator()),
        ],
      );
    }

    // If we already have name suggestions from AI or fallback, show them.
    if (_nameSuggestions != null) {
      final items = _nameSuggestions!;
      if (items.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            aiInputArea,
            const SizedBox(height: 12),
            Text(l10n.noNameSuggestions),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          aiInputArea,
          const SizedBox(height: 12),
          ...items.map((s) {
            NameCorrection? correction;
            if (s is NameCorrection) {
              correction = s;
            } else {
              correction = null;
            }
            final String title = correction != null
                ? correction.suggestedName
                : (s['suggested_name'] ?? s['name'] ?? '');
            final String subtitle = correction != null
                ? correction.reason
                : (s['explanation'] ?? s['benefit'] ?? '');
            final String trailing = correction != null
                ? correction.suggestedNumber.displayValue
                : '';

            return Card(
              child: ListTile(
                leading: correction != null
                    ? CircleAvatar(child: Text('${correction.compatibilityScore}%'))
                    : const CircleAvatar(child: Icon(Icons.auto_fix_high)),
                title: Text(title),
                subtitle: Text(subtitle),
                trailing: trailing.isNotEmpty
                    ? Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold))
                    : null,
                onTap: () async {
                  final localContext = context;
                  final apply = await showDialog<bool>(
                    context: localContext,
                    builder: (ctx) => AlertDialog(
                      title: Text(l10n.applySuggestion),
                      content: Text('$title\n$subtitle'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text(l10n.cancel)),
                        TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text(l10n.apply)),
                      ],
                    ),
                  );

                  if (apply == true) {
                    if (!mounted) return;
                    setState(() {
                      _nameController.text = title;
                      _nameAnalysis = EnhancedCalculator.analyzeFullName(title);
                    });

                    // Persist the applied name
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('saved_name', title);

                    if (!mounted) return;
                    ScaffoldMessenger.of(localContext).showSnackBar(
                      SnackBar(content: Text('$title ${l10n.applySuggestion}')),
                    );
                  }
                },
              ),
            );
          }),
        ],
      );
    }

    // Default: no AI results yet — show local (synchronous) suggestions
    final localSuggestions = NameCorrector.analyzeName(
      _nameController.text.trim(),
      _driverInfo!.reducedValue,
      _conductorInfo!.reducedValue,
    );

    if (localSuggestions.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          aiInputArea,
          const SizedBox(height: 12),
          Text(l10n.noNameSuggestions),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        aiInputArea,
        const SizedBox(height: 12),
        ...localSuggestions.map((s) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${s.compatibilityScore}%')),
              title: Text(s.suggestedName),
              subtitle: Text(s.reason),
              trailing: Text(s.suggestedNumber.displayValue, style: const TextStyle(fontWeight: FontWeight.bold)),
              onTap: () async {
                final localContext = context;
                final apply = await showDialog<bool>(
                  context: localContext,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.applySuggestion),
                    content: Text('${s.suggestedName}\n${s.reason}'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(l10n.cancel)),
                      TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(l10n.apply)),
                    ],
                  ),
                );

                if (apply == true) {
                  if (!mounted) return;
                  setState(() {
                    _nameController.text = s.suggestedName;
                    _nameAnalysis = EnhancedCalculator.analyzeFullName(s.suggestedName);
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('saved_name', s.suggestedName);
                  if (!mounted) return;
                  ScaffoldMessenger.of(localContext).showSnackBar(SnackBar(content: Text('${s.suggestedName} ${l10n.applySuggestion}')));
                }
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMobileAnalysisSection() {
    final l10n = AppLocalizations.of(context)!;

    if (_mobileController.text.trim().isEmpty ||
        _driverInfo == null ||
        _conductorInfo == null) {
      return Text(l10n.enterMobileToAnalyze);
    }

    final analysis = MobileAnalyzer.analyzeMobileNumber(
      _mobileController.text.trim(),
      _driverInfo!.reducedValue,
      _conductorInfo!.reducedValue,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _getScoreColor(analysis.compatibilityScore)
                .withAlpha((0.08 * 255).round()),
            border: Border.all(
                color: _getScoreColor(analysis.compatibilityScore)
                    .withAlpha((0.3 * 255).round())),
          ),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 26, child: Text('${analysis.compatibilityScore}%')),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(analysis.compatibility,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                        '${l10n.translate('direction')}: ${analysis.mobileNumberInfo.displayValue}'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () async {
                  final localContext = context;
                  await Clipboard.setData(ClipboardData(
                      text: analysis.mobileNumberInfo.displayValue));
                  if (!mounted) return;
                  ScaffoldMessenger.of(localContext).showSnackBar(
                      SnackBar(content: Text(l10n.copiedClipboard)));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (analysis.strengths.isNotEmpty) ...[
          Text(l10n.strengths,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...analysis.strengths.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 6), child: Text('• $s'))),
          const SizedBox(height: 12),
        ],
        if (analysis.weaknesses.isNotEmpty) ...[
          Text(l10n.weaknesses,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...analysis.weaknesses.map((w) => Padding(
              padding: const EdgeInsets.only(bottom: 6), child: Text('• $w'))),
          const SizedBox(height: 12),
        ],
        if (analysis.suggestions.isNotEmpty) ...[
          Text(l10n.suggestions,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...analysis.suggestions.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 6), child: Text('• $s'))),
          const SizedBox(height: 12),
        ],
        if (analysis.betterNumbers.isNotEmpty) ...[
          Text(l10n.betterNumbers,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...analysis.betterNumbers.map((bn) => Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(bn),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      final localContext = context;
                      await Clipboard.setData(ClipboardData(text: bn));
                      if (!mounted) return;
                      ScaffoldMessenger.of(localContext).showSnackBar(
                          SnackBar(content: Text(l10n.copiedClipboard)));
                    },
                  ),
                ),
              )),
        ],
        const SizedBox(height: 12),
        if (_mobileAdvanced != null) ...[
          Text('Advanced Mobile Safety Checks',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_mobileAdvanced!.warnings.isNotEmpty) ...[
            ..._mobileAdvanced!.warnings.map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('⚠️ $w'))),
          ] else
            Text('No advanced warnings detected.'),
          const SizedBox(height: 8),
          if (_mobileAdvanced!.missingDigits.isNotEmpty) ...[
            Text(
                'Missing digits: ${_mobileAdvanced!.missingDigits.join(', ')}'),
          ],
        ],
      ],
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 85) return Colors.green;
    if (score >= 70) return Colors.lightGreen;
    if (score >= 55) return Colors.orange;
    if (score >= 40) return Colors.deepOrange;
    return Colors.red;
  }

  Widget _buildPlanesCard(List<Map<String, dynamic>> planes) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events,
                    color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  l10n.strengthsPlanes,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...planes.map((plane) {
              final planeName = LocalizedData.getPlane(l10n, plane['name']);
              final numbers = plane['numbers'] as List<int>;
              final planeType = plane['type'] as String;

              // Choose icon based on plane type
              IconData planeIcon;
              Color iconColor;
              switch (planeType) {
                case 'horizontal':
                  planeIcon = Icons.view_stream;
                  iconColor = Colors.blue;
                  break;
                case 'vertical':
                  planeIcon = Icons.view_week;
                  iconColor = Colors.green;
                  break;
                case 'diagonal':
                  planeIcon = Icons.trending_up;
                  iconColor = Colors.amber;
                  break;
                default:
                  planeIcon = Icons.check_circle;
                  iconColor = Colors.grey;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800.withAlpha((0.3 * 255).round())
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: iconColor.withAlpha((0.3 * 255).round()),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(planeIcon, color: iconColor, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planeName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                l10n.numbersLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ...numbers.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final num = entry.value;
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: iconColor
                                            .withAlpha((0.2 * 255).round()),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        num.toString(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: iconColor,
                                        ),
                                      ),
                                    ),
                                    if (idx < numbers.length - 1)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text('•',
                                            style: TextStyle(
                                                color: Colors.grey.shade400)),
                                      ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final l10n = AppLocalizations.of(context);
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    // Try localized key first, fall back to English list
    final key = 'month_\$month';
    final translated = l10n?.translate(key);
    if (translated != null && translated.isNotEmpty && translated != key) {
      return translated;
    }
    return months[month - 1];
  }

  /// Show a small dialog allowing the user to set/update the AI API key
  Future<void> _showAiKeyDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final controller = TextEditingController(text: prefs.getString('ai_api_key') ?? '');
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set AI API Key'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter AI API key'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Save')),
        ],
      ),
    );

    if (result == true) {
      await prefs.setString('ai_api_key', controller.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI API Key saved')));
    }
  }

  Future<void> _exportPdf(List<Map<String, dynamic>> planesWithNumbers,
      Map<int, String> remedies) async {
    final pdf = pw.Document();

    // Attempt to load a Unicode font to embed in the PDF. Priority:
    // 1) user-provided local path (saved in SharedPreferences as 'pdf_font_path')
    // 2) bundled asset at assets/fonts/NotoSans-Regular.ttf (if you add it)
    // 3) fallback to default PDF font.
    pw.Font? embeddedFont;
    try {
      final prefs = await SharedPreferences.getInstance();
      final configuredPath = prefs.getString('pdf_font_path');
      if (configuredPath != null && configuredPath.isNotEmpty) {
        try {
          final file = File(configuredPath);
          if (await file.exists()) {
            final bytes = await file.readAsBytes();
            embeddedFont = pw.Font.ttf(ByteData.view(bytes.buffer));
          }
        } catch (_) {
          embeddedFont = null;
        }
      }

      if (embeddedFont == null) {
        // Try asset (works only if you add the font to pubspec and repository)
        try {
          final fontData =
              await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');
          embeddedFont = pw.Font.ttf(fontData.buffer.asByteData());
        } catch (_) {
          embeddedFont = null;
        }
      }
    } catch (_) {
      embeddedFont = null;
    }

    final pw.TextStyle headerStyle = pw.TextStyle(
        font: embeddedFont, fontSize: 18, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle bodyStyle =
        pw.TextStyle(font: embeddedFont, fontSize: 12);

    // Try to capture a screenshot of the results area for visual export
    Uint8List? screenshotBytes;
    try {
      // Unfocus any active input (fixes web assertion about active input element)
      try {
        FocusScope.of(context).unfocus();
        // Also hide any on-screen keyboard/input connection where possible
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      } catch (_) {}
      // Give the UI a bit more time to settle on web before capturing
      await Future.delayed(const Duration(milliseconds: 500));
      screenshotBytes = await _screenshotController.capture(
          delay: const Duration(milliseconds: 200));
    } catch (_) {
      screenshotBytes = null;
    }

    final name = _nameController.text.trim().isEmpty
        ? 'Unknown'
        : _nameController.text.trim();
    final dob = _selectedDate != null
        ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
        : 'Unknown';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context ctx) => [
          pw.Header(
              level: 0,
              child: pw.Text('AuraGrids - Report', style: headerStyle)),
          pw.SizedBox(height: 6),
          pw.Paragraph(text: 'Name: $name', style: bodyStyle),
          pw.Paragraph(text: 'Date of Birth: $dob', style: bodyStyle),
          pw.Paragraph(text: 'Kua Number: $_kuaNumber', style: bodyStyle),
          pw.SizedBox(height: 8),
          if (screenshotBytes != null)
            pw.Center(
              child: pw.Container(
                width: PdfPageFormat.a4.availableWidth,
                // Make the screenshot as large as possible (90% of the page height)
                height: PdfPageFormat.a4.availableHeight * 0.90,
                child: pw.Image(pw.MemoryImage(screenshotBytes),
                    fit: pw.BoxFit.contain),
              ),
            ),
          pw.SizedBox(height: 12),
          pw.Header(
              level: 1, child: pw.Text('Lo Shu Grid', style: headerStyle)),
          pw.TableHelper.fromTextArray(
            headers: ['Number', 'Count'],
            data: _gridData.entries
                .map((e) => [e.key.toString(), e.value.toString()])
                .toList(),
          ),
          pw.SizedBox(height: 12),
          pw.Header(
              level: 1, child: pw.Text('Core Numbers', style: headerStyle)),
          if (_driverInfo != null)
            pw.Paragraph(
                text:
                    'Driver: ${_driverInfo!.displayValue} - ${_driverInfo!.description}',
                style: bodyStyle),
          if (_conductorInfo != null)
            pw.Paragraph(
                text:
                    'Conductor: ${_conductorInfo!.displayValue} - ${_conductorInfo!.description}',
                style: bodyStyle),
          if (_kuaInfo != null)
            pw.Paragraph(
                text:
                    'Kua Info: ${_kuaInfo!.displayValue} - ${_kuaInfo!.description}',
                style: bodyStyle),
          pw.SizedBox(height: 12),
          pw.Header(
              level: 1,
              child: pw.Text('Strengths & Planes', style: headerStyle)),
          ...planesWithNumbers.map((plane) {
            final planeName = plane['name'].toString();
            final numbers = plane['numbers'] as List<int>;
            return pw.Column(children: [
              pw.Text(planeName,
                  style: pw.TextStyle(
                      font: embeddedFont, fontWeight: pw.FontWeight.bold)),
              pw.Text('Numbers: ${numbers.join(', ')}', style: bodyStyle),
              pw.SizedBox(height: 6),
            ]);
          }),
          pw.SizedBox(height: 12),
          pw.Header(level: 1, child: pw.Text('Remedies', style: headerStyle)),
          pw.Column(
            children: remedies.entries
                .map((e) =>
                    pw.Bullet(text: '${e.key}: ${e.value}', style: bodyStyle))
                .toList(),
          ),
        ],
      ),
    );

    try {
      // Try to save to Downloads (preferred for desktop/mobile)
      final bytes = await pdf.save();
      Directory? downloadsDir;

      try {
        if (Platform.isAndroid || Platform.isIOS) {
          downloadsDir = await getTemporaryDirectory();
        } else if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
          downloadsDir = await getDownloadsDirectory();
        }
      } catch (_) {
        downloadsDir = null;
      }

      if (downloadsDir != null) {
        final file = File(
            '${downloadsDir.path}/auragrids_report_${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(bytes);

        // On mobile, use Share.shareFiles; on desktop open print/save dialog
        // Use the printing dialog on all platforms as a robust fallback which
        // allows saving or sharing the generated PDF. This avoids deprecated
        // share APIs and keeps behavior consistent across devices.
        await Printing.layoutPdf(onLayout: (PdfPageFormat f) async => bytes);
        return;
      }

      // If Downloads not available or writing failed, fallback to printing dialog
      await Printing.layoutPdf(onLayout: (PdfPageFormat f) async => pdf.save());
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('PDF export failed: $e')));
    }
  }
}

