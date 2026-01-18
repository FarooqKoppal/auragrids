import 'package:flutter_test/flutter_test.dart';
import 'package:auragrids/utils/mobile_analyzer.dart';

void main() {
  test('analyzeMobileAdvanced detects multiple 8s and missing digits', () {
    final res = MobileAnalyzer.analyzeMobileAdvanced('8881234567');
    expect(res.frequency[8], 3);
    expect(res.warnings.any((w) => w.contains('Multiple 8s')), true);

    final res2 = MobileAnalyzer.analyzeMobileAdvanced('1234567890');
    expect(res2.missingDigits.isEmpty, true);
  });
}
