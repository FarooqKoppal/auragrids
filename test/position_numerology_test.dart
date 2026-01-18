import 'package:flutter_test/flutter_test.dart';
import 'package:auragrids/utils/position_numerology.dart';

void main() {
  test('analyzeNamePosition recognizes Rahu starters and dangerous endings', () {
    final res1 = analyzeNamePosition('Deepak');
    expect(res1.firstLetter, 'D');
    expect(res1.flags.any((f) => f.contains('Rahu-like')), true);

    final res2 = analyzeNamePosition('ArunB');
    expect(res2.lastLetter, 'B');
    expect(res2.flags.any((f) => f.contains('flagged as risky')), true);
  });
}
