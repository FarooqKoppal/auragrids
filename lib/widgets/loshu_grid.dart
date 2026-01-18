import 'package:flutter/material.dart';

class LoShuGrid extends StatelessWidget {
  final Map<int, int> gridData;
  final int kuaNumber;

  const LoShuGrid({
    super.key,
    required this.gridData,
    required this.kuaNumber,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> gridOrder = [4, 9, 2, 3, 5, 7, 8, 1, 6];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Explanation banner
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
                color: Colors.amber.withAlpha((0.1 * 255).round()),
            borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withAlpha((0.3 * 255).round())),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Date digits + Driver (if day≥10) + Conductor + Kua',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1A1A1A), const Color(0xFF2D2D2D)]
                    : [const Color(0xFF00332B), const Color(0xFF004D40)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.amber, width: 3),
              boxShadow: [
                BoxShadow(
                      color: Colors.amber.withAlpha((0.3 * 255).round()),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SizedBox(
              width: 240,
                child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: 9,
                itemBuilder: (context, i) {
                  int n = gridOrder[i];
                  int count = gridData[n] ?? 0;
                  bool isKua = (n == kuaNumber);
                  bool hasValue = count > 0;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: hasValue
                          ? (isKua
                              ? Colors.amber.shade700
                              : const Color(0xFF00796B))
                              : Colors.white.withAlpha((0.08 * 255).round()),
                          borderRadius: BorderRadius.circular(15),
                      border: isKua
                          ? Border.all(color: Colors.amberAccent, width: 3)
                          : null,
                      boxShadow: hasValue
                          ? [
                              BoxShadow(
                                color: (isKua ? Colors.amber : Colors.teal)
                                        .withAlpha((0.5 * 255).round()),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: hasValue
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$n",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: isKua ? Colors.black : Colors.amber,
                                  ),
                                ),
                                if (count > 1)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                           color: Colors.white.withAlpha((0.3 * 255).round()),
                                          borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "×$count",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isKua ? Colors.black : Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Text(
                              "",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withAlpha((0.3 * 255).round()),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
