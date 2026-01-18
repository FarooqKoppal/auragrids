import '../models/number_info.dart';
import 'enhanced_calculator.dart';

class NameCorrection {
  final String originalName;
  final String suggestedName;
  final NumberInfo originalNumber;
  final NumberInfo suggestedNumber;
  final String reason;
  final int compatibilityScore;
  
  NameCorrection({
    required this.originalName,
    required this.suggestedName,
    required this.originalNumber,
    required this.suggestedNumber,
    required this.reason,
    required this.compatibilityScore,
  });
}

class NameCorrector {
  // Chaldean values
  static const Map<String, int> chaldean = {
    'A':1,'I':1,'J':1,'Q':1,'Y':1,
    'B':2,'K':2,'R':2,
    'C':3,'G':3,'L':3,'S':3,
    'D':4,'M':4,'T':4,
    'E':5,'H':5,'N':5,'X':5,
    'U':6,'V':6,'W':6,
    'O':7,'Z':7,
    'F':8,'P':8
  };
  
  // Best numbers for harmony
  static const List<int> luckyNumbers = [1, 3, 5, 6, 9];
  static const List<int> masterNumbers = [11, 22, 33];
  
  // Analyze current name and suggest improvements
  static List<NameCorrection> analyzeName(String name, int driverNumber, int conductorNumber) {
    List<NameCorrection> suggestions = [];
    
    NumberInfo currentNameInfo = EnhancedCalculator.calculateNameNumberInfo(name);
    int currentNumber = currentNameInfo.reducedValue;
    
    // Check if current name is already good
    bool isCurrentGood = _isGoodNumber(currentNumber) || 
                         currentNameInfo.isMasterNumber ||
                         _isCompatibleWith(currentNumber, driverNumber, conductorNumber);
    
    if (isCurrentGood && currentNameInfo.isMasterNumber) {
      // Name is already excellent
      return suggestions;
    }
    
    // Generate variations
    suggestions.addAll(_generateAddLetterSuggestions(name, driverNumber, conductorNumber, currentNameInfo));
    suggestions.addAll(_generateRemoveLetterSuggestions(name, driverNumber, conductorNumber, currentNameInfo));
    suggestions.addAll(_generateAlternativeSpellingSuggestions(name, driverNumber, conductorNumber, currentNameInfo));
    
    // Sort by compatibility score
    suggestions.sort((a, b) => b.compatibilityScore.compareTo(a.compatibilityScore));
    
    // Return top 5 suggestions
    return suggestions.take(5).toList();
  }
  
  static List<NameCorrection> _generateAddLetterSuggestions(
    String name, int driver, int conductor, NumberInfo currentInfo) {
    List<NameCorrection> suggestions = [];
    
    // Try adding common letters at the end
    const letters = ['A', 'I', 'E', 'H', 'N', 'S', 'R', 'Y'];
    
    for (var letter in letters) {
      String newName = '$name$letter';
      // Reject dangerous endings per video guidance
      final last = newName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
      if (last.isNotEmpty) {
        final lastChar = last[last.length - 1];
        if (['B','K','R'].contains(lastChar)) continue; // skip inauspicious endings
      }
      NumberInfo newInfo = EnhancedCalculator.calculateNameNumberInfo(newName);
      
      if (_shouldSuggest(newInfo, currentInfo, driver, conductor)) {
        suggestions.add(NameCorrection(
          originalName: name,
          suggestedName: newName,
          originalNumber: currentInfo,
          suggestedNumber: newInfo,
          reason: _getReason(newInfo, driver, conductor),
          compatibilityScore: _calculateCompatibility(newInfo, driver, conductor),
        ));
      }
    }
    
    return suggestions;
  }
  
  static List<NameCorrection> _generateRemoveLetterSuggestions(
    String name, int driver, int conductor, NumberInfo currentInfo) {
    List<NameCorrection> suggestions = [];
    
    if (name.length <= 3) return suggestions; // Don't make name too short
    
    // Try removing last letter
    String newName = name.substring(0, name.length - 1);
    NumberInfo newInfo = EnhancedCalculator.calculateNameNumberInfo(newName);
    
    if (_shouldSuggest(newInfo, currentInfo, driver, conductor)) {
      // Reject dangerous endings
      final last = newName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
      if (last.isNotEmpty && ['B','K','R'].contains(last[last.length - 1])) return suggestions;
      suggestions.add(NameCorrection(
        originalName: name,
        suggestedName: newName,
        originalNumber: currentInfo,
        suggestedNumber: newInfo,
        reason: _getReason(newInfo, driver, conductor),
        compatibilityScore: _calculateCompatibility(newInfo, driver, conductor),
      ));
    }
    
    return suggestions;
  }
  
