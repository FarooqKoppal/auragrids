enum Gender { male, female }

class AuraCalculator {
  static Map<int, int> calculateLoShu(int day, int month, int year) {
    Map<int, int> gridCounts = {};
    
    // Format with leading zeros: DD/MM/YYYY
    String dayStr = day.toString().padLeft(2, '0');
    String monthStr = month.toString().padLeft(2, '0');
    String yearStr = year.toString();
    String fullDate = "$dayStr$monthStr$yearStr";
    
    // Step 1: Count all digits from birth date
    for (var char in fullDate.split('')) {
      int? digit = int.tryParse(char);
      if (digit != null && digit != 0) {
        gridCounts[digit] = (gridCounts[digit] ?? 0) + 1;
      }
    }

    // Step 2: Calculate Driver and Conductor
    int driver = getDriverNumber(day);
    int conductor = getConductorNumber(day, month, year);
    
    // Step 3: Add Driver ONLY if birthday is double digit (10-31)
    // For single digit (1-9), driver is same as day, already counted
    if (day >= 10) {
      gridCounts[driver] = (gridCounts[driver] ?? 0) + 1;
    }
    
    // Step 4: ALWAYS add Conductor (Bhagyank)
    gridCounts[conductor] = (gridCounts[conductor] ?? 0) + 1;

    return gridCounts;
  }

  static int getDriverNumber(int day) => _reduce(day);

  static int getConductorNumber(int d, int m, int y) => _reduce(d + m + y);

  static int _reduce(int n) {
    while (n > 9) {
      int sum = 0;
      for (var char in n.toString().split('')) {
        sum += int.parse(char);
      }
      n = sum;
    }
    return n;
  }

  static int calculateKua(int year, Gender gender) {
    int yearSum = 0;
    for (var char in year.toString().split('')) {
      yearSum += int.parse(char);
    }
    int digit = _reduce(yearSum);
    return (gender == Gender.male) ? _reduce(11 - digit) : _reduce(digit + 4);
  }

  static int calculateNameNumber(String name) {
    const chaldean = {
      'A':1,'I':1,'J':1,'Q':1,'Y':1, 'B':2,'K':2,'R':2, 'C':3,'G':3,'L':3,'S':3,
      'D':4,'M':4,'T':4, 'E':5,'H':5,'N':5,'X':5, 'U':6,'V':6,'W':6, 'O':7,'Z':7, 'F':8,'P':8
    };
    int total = 0;
    for (var char in name.toUpperCase().split('')) {
      total += chaldean[char] ?? 0;
    }
    return _reduce(total);
  }

  static List<String> getCompletedPlanes(Map<int, int> grid) {
    List<String> planes = [];
    // Horizontal Planes
    if (grid.containsKey(4) && grid.containsKey(9) && grid.containsKey(2)) planes.add("Mental Plane (Sharp Thought/Logic)");
    if (grid.containsKey(3) && grid.containsKey(5) && grid.containsKey(7)) planes.add("Emotional Plane (Intuition/Peace)");
    if (grid.containsKey(8) && grid.containsKey(1) && grid.containsKey(6)) planes.add("Practical Plane (Hard Work/Action)");
    
    // Vertical Planes
    if (grid.containsKey(4) && grid.containsKey(3) && grid.containsKey(8)) planes.add("Thought Plane (Planning/Vision)");
    if (grid.containsKey(9) && grid.containsKey(5) && grid.containsKey(1)) planes.add("Will Plane (Determination/Success)");
    if (grid.containsKey(2) && grid.containsKey(7) && grid.containsKey(6)) planes.add("Action Plane (Execution/Speed)");

    // Diagonal Planes
    if (grid.containsKey(4) && grid.containsKey(5) && grid.containsKey(6)) planes.add("Golden Yog (Extreme Wealth/Success)");
    if (grid.containsKey(2) && grid.containsKey(5) && grid.containsKey(8)) planes.add("Silver Yog (Property/Stability)");
    
    return planes;
  }

