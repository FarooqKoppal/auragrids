import 'package:flutter/material.dart';
import '../models/number_info.dart';
import '../l10n/app_localizations.dart';

class GridAnalysisCard extends StatelessWidget {
  final GridAnalysis analysis;

  const GridAnalysisCard({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  l10n.gridFrequencyAnalysis,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Explanation banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withAlpha((0.3 * 255).round())),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.gridExplanation,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Excessive numbers
            if (analysis.excessiveNumbers.isNotEmpty) ...[
              _buildSectionHeader(l10n.excessiveNumbers, Colors.red),
              const SizedBox(height: 12),
              ...analysis.excessiveNumbers.map((n) => _buildNumberImpact(
                context,
                n,
                analysis.grid[n]!,
                analysis.numberImpacts[n]!,
                Colors.red,
              )),
              const SizedBox(height: 16),
            ],
            
            // Balanced numbers
            if (analysis.balancedNumbers.isNotEmpty) ...[
              _buildSectionHeader(l10n.balancedNumbers, Colors.green),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: analysis.balancedNumbers.map((n) => Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(n.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  label: Text(l10n.appearsTimes.replaceAll('{count}', '${analysis.grid[n]}')),
                  backgroundColor: Colors.green.withAlpha((0.1 * 255).round()),
                )).toList(),
              ),
              const SizedBox(height: 16),
            ],
            
            // Missing numbers
            if (analysis.missingNumbers.isNotEmpty) ...[
              _buildSectionHeader(l10n.missingNumbers, Colors.orange),
              const SizedBox(height: 12),
              ...analysis.missingNumbers.map((n) => _buildNumberImpact(
                context,
                n,
                0,
                analysis.numberImpacts[n]!,
                Colors.orange,
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildNumberImpact(
    BuildContext context,
    int number,
    int count,
    String impact,
    Color color,
  ) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha((0.3 * 255).round()), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withAlpha((0.2 * 255).round()),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Number $number',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withAlpha((0.2 * 255).round()),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color.withAlpha((0.5 * 255).round())),
                          ),
                          child: Text(
                            count == 0 ? '✗' : 'x$count',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                        if (count >= 5) ...[
                          const SizedBox(width: 4),
                          const Text('⚠️', style: TextStyle(fontSize: 14)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      impact,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (count >= 5) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.tips_and_updates, size: 16, color: Colors.blue),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _getBalanceTip(number),
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getBalanceTip(int num) {
    switch (num) {
      case 1:
        return 'Balance tip: Practice listening and teamwork';
      case 2:
        return 'Balance tip: Build confidence, make decisions';
      case 3:
        return 'Balance tip: Focus energy on one project at a time';
      case 4:
        return 'Balance tip: Allow flexibility, avoid rigidity';
      case 5:
        return 'Balance tip: Create routines, finish what you start';
      case 6:
        return 'Balance tip: Set boundaries, don\'t over-give';
      case 7:
        return 'Balance tip: Engage with others, avoid isolation';
      case 8:
        return 'Balance tip: Balance material and spiritual pursuits';
      case 9:
        return 'Balance tip: Self-care is important too';
      default:
        return 'Balance is key';
    }
  }
}

class ArrowPatternsCard extends StatelessWidget {
  final List<ArrowPattern> patterns;

  const ArrowPatternsCard({super.key, required this.patterns});

  @override
  Widget build(BuildContext context) {
    if (patterns.isEmpty) return const SizedBox.shrink();

    final strengths = patterns.where((p) => p.type == 'strength').toList();
    final challenges = patterns.where((p) => p.type == 'challenge').toList();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)?.arrowPatterns ?? 'Arrow Patterns Detected',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            if (strengths.isNotEmpty) ...[
              Text(
                '🎯 Strength Arrows',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 12),
              ...strengths.map((pattern) => _buildArrowPattern(context, pattern)),
              const SizedBox(height: 16),
            ],
            
            if (challenges.isNotEmpty) ...[
              Text(
                '⚠️ Challenge Arrows',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              const SizedBox(height: 12),
              ...challenges.map((pattern) => _buildArrowPattern(context, pattern)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArrowPattern(BuildContext context, ArrowPattern pattern) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = pattern.type == 'strength' ? Colors.green : Colors.orange;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha((0.3 * 255).round())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                pattern.type == 'strength' ? Icons.check_circle : Icons.warning_amber,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pattern.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Numbers: ', style: TextStyle(fontSize: 13)),
              ...pattern.numbers.asMap().entries.map((entry) {
                final idx = entry.key;
                final num = entry.value;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withAlpha((0.2 * 255).round()),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        num.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    if (idx < pattern.numbers.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text('•', style: TextStyle(color: Colors.grey.shade400)),
                      ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pattern.impact,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb, size: 16, color: Colors.blue),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    pattern.solution,
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