  static List<NameCorrection> _generateAlternativeSpellingSuggestions(
    String name, int driver, int conductor, NumberInfo currentInfo) {
    List<NameCorrection> suggestions = [];
    
    // Common spelling variations
    Map<String, String> variations = {
      'PH': 'F',    // Philip -> Filip
      'TH': 'T',    // Prithvi -> Pritvi
      'KH': 'K',    // Rakhi -> Raki
      'C': 'K',     // Chetan -> Khetan
      'I': 'EE',    // Ravi -> Ravee
      'EE': 'I',    // Deepak -> Dipak
    };
    
    for (var entry in variations.entries) {
      if (name.toUpperCase().contains(entry.key)) {
        String newName = name.toUpperCase().replaceFirst(entry.key, entry.value);
        newName = _toTitleCase(newName);
        NumberInfo newInfo = EnhancedCalculator.calculateNameNumberInfo(newName);
        
        if (_shouldSuggest(newInfo, currentInfo, driver, conductor)) {
          // Reject if ends with inauspicious letters
          final last = newName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
          if (last.isNotEmpty && ['B','K','R'].contains(last[last.length - 1])) continue;
          suggestions.add(NameCorrection(
            originalName: name,
            suggestedName: newName,
            originalNumber: currentInfo,
            suggestedNumber: newInfo,
            reason: _getReason(newInfo, driver, conductor),
            compatibilityScore: _calculateCompatibility(newInfo, driver, conductor),
          ));
        }
      }
    }
    
    return suggestions;
  }
  
  static bool _shouldSuggest(NumberInfo newInfo, NumberInfo currentInfo, int driver, int conductor) {
    // Suggest if:
    // 1. It's a master number
    // 2. It's more compatible than current
    // 3. It's a lucky number and current isn't
    
    if (newInfo.isMasterNumber && !currentInfo.isMasterNumber) {
      return true;
    }
    
    int newScore = _calculateCompatibility(newInfo, driver, conductor);
    int currentScore = _calculateCompatibility(currentInfo, driver, conductor);
    
    return newScore > currentScore + 10; // At least 10% better
  }
  
  static int _calculateCompatibility(NumberInfo nameInfo, int driver, int conductor) {
    int score = 50; // Base score
    int nameNum = nameInfo.reducedValue;
    
    // Master number bonus
    if (nameInfo.isMasterNumber) {
      score += 30;
    }
    
    // Lucky number bonus
    if (luckyNumbers.contains(nameNum)) {
      score += 15;
    }
    
    // Compatibility with driver
    if (nameNum == driver) {
      score += 20;
    } else if (_areCompatible(nameNum, driver)) {
      score += 10;
    }
    
    // Compatibility with conductor
    if (nameNum == conductor) {
      score += 20;
    } else if (_areCompatible(nameNum, conductor)) {
      score += 10;
    }
    
    // Karmic debt penalty
    if (nameInfo.isKarmicDebt) {
      score -= 15;
    }
    
    return score.clamp(0, 100);
  }
  
  static bool _areCompatible(int n1, int n2) {
    // Numerology compatibility pairs
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
  
  static bool _isGoodNumber(int n) {
    return luckyNumbers.contains(n);
  }
  
  static bool _isCompatibleWith(int nameNum, int driver, int conductor) {
    return nameNum == driver || nameNum == conductor ||
           _areCompatible(nameNum, driver) || _areCompatible(nameNum, conductor);
  }
  
  static String _getReason(NumberInfo nameInfo, int driver, int conductor) {
    int nameNum = nameInfo.reducedValue;
    
    if (nameInfo.isMasterNumber) {
      return 'Master Number ${nameInfo.originalValue} - Spiritual power and destiny';
    }
    
    if (nameNum == driver) {
      return 'Perfect match with your Driver number - Enhances personality';
    }
    
    if (nameNum == conductor) {
      return 'Perfect match with your Conductor - Aligns with destiny';
    }
    
    if (_areCompatible(nameNum, driver) && _areCompatible(nameNum, conductor)) {
      return 'Harmonious with both Driver and Conductor - Balanced energy';
    }
    
    if (luckyNumbers.contains(nameNum)) {
      return 'Lucky number $nameNum - Brings prosperity and success';
    }
    
    return 'Improved numerological vibration';
  }
  
  static String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // NEW: Helper to convert AI Agent response into your UI-friendly model
  static NameCorrection fromAiJson(Map<String, dynamic> json, String originalName, NumberInfo originalInfo, int driver, int conductor) {
    // Calculate the new NumberInfo based on the AI's suggested spelling
    final suggestedName = json['suggested_name'] ?? json['name'];
    final newInfo = EnhancedCalculator.calculateNameNumberInfo(suggestedName);

    return NameCorrection(
      originalName: originalName,
      suggestedName: suggestedName,
      originalNumber: originalInfo,
      suggestedNumber: newInfo,
      reason: json['explanation'] ?? json['benefit'] ?? 'AI optimized vibration',
      compatibilityScore: _calculateCompatibility(newInfo, driver, conductor),
    );
  }
}