  // Enhanced version with numbers
  static List<Map<String, dynamic>> getCompletedPlanesWithNumbers(Map<int, int> grid) {
    List<Map<String, dynamic>> planes = [];
    
    // Horizontal Planes
    if (grid.containsKey(4) && grid.containsKey(9) && grid.containsKey(2)) {
      planes.add({
        "name": "Mental Plane (Sharp Thought/Logic)",
        "numbers": [4, 9, 2],
        "type": "horizontal"
      });
    }
    if (grid.containsKey(3) && grid.containsKey(5) && grid.containsKey(7)) {
      planes.add({
        "name": "Emotional Plane (Intuition/Peace)",
        "numbers": [3, 5, 7],
        "type": "horizontal"
      });
    }
    if (grid.containsKey(8) && grid.containsKey(1) && grid.containsKey(6)) {
      planes.add({
        "name": "Practical Plane (Hard Work/Action)",
        "numbers": [8, 1, 6],
        "type": "horizontal"
      });
    }
    
    // Vertical Planes
    if (grid.containsKey(4) && grid.containsKey(3) && grid.containsKey(8)) {
      planes.add({
        "name": "Thought Plane (Planning/Vision)",
        "numbers": [4, 3, 8],
        "type": "vertical"
      });
    }
    if (grid.containsKey(9) && grid.containsKey(5) && grid.containsKey(1)) {
      planes.add({
        "name": "Will Plane (Determination/Success)",
        "numbers": [9, 5, 1],
        "type": "vertical"
      });
    }
    if (grid.containsKey(2) && grid.containsKey(7) && grid.containsKey(6)) {
      planes.add({
        "name": "Action Plane (Execution/Speed)",
        "numbers": [2, 7, 6],
        "type": "vertical"
      });
    }

    // Diagonal Planes
    if (grid.containsKey(4) && grid.containsKey(5) && grid.containsKey(6)) {
      planes.add({
        "name": "Golden Yog (Extreme Wealth/Success)",
        "numbers": [4, 5, 6],
        "type": "diagonal"
      });
    }
    if (grid.containsKey(2) && grid.containsKey(5) && grid.containsKey(8)) {
      planes.add({
        "name": "Silver Yog (Property/Stability)",
        "numbers": [2, 5, 8],
        "type": "diagonal"
      });
    }
    
    return planes;
  }

  static Map<int, String> getRemedies(Map<int, int> grid) {
    return {
      1: "Carry a silver coin or use a water fountain in the North direction of your home.",
      2: "Keep a pair of rose quartz crystals or wear a silver ring on your finger.",
      3: "Keep a green plant (Tulsi) or wear a wooden/Tulsi bracelet on your wrist.",
      4: "Tie a green thread on your wrist or use a wooden pen for your daily work.",
      5: "Wear a yellow thread or use a brass bell in the center (Brahmasthan) of your home.",
      6: "Wear a white watch or use golden/silver accessories to attract Venus energy.",
      7: "Wear a silver chain or keep a metal pyramid in the West direction of your room.",
      8: "Use an amethyst crystal or keep a stone object in the North-East direction.",
      9: "Keep a red light or a red candle in the South direction to boost your fame.",
    };
  }

  // 1. Personal Year Logic (Calculated for the current year)
  static int calculatePersonalYear(int day, int month) {
    int currentYear = DateTime.now().year;
    return _reduce(day + month + _reduce(currentYear));
  }

  static String getPersonalYearMessage(int py) {
    const messages = {
      1: "Year of New Beginnings and Leadership.",
      2: "Year of Patience, Partnerships, and Planning.",
      3: "Year of Creativity, Socializing, and Growth.",
      4: "Year of Hard Work, Discipline, and Foundations.",
      5: "Year of Change, Travel, and Freedom.",
      6: "Year of Family, Responsibility, and Relationships.",
      7: "Year of Introspection, Learning, and Spirituality.",
      8: "Year of Money, Power, and Material Success.",
      9: "Year of Completion, Letting Go, and Transformation.",
    };
    return messages[py] ?? "";
  }

  // 2. Lucky Factors based on Driver (Psychic Number)
  static Map<String, dynamic> getLuckyFactors(int driver) {
    final data = {
      1: {"color": "Yellow, Gold", "day": "Sunday", "direction": "East"},
      2: {"color": "White, Silver", "day": "Monday", "direction": "North-West"},
      3: {"color": "Yellow, Orange", "day": "Thursday", "direction": "North-East"},
      4: {"color": "Blue, Grey", "day": "Saturday", "direction": "South-West"},
      5: {"color": "Green", "day": "Wednesday", "direction": "North"},
      6: {"color": "White, Light Blue", "day": "Friday", "direction": "South-East"},
      7: {"color": "Light Green, White", "day": "Monday", "direction": "West"},
      8: {"color": "Dark Blue, Black", "day": "Saturday", "direction": "West"},
      9: {"color": "Red, Pink", "day": "Tuesday", "direction": "South"},
    };
    return data[driver] ?? {};
  }

  // Get actual Color objects for visual display
  static List<dynamic> getLuckyColorObjects(int driver) {
    final colorMap = {
      1: [0xFFFFD700, 0xFFFFA500], // Gold, Orange
      2: [0xFFFFFFFF, 0xFFC0C0C0], // White, Silver
      3: [0xFFFFD700, 0xFFFFA500], // Yellow, Orange
      4: [0xFF4169E1, 0xFF808080], // Royal Blue, Grey
      5: [0xFF00C853, 0xFF66BB6A], // Green, Light Green
      6: [0xFFFFFFFF, 0xFF87CEEB], // White, Sky Blue
      7: [0xFF90EE90, 0xFFFFFFFF], // Light Green, White
      8: [0xFF00008B, 0xFF000000], // Dark Blue, Black
      9: [0xFFFF0000, 0xFFFF69B4], // Red, Pink
    };
    return colorMap[driver] ?? [];
  }
}