import '../l10n/app_localizations.dart';

class LocalizedData {
  // Get localized day name
  static String getDay(AppLocalizations l10n, String day) {
    final Map<String, String> dayMap = {
      'Sunday': l10n.translate('sunday'),
      'Monday': l10n.translate('monday'),
      'Tuesday': l10n.translate('tuesday'),
      'Wednesday': l10n.translate('wednesday'),
      'Thursday': l10n.translate('thursday'),
      'Friday': l10n.translate('friday'),
      'Saturday': l10n.translate('saturday'),
    };
    return dayMap[day] ?? day;
  }

  // Get localized direction
  static String getDirection(AppLocalizations l10n, String direction) {
    final Map<String, String> directionMap = {
      'East': l10n.translate('east'),
      'West': l10n.translate('west'),
      'North': l10n.translate('north'),
      'South': l10n.translate('south'),
      'North-East': l10n.translate('north_east'),
      'North-West': l10n.translate('north_west'),
      'South-East': l10n.translate('south_east'),
      'South-West': l10n.translate('south_west'),
    };
    return directionMap[direction] ?? direction;
  }

  // Get localized color names
  static String getColors(AppLocalizations l10n, String colors) {
    final Map<String, String> colorMap = {
      'Yellow, Gold': l10n.translate('yellow_gold'),
      'White, Silver': l10n.translate('white_silver'),
      'Yellow, Orange': l10n.translate('yellow_orange'),
      'Blue, Grey': l10n.translate('blue_grey'),
      'Green': l10n.translate('green'),
      'White, Light Blue': l10n.translate('white_light_blue'),
      'Light Green, White': l10n.translate('light_green_white'),
      'Dark Blue, Black': l10n.translate('dark_blue_black'),
      'Red, Pink': l10n.translate('red_pink'),
    };
    return colorMap[colors] ?? colors;
  }

  // Get localized plane names
  static String getPlane(AppLocalizations l10n, String plane) {
    final Map<String, String> planeMap = {
      'Mental Plane (Sharp Thought/Logic)': l10n.translate('mental_plane'),
      'Emotional Plane (Intuition/Peace)': l10n.translate('emotional_plane'),
      'Practical Plane (Hard Work/Action)': l10n.translate('practical_plane'),
      'Thought Plane (Planning/Vision)': l10n.translate('thought_plane'),
      'Will Plane (Determination/Success)': l10n.translate('will_plane'),
      'Action Plane (Execution/Speed)': l10n.translate('action_plane'),
      'Golden Yog (Extreme Wealth/Success)': l10n.translate('golden_yog'),
      'Silver Yog (Property/Stability)': l10n.translate('silver_yog'),
    };
    return planeMap[plane] ?? plane;
  }

  // Get localized personal year message
  static String getPersonalYearMessage(AppLocalizations l10n, int year) {
    return l10n.translate('py_$year');
  }

  // Get localized remedy
  static String getRemedy(AppLocalizations l10n, int number) {
    return l10n.translate('remedy_$number');
  }
}
