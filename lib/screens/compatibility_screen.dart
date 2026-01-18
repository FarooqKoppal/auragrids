import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../calculator.dart';
import '../utils/enhanced_calculator.dart';
import '../models/number_info.dart';

class CompatibilityScreen extends StatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  final TextEditingController _name1Controller = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  DateTime? _dob1;
  DateTime? _dob2;
  Gender _gender1 = Gender.male;
  Gender _gender2 = Gender.female;
  CompatibilityResult? _result;

  @override
  void dispose() {
    _name1Controller.dispose();
    _name2Controller.dispose();
    super.dispose();
  }

  void _calculate() {
    final l10n = AppLocalizations.of(context)!;
    if (_dob1 == null || _dob2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.translate('select_both_birth_dates')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _result = EnhancedCalculator.calculateCompatibility(
        name1: _name1Controller.text.isEmpty ? 'Person 1' : _name1Controller.text,
        dob1: _dob1!,
        gender1: _gender1,
        name2: _name2Controller.text.isEmpty ? 'Person 2' : _name2Controller.text,
        dob2: _dob2!,
        gender2: _gender2,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)?.compatibilityCalculator ?? 'Compatibility Calculator'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputCard(),
            if (_result != null) ...[
              const SizedBox(height: 30),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '💑 ${AppLocalizations.of(context)?.compatibilityCalculator ?? 'Compatibility Calculator'}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            
            // Person 1
            Text(AppLocalizations.of(context)?.person ?? 'Person 1', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _name1Controller,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            _buildDatePicker(
              context: context,
              label: 'Birth Date',
              selectedDate: _dob1,
              onDateSelected: (date) => setState(() => _dob1 = date),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Icon(Icons.male, size: 18), const SizedBox(width: 6), Text(AppLocalizations.of(context)?.male ?? 'Male')],
                    ),
                    selected: _gender1 == Gender.male,
                    onSelected: (_) => setState(() => _gender1 = Gender.male),
                    selectedColor: Colors.blue.shade200,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Icon(Icons.female, size: 18), const SizedBox(width: 6), Text(AppLocalizations.of(context)?.female ?? 'Female')],
                    ),
                    selected: _gender1 == Gender.female,
                    onSelected: (_) => setState(() => _gender1 = Gender.female),
                    selectedColor: Colors.pink.shade200,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            
            // Person 2
            Text(AppLocalizations.of(context)?.person ?? 'Person 2', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _name2Controller,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            _buildDatePicker(
              context: context,
              label: 'Birth Date',
              selectedDate: _dob2,
              onDateSelected: (date) => setState(() => _dob2 = date),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Icon(Icons.male, size: 18), const SizedBox(width: 6), Text(AppLocalizations.of(context)?.male ?? 'Male')],
                    ),
                    selected: _gender2 == Gender.male,
                    onSelected: (_) => setState(() => _gender2 = Gender.male),
                    selectedColor: Colors.blue.shade200,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ChoiceChip(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const Icon(Icons.female, size: 18), const SizedBox(width: 6), Text(AppLocalizations.of(context)?.female ?? 'Female')],
                    ),
                    selected: _gender2 == Gender.female,
                    onSelected: (_) => setState(() => _gender2 = Gender.female),
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
                onPressed: _calculate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite, size: 22),
                        const SizedBox(width: 10),
                        Text(AppLocalizations.of(context)?.translate('calculate_compatibility') ?? 'Calculate Compatibility', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return InkWell(
      onTap: () async {
        // On web, ensure the active input is unfocused before opening the picker
        FocusScope.of(context).unfocus();
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(1990, 1, 1),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) onDateSelected(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_month, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? label
                  : "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}",
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == null ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final result = _result!;
    
    Color scoreColor;
    String scoreText;
    IconData scoreIcon;
    
    if (result.overallScore >= 80) {
      scoreColor = Colors.green;
      scoreText = 'HIGHLY COMPATIBLE';
      scoreIcon = Icons.favorite;
    } else if (result.overallScore >= 60) {
      scoreColor = Colors.orange;
      scoreText = 'MODERATELY COMPATIBLE';
      scoreIcon = Icons.favorite_border;
    } else {
      scoreColor = Colors.red;
      scoreText = 'CHALLENGING MATCH';
      scoreIcon = Icons.warning;
    }

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '${result.person1Name} ❤️ ${result.person2Name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Overall score
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [scoreColor.withAlpha((0.2 * 255).round()), scoreColor.withAlpha((0.1 * 255).round())],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: scoreColor, width: 2),
              ),
              child: Column(
                children: [
                  Icon(scoreIcon, size: 48, color: scoreColor),
                  const SizedBox(height: 12),
                  Text(
                    '${result.overallScore}%',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: scoreColor),
                  ),
                  Text(
                    scoreText,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: scoreColor),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            // Detailed scores
            _buildScoreRow('Driver Match', result.driverMatch),
            _buildScoreRow('Life Path Match', result.conductorMatch),
            _buildScoreRow('Kua Match', result.kuaMatch),
            _buildScoreRow('Name Match', result.nameMatch),
            
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            
            // Strengths
            _buildSection(
              '💚 Strengths',
              result.strengths,
              Colors.green,
            ),
            
            const SizedBox(height: 16),
            
            // Challenges
            _buildSection(
              '⚠️ Challenges',
              result.challenges,
              Colors.orange,
            ),
            
            const SizedBox(height: 16),
            
            // Tips
            _buildSection(
              '💡 Relationship Tips',
              result.tips,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 15)),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: score / 100,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: score >= 80
                            ? [Colors.green, Colors.green.shade300]
                            : score >= 60
                                ? [Colors.orange, Colors.orange.shade300]
                                : [Colors.red, Colors.red.shade300],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 40,
            child: Text(
              '$score%',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha((0.3 * 255).round())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: color)),
                    Expanded(child: Text(item)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
