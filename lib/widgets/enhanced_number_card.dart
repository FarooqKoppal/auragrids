import 'package:flutter/material.dart';
import '../models/number_info.dart';

class EnhancedNumberCard extends StatelessWidget {
  final String title;
  final NumberInfo numberInfo;
  final IconData icon;

  const EnhancedNumberCard({
    super.key,
    required this.title,
    required this.numberInfo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color cardColor;
    if (numberInfo.isMasterNumber) {
      cardColor = Colors.amber;
    } else if (numberInfo.isKarmicDebt) {
      cardColor = Colors.deepOrange;
    } else {
      cardColor = Theme.of(context).primaryColor;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
                cardColor.withAlpha((0.15 * 255).round()),
                cardColor.withAlpha((0.05 * 255).round()),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cardColor.withAlpha((0.3 * 255).round()),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
                color: cardColor.withAlpha((0.2 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor.withAlpha((0.2 * 255).round()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: cardColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Text(
                numberInfo.displayValue,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cardColor,
                ),
              ),
            ],
          ),
          // Quality Rating Badge
          if (numberInfo.quality != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                    color: _getQualityColor(numberInfo.quality!).withAlpha((0.2 * 255).round()),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                      color: _getQualityColor(numberInfo.quality!).withAlpha((0.5 * 255).round()),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getQualityIcon(numberInfo.quality!),
                    size: 14,
                    color: _getQualityColor(numberInfo.quality!),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    numberInfo.quality!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getQualityColor(numberInfo.quality!),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (numberInfo.isMasterNumber || numberInfo.isKarmicDebt) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                    color: cardColor.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    numberInfo.isMasterNumber ? Icons.auto_awesome : Icons.warning_amber,
                    color: cardColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      numberInfo.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 8),
            Text(
              numberInfo.description,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Color _getQualityColor(String quality) {
    switch (quality) {
      case 'Outstanding':
        return Colors.purple;
      case 'Excellent':
        return Colors.green;
      case 'Very Good':
        return Colors.blue;
      case 'Good':
        return Colors.teal;
      case 'Avoid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  IconData _getQualityIcon(String quality) {
    switch (quality) {
      case 'Outstanding':
        return Icons.star;
      case 'Excellent':
        return Icons.verified;
      case 'Very Good':
        return Icons.thumb_up;
      case 'Good':
        return Icons.check_circle;
      case 'Avoid':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }
}

class NameAnalysisCard extends StatelessWidget {
  final String fullName;
  final NameAnalysis analysis;

  const NameAnalysisCard({
    super.key,
    required this.fullName,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Theme.of(context).primaryColor, size: 24),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Complete Name Analysis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            EnhancedNumberCard(
              title: 'Expression (Full Name)',
              numberInfo: analysis.fullName,
              icon: Icons.badge,
            ),
            
            if (fullName.trim().contains(' ')) ...[
              EnhancedNumberCard(
                title: 'First Name Vibration',
                numberInfo: analysis.firstName,
                icon: Icons.person_outline,
              ),
              
              EnhancedNumberCard(
                title: 'Family Legacy (Last Name)',
                numberInfo: analysis.lastName,
                icon: Icons.family_restroom,
              ),
            ],
            
            EnhancedNumberCard(
              title: 'Soul Urge (Inner Desire)',
              numberInfo: analysis.soulUrge,
              icon: Icons.favorite,
            ),
            
            EnhancedNumberCard(
              title: 'Personality (Outer Image)',
              numberInfo: analysis.personality,
              icon: Icons.visibility,
            ),
            
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                    color: Colors.blue.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withAlpha((0.3 * 255).round())),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Soul Urge = What you want inside | Personality = What others see | Expression = What you do',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
