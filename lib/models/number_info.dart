// Models for enhanced numerology data

class NumberInfo {
  final int reducedValue;
  final int originalValue;
  final bool isMasterNumber;
  final bool isKarmicDebt;
  final String displayValue;
  final String? quality; // Outstanding, Excellent, Very Good, Good, Avoid
  
  NumberInfo({
    required this.reducedValue,
    required this.originalValue,
    this.isMasterNumber = false,
    this.isKarmicDebt = false,
  }) : displayValue = _getDisplayValue(originalValue, reducedValue, isMasterNumber, isKarmicDebt),
       quality = _getQualityRating(originalValue);
  
  static String _getDisplayValue(int original, int reduced, bool isMaster, bool isKarmic) {
    if (original == reduced) return reduced.toString();
    
    String suffix = '';
    if (isMaster) suffix = ' ✨';
    if (isKarmic) suffix = ' ⚠️';
    
    return '$original/$reduced$suffix';
  }
  
  static String? _getQualityRating(int num) {
    // Only rate double-digit numbers (10+)
    if (num < 10) return null;
    
    // Outstanding - Best possible numbers
    if ([10, 19, 28, 37, 46].contains(num)) return 'Outstanding';
    
    // Excellent - Very favorable
    if ([11, 20, 29, 38, 47].contains(num)) return 'Excellent';
    
    // Very Good - Favorable
    if ([12, 21, 30, 39, 48].contains(num)) return 'Very Good';
    
    // Good - Positive
    if ([13, 22, 31, 40, 49].contains(num)) return 'Good';
    
    // Avoid - Challenging (karmic lessons)
    if ([14, 16, 18, 26, 34, 43].contains(num)) return 'Avoid';
    
    // Numbers not in standard rating lists
    return null;
  }
  
  String get description {
    if (isMasterNumber) {
      return _getMasterNumberDescription(originalValue);
    }
    if (isKarmicDebt) {
      return _getKarmicDebtDescription(originalValue);
    }
    return _getSingleDigitDescription(reducedValue);
  }
  
  static String _getMasterNumberDescription(int num) {
    switch (num) {
      case 11:
        return 'Master Number 11: The Illuminator - Spiritual insight, intuition, psychic abilities';
      case 22:
        return 'Master Number 22: The Master Builder - Manifesting big dreams into reality';
      case 33:
        return 'Master Number 33: The Master Teacher - Compassion, healing, blessing to humanity';
      default:
        return '';
    }
  }
  
  static String _getKarmicDebtDescription(int num) {
    switch (num) {
      case 13:
        return 'Karmic Debt 13: Past life laziness - Must work hard this lifetime';
      case 14:
        return 'Karmic Debt 14: Abused freedom - Must find balance and moderation';
      case 16:
        return 'Karmic Debt 16: Ego and pride - Must practice humility and service';
      case 19:
        return 'Karmic Debt 19: Misused power - Must learn to serve rather than dominate';
      default:
        return '';
    }
  }
  
  static String _getSingleDigitDescription(int num) {
    switch (num) {
      case 1:
        return 'Leadership, independence, innovation';
      case 2:
        return 'Cooperation, diplomacy, sensitivity';
      case 3:
        return 'Creativity, expression, joy';
      case 4:
        return 'Stability, hard work, discipline';
      case 5:
        return 'Freedom, change, adventure';
      case 6:
        return 'Responsibility, nurturing, harmony';
      case 7:
        return 'Spirituality, analysis, wisdom';
      case 8:
        return 'Power, money, material success';
      case 9:
        return 'Completion, compassion, humanitarianism';
      default:
        return '';
    }
  }
}

class NameAnalysis {
  final NumberInfo fullName;
  final NumberInfo firstName;
  final NumberInfo lastName;
  final NumberInfo soulUrge;
  final NumberInfo personality;
  
  NameAnalysis({
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.soulUrge,
    required this.personality,
  });
}

class GridAnalysis {
  final Map<int, int> grid;
  final List<int> missingNumbers;
  final List<int> excessiveNumbers;
  final List<int> balancedNumbers;
  final Map<int, String> numberImpacts;
  
  GridAnalysis({
    required this.grid,
    required this.missingNumbers,
    required this.excessiveNumbers,
    required this.balancedNumbers,
    required this.numberImpacts,
  });
}

class ArrowPattern {
  final String name;
  final List<int> numbers;
  final String type; // 'strength' or 'challenge'
  final String impact;
  final String solution;
  
  ArrowPattern({
    required this.name,
    required this.numbers,
    required this.type,
    required this.impact,
    required this.solution,
  });
}

class CompatibilityResult {
  final String person1Name;
  final String person2Name;
  final int overallScore;
  final int driverMatch;
  final int conductorMatch;
  final int kuaMatch;
  final int nameMatch;
  final List<String> strengths;
  final List<String> challenges;
  final List<String> tips;
  
  CompatibilityResult({
    required this.person1Name,
    required this.person2Name,
    required this.overallScore,
    required this.driverMatch,
    required this.conductorMatch,
    required this.kuaMatch,
    required this.nameMatch,
    required this.strengths,
    required this.challenges,
    required this.tips,
  });
}
