import '../models/number_info.dart';
import '../calculator.dart';

class EnhancedCalculator {
  // Master number detection
  static bool isMasterNumber(int n) {
    return n == 11 || n == 22 || n == 33;
  }
  
  // Karmic debt detection
  static bool isKarmicDebt(int n) {
    return n == 13 || n == 14 || n == 16 || n == 19;
  }
  
  // Enhanced reduction that preserves master numbers
  static NumberInfo reduceWithMaster(int n) {
    int original = n;
    
    // Check for master numbers before reduction
    if (isMasterNumber(n)) {
      int reduced = _reduceSingle(n);
      return NumberInfo(
        originalValue: n,
        reducedValue: reduced,
        isMasterNumber: true,
      );
    }
    
    // Check for karmic debt before reduction
    if (isKarmicDebt(n)) {
      int reduced = _reduceSingle(n);
      return NumberInfo(
        originalValue: n,
        reducedValue: reduced,
        isKarmicDebt: true,
      );
    }
    
    // Regular reduction
    while (n > 9) {
      int sum = 0;
      for (var char in n.toString().split('')) {
        sum += int.parse(char);
      }
      n = sum;
      
      // Check if we hit a master or karmic number during reduction
      if (isMasterNumber(n)) {
        return NumberInfo(
          originalValue: original,
          reducedValue: _reduceSingle(n),
          isMasterNumber: true,
        );
      }
      if (isKarmicDebt(n)) {
        return NumberInfo(
          originalValue: original,
          reducedValue: _reduceSingle(n),
          isKarmicDebt: true,
        );
      }
    }
    
    return NumberInfo(
      originalValue: original,
      reducedValue: n,
    );
  }
  
  static int _reduceSingle(int n) {
    while (n > 9) {
      int sum = 0;
      for (var char in n.toString().split('')) {
        sum += int.parse(char);
      }
      n = sum;
    }
    return n;
  }
  
  // Calculate driver number with master number support
  static NumberInfo getDriverNumberInfo(int day) {
    return reduceWithMaster(day);
  }
  
  // Calculate conductor number with master number support
  static NumberInfo getConductorNumberInfo(int d, int m, int y) {
    return reduceWithMaster(d + m + y);
  }
  
  // Enhanced name analysis - Full breakdown
  static NameAnalysis analyzeFullName(String fullName) {
    // Split name into parts
    List<String> parts = fullName.trim().split(' ');
    String firstName = parts.isNotEmpty ? parts[0] : '';
    String lastName = parts.length > 1 ? parts.last : '';
    
    // Calculate all numbers
    NumberInfo full = calculateNameNumberInfo(fullName);
    NumberInfo first = calculateNameNumberInfo(firstName);
    NumberInfo last = calculateNameNumberInfo(lastName);
    NumberInfo soul = calculateSoulUrgeNumber(fullName);
    NumberInfo personality = calculatePersonalityNumber(fullName);
    
    return NameAnalysis(
      fullName: full,
      firstName: first,
      lastName: last,
      soulUrge: soul,
      personality: personality,
    );
  }
  
  // Calculate name number with master number support
  static NumberInfo calculateNameNumberInfo(String name) {
    const chaldean = {
      'A':1,'I':1,'J':1,'Q':1,'Y':1, 'B':2,'K':2,'R':2, 'C':3,'G':3,'L':3,'S':3,
      'D':4,'M':4,'T':4, 'E':5,'H':5,'N':5,'X':5, 'U':6,'V':6,'W':6, 'O':7,'Z':7, 'F':8,'P':8
    };
    int total = 0;
    for (var char in name.toUpperCase().split('')) {
      total += chaldean[char] ?? 0;
    }
    return reduceWithMaster(total);
  }
  
  // Soul Urge Number (vowels only)
  static NumberInfo calculateSoulUrgeNumber(String name) {
    const chaldean = {
      'A':1,'I':1,'J':1,'Q':1,'Y':1, 'B':2,'K':2,'R':2, 'C':3,'G':3,'L':3,'S':3,
      'D':4,'M':4,'T':4, 'E':5,'H':5,'N':5,'X':5, 'U':6,'V':6,'W':6, 'O':7,'Z':7, 'F':8,'P':8
    };
    const vowels = {'A', 'E', 'I', 'O', 'U'};
    
    int total = 0;
    for (var char in name.toUpperCase().split('')) {
      if (vowels.contains(char)) {
        total += chaldean[char] ?? 0;
      }
    }
    return reduceWithMaster(total);
  }
  
  // Personality Number (consonants only)
  static NumberInfo calculatePersonalityNumber(String name) {
    const chaldean = {
      'A':1,'I':1,'J':1,'Q':1,'Y':1, 'B':2,'K':2,'R':2, 'C':3,'G':3,'L':3,'S':3,
      'D':4,'M':4,'T':4, 'E':5,'H':5,'N':5,'X':5, 'U':6,'V':6,'W':6, 'O':7,'Z':7, 'F':8,'P':8
    };
    const vowels = {'A', 'E', 'I', 'O', 'U'};
    
    int total = 0;
    for (var char in name.toUpperCase().split('')) {
      if (!vowels.contains(char)) {
        total += chaldean[char] ?? 0;
      }
    }
    return reduceWithMaster(total);
  }
  
