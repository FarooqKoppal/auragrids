import '../models/number_info.dart';
import 'enhanced_calculator.dart';

class MobileNumberAnalysis {
  final String mobileNumber;
  final NumberInfo mobileNumberInfo;
  final int compatibilityScore;
  final String compatibility;
  final List<String> strengths;
  final List<String> weaknesses;
  final List<String> suggestions;
  final List<String> betterNumbers;
  
  MobileNumberAnalysis({
    required this.mobileNumber,
    required this.mobileNumberInfo,
    required this.compatibilityScore,
    required this.compatibility,
    required this.strengths,
    required this.weaknesses,
    required this.suggestions,
    required this.betterNumbers,
  });
}

class MobileAdvancedAnalysis {
  final Map<int,int> frequency;
  final List<int> missingDigits;
  final List<String> warnings;

  MobileAdvancedAnalysis({
    required this.frequency,
    required this.missingDigits,
    required this.warnings,
  });
}

class MobileAnalyzer {
  // Analyze mobile number compatibility with birth numbers
  static MobileNumberAnalysis analyzeMobileNumber(
    String mobile,
    int driverNumber,
    int conductorNumber,
  ) {
    // Clean mobile number (remove spaces, dashes, etc.)
    String cleanMobile = mobile.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Calculate mobile number (sum of all digits)
    int sum = 0;
    for (var char in cleanMobile.split('')) {
      sum += int.parse(char);
    }
    
    NumberInfo mobileInfo = EnhancedCalculator.reduceWithMaster(sum);
    int mobileNum = mobileInfo.reducedValue;
    
    // Calculate compatibility
    int score = _calculateCompatibilityScore(mobileNum, driverNumber, conductorNumber, mobileInfo);
    String compatibilityLevel = _getCompatibilityLevel(score);
    
    // Analyze strengths and weaknesses
    List<String> strengths = _getStrengths(mobileNum, driverNumber, conductorNumber, mobileInfo);
    List<String> weaknesses = _getWeaknesses(mobileNum, driverNumber, conductorNumber, mobileInfo);
    List<String> suggestions = _getSuggestions(score, mobileNum, driverNumber, conductorNumber);
    
    // Generate better number suggestions
    List<String> betterNumbers = _generateBetterNumbers(cleanMobile, driverNumber, conductorNumber, score);
    
    return MobileNumberAnalysis(
      mobileNumber: cleanMobile,
      mobileNumberInfo: mobileInfo,
      compatibilityScore: score,
      compatibility: compatibilityLevel,
      strengths: strengths,
      weaknesses: weaknesses,
      suggestions: suggestions,
      betterNumbers: betterNumbers,
    );
  }
  
  static int _calculateCompatibilityScore(int mobileNum, int driver, int conductor, NumberInfo info) {
    int score = 50;
    
    // Master number bonus
    if (info.isMasterNumber) score += 25;
    
    // Perfect match with driver
    if (mobileNum == driver) {
      score += 20;
    } else if (_areCompatible(mobileNum, driver)) {
      score += 10;
    } else if (_areConflicting(mobileNum, driver)) {
      score -= 15;
    }
    
    // Perfect match with conductor
    if (mobileNum == conductor) {
      score += 20;
    } else if (_areCompatible(mobileNum, conductor)) {
      score += 10;
    } else if (_areConflicting(mobileNum, conductor)) {
      score -= 15;
    }
    
    // Lucky numbers bonus
    if ([1, 3, 5, 6, 9].contains(mobileNum)) score += 10;
    
    // Karmic debt penalty
    if (info.isKarmicDebt) score -= 20;
    
    // Unlucky numbers
    if ([4, 8].contains(mobileNum)) score -= 10;
    
    return score.clamp(0, 100);
  }
  
  static String _getCompatibilityLevel(int score) {
    if (score >= 85) return 'Excellent ⭐⭐⭐⭐⭐';
    if (score >= 70) return 'Very Good ⭐⭐⭐⭐';
    if (score >= 55) return 'Good ⭐⭐⭐';
    if (score >= 40) return 'Fair ⭐⭐';
    return 'Poor ⭐';
  }
  
  static List<String> _getStrengths(int mobileNum, int driver, int conductor, NumberInfo info) {
    List<String> strengths = [];
    
    if (info.isMasterNumber) {
      strengths.add('🌟 Master Number ${info.originalValue} - Powerful spiritual energy');
    }
    
    if (mobileNum == driver) {
      strengths.add('✅ Perfect match with Driver - Enhances personality');
    } else if (_areCompatible(mobileNum, driver)) {
      strengths.add('✓ Compatible with Driver - Harmonious energy');
    }
    
    if (mobileNum == conductor) {
      strengths.add('✅ Perfect match with Conductor - Aligns with destiny');
    } else if (_areCompatible(mobileNum, conductor)) {
      strengths.add('✓ Compatible with Conductor - Supports life path');
    }
    
    if ([1, 3, 5, 6, 9].contains(mobileNum)) {
      strengths.add('💫 Lucky number $mobileNum - Brings prosperity');
    }
    
    return strengths;
  }
  
