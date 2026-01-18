import 'package:flutter/material.dart';
import '../calculator.dart';
import '../l10n/app_localizations.dart';
import '../utils/localized_data.dart';

class LuckyCompassCard extends StatelessWidget {
  final int driver;

  const LuckyCompassCard({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final factors = AuraCalculator.getLuckyFactors(driver);
    final colorCodes = AuraCalculator.getLuckyColorObjects(driver);
    final List<Color> colors = colorCodes.map((code) => Color(code as int)).toList();
    
    return Card(
      elevation: 6,
  shadowColor: Colors.amber.withAlpha((0.5 * 255).round()),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.amber, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade50, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.amber.shade900, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    l10n.luckyCompass,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.teal.shade900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 2, color: Colors.amber),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _luckyItem(
                    context,
                    _buildColorDisplay(colors),
                    l10n.luckyColors,
                    LocalizedData.getColors(l10n, factors['color']),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: Colors.amber.shade300,
                  ),
                  _luckyItem(
                    context,
                    Icon(Icons.calendar_today, color: Colors.teal.shade900, size: 28),
                    l10n.luckyDay,
                    LocalizedData.getDay(l10n, factors['day']),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: Colors.amber.shade300,
                  ),
                  _luckyItem(
                    context,
                    Icon(Icons.explore, color: Colors.teal.shade900, size: 28),
                    l10n.direction,
                    LocalizedData.getDirection(l10n, factors['direction']),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorDisplay(List<Color> colors) {
    if (colors.isEmpty) {
      return Icon(Icons.palette, color: Colors.teal.shade900, size: 28);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: colors.map((color) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.2 * 255).round()),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _luckyItem(BuildContext context, Widget icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.teal.shade900,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