  // Analyze grid for missing/excessive numbers
  static GridAnalysis analyzeGrid(Map<int, int> grid) {
    List<int> missing = [];
    List<int> excessive = [];
    List<int> balanced = [];
    Map<int, String> impacts = {};
    
    for (int i = 1; i <= 9; i++) {
      int count = grid[i] ?? 0;
      
      if (count == 0) {
        missing.add(i);
        impacts[i] = _getMissingImpact(i);
      } else if (count >= 5) {
        excessive.add(i);
        impacts[i] = _getExcessiveImpact(i);
      } else if (count >= 2 && count <= 3) {
        balanced.add(i);
        impacts[i] = 'Balanced presence - Good!';
      }
    }
    
    return GridAnalysis(
      grid: grid,
      missingNumbers: missing,
      excessiveNumbers: excessive,
      balancedNumbers: balanced,
      numberImpacts: impacts,
    );
  }
  
  static String _getMissingImpact(int num) {
    switch (num) {
      case 1:
        return 'Lack of confidence, leadership struggles, low self-esteem';
      case 2:
        return 'Insensitivity, difficulty in relationships, poor cooperation';
      case 3:
        return 'Communication issues, lack of creativity, pessimism';
      case 4:
        return 'Disorganization, lack of discipline, unstable foundations';
      case 5:
        return 'Fear of change, routine-bound, lack of adventure';
      case 6:
        return 'Family issues, avoiding responsibility, imbalance';
      case 7:
        return 'Spiritual disconnect, poor analysis, lack of wisdom';
      case 8:
        return 'Financial struggles, weak manifestation, avoid materialism';
      case 9:
        return 'Selfishness, lack of compassion, incomplete cycles';
      default:
        return '';
    }
  }
  
  static String _getExcessiveImpact(int num) {
    switch (num) {
      case 1:
        return 'Too much ego, stubbornness, domineering behavior';
      case 2:
        return 'Over-sensitivity, dependency, indecisiveness';
      case 3:
        return 'Scattered energy, gossip, superficiality';
      case 4:
        return 'Rigidity, narrow-mindedness, workaholic';
      case 5:
        return 'Restlessness, instability, impulsiveness';
      case 6:
        return 'Interference, worrying, self-sacrifice';
      case 7:
        return 'Isolation, overthinking, cynicism';
      case 8:
        return 'Greed, materialism, power hunger';
      case 9:
        return 'Martyrdom, emotional drama, giving too much';
      default:
        return '';
    }
  }
  