  static List<String> _getWeaknesses(int mobileNum, int driver, int conductor, NumberInfo info) {
    List<String> weaknesses = [];
    
    if (info.isKarmicDebt) {
      weaknesses.add('⚠️ Karmic Debt ${info.originalValue} - Past-life lessons to overcome');
    }
    
    if (_areConflicting(mobileNum, driver)) {
      weaknesses.add('❌ Conflicts with Driver - May hinder self-expression');
    }
    
    if (_areConflicting(mobileNum, conductor)) {
      weaknesses.add('❌ Conflicts with Conductor - May create obstacles in destiny');
    }
    
    if ([4, 8].contains(mobileNum)) {
      weaknesses.add('⚠️ Challenging number $mobileNum - Requires extra effort');
    }
    
    if (mobileNum == 7) {
      weaknesses.add('ℹ️ Number 7 is neutral - Spiritual but isolated energy');
    }
    
    return weaknesses;
  }
  
  static List<String> _getSuggestions(int score, int mobileNum, int driver, int conductor) {
    List<String> suggestions = [];
    
    if (score >= 70) {
      suggestions.add('Your mobile number is well-suited for you! Continue using it.');
    } else if (score >= 50) {
      suggestions.add('Your mobile number is acceptable but could be improved.');
      suggestions.add('Consider changing the last digit for better alignment.');
    } else {
      suggestions.add('Your mobile number has significant conflicts.');
      suggestions.add('Strongly consider changing to a more compatible number.');
      suggestions.add('Check the suggested better numbers below.');
    }
    
    return suggestions;
  }
  
  static List<String> _generateBetterNumbers(String currentMobile, int driver, int conductor, int currentScore) {
    if (currentScore >= 70) return []; // Current number is good enough
    
    List<String> suggestions = [];
    
    // Try changing last digit to match driver or conductor
    if (currentMobile.length >= 10) {
      String prefix = currentMobile.substring(0, currentMobile.length - 1);
      
      // Try driver number
      String withDriver = prefix + driver.toString();
      suggestions.add('$withDriver (ends with Driver $driver)');
      
      // Try conductor number
      if (conductor != driver) {
        String withConductor = prefix + conductor.toString();
        suggestions.add('$withConductor (ends with Conductor $conductor)');
      }
      
      // Try lucky numbers
      for (int lucky in [1, 3, 5, 6, 9]) {
        if (lucky != driver && lucky != conductor) {
          String withLucky = prefix + lucky.toString();
          int testSum = _sumDigits(withLucky);
          NumberInfo testInfo = EnhancedCalculator.reduceWithMaster(testSum);
          int testScore = _calculateCompatibilityScore(testInfo.reducedValue, driver, conductor, testInfo);
          
          if (testScore > currentScore + 15) {
            suggestions.add('$withLucky (Lucky number $lucky, Score: $testScore%)');
            if (suggestions.length >= 5) break;
          }
        }
      }
    }
    
    return suggestions.take(5).toList();
  }

  // New advanced analyzer (frequency + missing digits + warnings)
  static MobileAdvancedAnalysis analyzeMobileAdvanced(String mobile) {
    final String clean = mobile.replaceAll(RegExp(r'[^0-9]'), '');
    final Map<int,int> freq = {for (var i=0;i<=9;i++) i:0};
    for (var ch in clean.split('')) {
      final d = int.tryParse(ch);
      if (d != null) freq[d] = (freq[d] ?? 0) + 1;
    }

    final missing = <int>[];
    for (var i = 1; i <= 9; i++) {
      if ((freq[i] ?? 0) == 0) missing.add(i);
    }

    final warnings = <String>[];
    if ((freq[6] ?? 0) > 1) warnings.add('Multiple 6s detected — may indicate conflict/enemy dynamics (per video rules).');
    if ((freq[8] ?? 0) > 1) warnings.add('Multiple 8s detected — video warns of increased surgical/trauma risk.');

    // Example cluster rule: missing 1,3,6
    if ([1,3,6].every((n) => (freq[n] ?? 0) == 0)) {
      warnings.add('Digits 1,3,6 all missing — difficulty in seizing new opportunities.');
    }

    final missingInterpretations = <int,String>{
      3: 'Missing 3: possible issues with documentation, communication or legal matters.',
      5: 'Missing 5: potential child-related or fertility concerns noted in some traditions.',
      1: 'Missing 1: lack of initiative or leadership energy.',
      // add other mappings per video guidance
    };

    for (var m in missing) {
      if (missingInterpretations.containsKey(m)) warnings.add('Missing $m: ${missingInterpretations[m]}');
    }

    return MobileAdvancedAnalysis(frequency: freq, missingDigits: missing, warnings: warnings);
  }
  
  static int _sumDigits(String number) {
    int sum = 0;
    for (var char in number.split('')) {
      sum += int.parse(char);
    }
    return sum;
  }
  
  static bool _areCompatible(int n1, int n2) {
    const compatible = {
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
    
    return compatible[n1]?.contains(n2) ?? false;
  }
  
  static bool _areConflicting(int n1, int n2) {
    const conflicts = {
      1: [4, 8],
      2: [5],
      3: [4, 8],
      4: [1, 2, 3, 5, 9],
      5: [2, 4, 8],
      6: [1],
      7: [1, 2, 3, 4, 5, 6, 8, 9], // 7 is solitary
      8: [1, 2, 3, 5, 9],
      9: [4, 8],
    };
    
    return conflicts[n1]?.contains(n2) ?? false;
  }
}
