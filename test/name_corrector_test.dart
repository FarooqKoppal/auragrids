import 'package:flutter_test/flutter_test.dart';
import 'package:auragrids/utils/name_corrector.dart';

void main() {
  test('NameCorrector suggestions do not end with B, K, or R', () {
    final suggestions = NameCorrector.analyzeName('Deepak', 3, 5);
    for (var s in suggestions) {
      final last = s.suggestedName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
      if (last.isNotEmpty) {
        final lastChar = last[last.length - 1];
        expect(['B', 'K', 'R'].contains(lastChar), false,
            reason: 'Suggested name ${s.suggestedName} ends with inauspicious $lastChar');
      }
    }
  });
}