  // Detect arrow patterns
  static List<ArrowPattern> detectArrowPatterns(Map<int, int> grid) {
    List<ArrowPattern> patterns = [];
    
    // Strength arrows (present numbers)
    if (grid.containsKey(1) && grid.containsKey(5) && grid.containsKey(9)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Determination',
        numbers: [1, 5, 9],
        type: 'strength',
        impact: 'Strong willpower, goal-oriented, natural leader',
        solution: 'Use this strength to achieve great things!',
      ));
    }
    
    if (grid.containsKey(3) && grid.containsKey(5) && grid.containsKey(7)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Spirituality',
        numbers: [3, 5, 7],
        type: 'strength',
        impact: 'Deep spiritual insights, strong intuition, healing abilities',
        solution: 'Trust your inner wisdom and spiritual path',
      ));
    }
    
    if (grid.containsKey(1) && grid.containsKey(2) && grid.containsKey(3)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Planning',
        numbers: [1, 2, 3],
        type: 'strength',
        impact: 'Excellent at planning and organizing',
        solution: 'Use planning skills for personal and professional growth',
      ));
    }
    
    // Challenge arrows (missing numbers)
    if (!grid.containsKey(4) && !grid.containsKey(9) && !grid.containsKey(2)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Frustration',
        numbers: [4, 9, 2],
        type: 'challenge',
        impact: 'Difficulty with planning, impatience, poor organization',
        solution: 'Use calendars, to-do lists, ask for help with details',
      ));
    }
    
    if (!grid.containsKey(2) && !grid.containsKey(5) && !grid.containsKey(8)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Emotional Sensitivity',
        numbers: [2, 5, 8],
        type: 'challenge',
        impact: 'Over-emotional or emotionally numb, mood swings',
        solution: 'Practice meditation, emotional balance exercises',
      ));
    }
    
    if (!grid.containsKey(4) && !grid.containsKey(5) && !grid.containsKey(6)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Poor Memory',
        numbers: [4, 5, 6],
        type: 'challenge',
        impact: 'Memory issues, difficulty concentrating',
        solution: 'Write things down, use reminders, practice memory games',
      ));
    }
    
    if (!grid.containsKey(1) && !grid.containsKey(2) && !grid.containsKey(3)) {
      patterns.add(ArrowPattern(
        name: 'Arrow of Confusion',
        numbers: [1, 2, 3],
        type: 'challenge',
        impact: 'Difficulty expressing thoughts clearly',
        solution: 'Practice clear communication, think before speaking',
      ));
    }
    
    return patterns;
  }
  
  // Calculate compatibility between two people
  static CompatibilityResult calculateCompatibility({
    required String name1,
    required DateTime dob1,
    required Gender gender1,
    required String name2,
    required DateTime dob2,
    required Gender gender2,
  }) {
    // Calculate numbers for person 1
    int driver1 = AuraCalculator.getDriverNumber(dob1.day);
    int conductor1 = AuraCalculator.getConductorNumber(dob1.day, dob1.month, dob1.year);
    int kua1 = AuraCalculator.calculateKua(dob1.year, gender1);
    int name1Num = AuraCalculator.calculateNameNumber(name1);
    
    // Calculate numbers for person 2
    int driver2 = AuraCalculator.getDriverNumber(dob2.day);
    int conductor2 = AuraCalculator.getConductorNumber(dob2.day, dob2.month, dob2.year);
    int kua2 = AuraCalculator.calculateKua(dob2.year, gender2);
    int name2Num = AuraCalculator.calculateNameNumber(name2);
    
    // Calculate compatibility scores
    int driverMatch = _numberCompatibility(driver1, driver2);
    int conductorMatch = _numberCompatibility(conductor1, conductor2);
    int kuaMatch = _kuaCompatibility(kua1, kua2);
    int nameMatch = _numberCompatibility(name1Num, name2Num);
    
    int overall = ((driverMatch + conductorMatch + kuaMatch + nameMatch) / 4).round();
    
    // Generate insights
    List<String> strengths = _getStrengths(driver1, driver2, conductor1, conductor2);
    List<String> challenges = _getChallenges(driver1, driver2, conductor1, conductor2);
    List<String> tips = _getRelationshipTips(driver1, driver2);
    
    return CompatibilityResult(
      person1Name: name1.split(' ')[0],
      person2Name: name2.split(' ')[0],
      overallScore: overall,
      driverMatch: driverMatch,
      conductorMatch: conductorMatch,
      kuaMatch: kuaMatch,
      nameMatch: nameMatch,
      strengths: strengths,
      challenges: challenges,
      tips: tips,
    );
  }
  
  static int _numberCompatibility(int n1, int n2) {
    // Perfect match
    if (n1 == n2) return 95;
    
    // Highly compatible pairs
    Map<int, List<int>> compatible = {
      1: [5, 7],
      2: [4, 6, 8],
      3: [6, 9],
      4: [2, 6, 8],
      5: [1, 7],
      6: [2, 3, 4, 9],
      7: [1, 5],
      8: [2, 4],
      9: [3, 6],
    };
    
    if (compatible[n1]?.contains(n2) ?? false) return 80;
    
    // Challenging pairs
    Map<int, List<int>> challenging = {
      1: [8],
      2: [5],
      3: [4],
      4: [3, 5],
      5: [2, 4],
      8: [1, 9],
      9: [8],
    };
    
    if (challenging[n1]?.contains(n2) ?? false) return 50;
    
    // Neutral
    return 65;
  }
  
  static int _kuaCompatibility(int kua1, int kua2) {
    // East group: 1, 3, 4, 9
    // West group: 2, 6, 7, 8
  const List<int> east = [1, 3, 4, 9];

  final bool person1East = east.contains(kua1);
  final bool person2East = east.contains(kua2);
    
    if (person1East == person2East) return 85; // Same group
    return 60; // Different groups
  }
  
  static List<String> _getStrengths(int d1, int d2, int c1, int c2) {
    List<String> strengths = [];
    
    if ((d1 == 3 || d1 == 5) && (d2 == 3 || d2 == 5)) {
      strengths.add('Great communication and social connection');
    }
    if ((d1 == 2 || d1 == 6) && (d2 == 2 || d2 == 6)) {
      strengths.add('Strong emotional bond and caring nature');
    }
    if (d1 == d2) {
      strengths.add('Similar temperament and understanding');
    }
    if ((d1 + d2) == 10) {
      strengths.add('Perfect balance of energies');
    }
    
    return strengths.isEmpty ? ['Complementary personalities'] : strengths;
  }
  
  static List<String> _getChallenges(int d1, int d2, int c1, int c2) {
    List<String> challenges = [];
    
    if (d1 == 1 && d2 == 8) {
      challenges.add('Power struggles and ego conflicts');
    }
    if (d1 == 5 && d2 == 4) {
      challenges.add('Freedom vs stability conflict');
    }
    if (d1 == 7 && d2 == 3) {
      challenges.add('Introversion vs extroversion balance needed');
    }
    
    return challenges.isEmpty ? ['Minor adjustments needed'] : challenges;
  }
  
  static List<String> _getRelationshipTips(int d1, int d2) {
    return [
      'Practice open communication daily',
      'Respect each other\'s differences',
      'Create shared goals and dreams',
      'Give space when needed',
    ];
  }
}
