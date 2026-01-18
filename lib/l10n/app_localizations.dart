import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App Title
      'app_title': 'AuraGrids',
      'app_subtitle': 'Numerology Calculator',
      
      // Home Screen
      'discover_destiny': 'Discover Your Destiny',
      'enter_details': 'Enter your details to unlock numerological insights',
      'full_name': 'Full Name',
      'name_hint': 'e.g., John Doe',
      'select_birth_date': 'Select Birth Date',
      'dob_label': 'DOB',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'reveal_button': 'REVEAL MY DESTINY',
      'toggle_theme': 'Toggle Theme',
      
      // Validation
      'select_date_error': 'Please select your birth date',
  'select_both_birth_dates': 'Please select both birth dates',
      
      // Results Section
      'lucky_compass': 'Your Lucky Compass',
      'lucky_colors': 'Lucky Colors',
      'lucky_day': 'Lucky Day',
      'direction': 'Direction',
  // Additional UI labels
  'lo_shu_grid': 'Lo Shu Grid',
  'core_numbers': 'Core Numbers',
  'time_cycles': 'Time Cycles',
  'numbers_label': 'Numbers: ',
  'name_analysis': 'Name Analysis',
  'enter_name_to_analyze': 'Enter a name to analyze',
  // New sections
  'name_correction': 'Name Correction & Suggestions',
  'enter_name_to_suggest': 'Enter your full name and calculate to see suggestions.',
  'no_name_suggestions': 'No suggestions — your name is already well aligned.',
  'apply_suggestion': 'Apply Suggestion',
  'mobile_analysis': 'Mobile Number Analysis',
  'enter_mobile_to_analyze': 'Enter a mobile number to analyze compatibility.',
  'strengths': 'Strengths',
  'weaknesses': 'Weaknesses',
  'suggestions': 'Suggestions',
  'better_numbers': 'Suggested Better Numbers',
  'cancel': 'Cancel',
  'apply': 'Apply',
  'copied_clipboard': 'Copied to clipboard',
  'grid_frequency_analysis': 'Grid Frequency Analysis',
  'arrow_patterns': 'Arrow Patterns',
  'grid_explanation': 'Date digits + Driver (if day≥10) + Conductor + Kua',
  'excessive_numbers': '🔴 Excessive Numbers (5+ times)',
  'balanced_numbers': '🟢 Balanced Numbers (2-3 times)',
  'missing_numbers': '❌ Missing Numbers',
  'appears_times': 'Appears {count} times',
      
      // Numerology Summary
      'numerology_summary': 'Numerology Summary',
      'driver_psychic': 'Driver (Psychic)',
      'conductor_destiny': 'Conductor (Destiny)',
      'kua_number': 'Kua (Success) Number',
      'name_number': 'Name Number',
      'personal_year': 'Personal Year',
  'download_pdf': 'Download PDF',
      'person': 'Person',
      'calculate_compatibility': 'Calculate Compatibility',
      
      // Strengths & Planes
      'strengths_planes': 'Strengths & Planes',
      
      // Remedies
      'personalized_remedies': 'Personalized Remedies',
      'strengthen_missing': 'Strengthen missing numbers in your chart',
      
      // Days of Week
      'sunday': 'Sunday',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      
      // Directions
      'east': 'East',
      'west': 'West',
      'north': 'North',
      'south': 'South',
      'north_east': 'North-East',
      'north_west': 'North-West',
      'south_east': 'South-East',
      'south_west': 'South-West',
      
      // Colors (for reference)
      'yellow_gold': 'Yellow, Gold',
      'white_silver': 'White, Silver',
      'yellow_orange': 'Yellow, Orange',
      'blue_grey': 'Blue, Grey',
      'green': 'Green',
      'white_light_blue': 'White, Light Blue',
      'light_green_white': 'Light Green, White',
      'dark_blue_black': 'Dark Blue, Black',
      'red_pink': 'Red, Pink',
      
      // Planes
      'mental_plane': 'Mental Plane (Sharp Thought/Logic)',
      'emotional_plane': 'Emotional Plane (Intuition/Peace)',
      'practical_plane': 'Practical Plane (Hard Work/Action)',
      'thought_plane': 'Thought Plane (Planning/Vision)',
      'will_plane': 'Will Plane (Determination/Success)',
      'action_plane': 'Action Plane (Execution/Speed)',
      'golden_yog': 'Golden Yog (Extreme Wealth/Success)',
      'silver_yog': 'Silver Yog (Property/Stability)',
      
      // Personal Year Messages
      'py_1': 'Year of New Beginnings and Leadership.',
      'py_2': 'Year of Patience, Partnerships, and Planning.',
      'py_3': 'Year of Creativity, Socializing, and Growth.',
      'py_4': 'Year of Hard Work, Discipline, and Foundations.',
      'py_5': 'Year of Change, Travel, and Freedom.',
      'py_6': 'Year of Family, Responsibility, and Relationships.',
      'py_7': 'Year of Introspection, Learning, and Spirituality.',
      'py_8': 'Year of Money, Power, and Material Success.',
      'py_9': 'Year of Completion, Letting Go, and Transformation.',
      
      // Remedies
      'remedy_1': 'Carry a silver coin or use a water fountain in the North direction of your home.',
      'remedy_2': 'Keep a pair of rose quartz crystals or wear a silver ring on your finger.',
      'remedy_3': 'Keep a green plant (Tulsi) or wear a wooden/Tulsi bracelet on your wrist.',
      'remedy_4': 'Tie a green thread on your wrist or use a wooden pen for your daily work.',
      'remedy_5': 'Wear a yellow thread or use a brass bell in the center (Brahmasthan) of your home.',
      'remedy_6': 'Wear a white watch or use golden/silver accessories to attract Venus energy.',
      'remedy_7': 'Wear a silver chain or keep a metal pyramid in the West direction of your room.',
      'remedy_8': 'Use an amethyst crystal or keep a stone object in the North-East direction.',
      'remedy_9': 'Keep a red light or a red candle in the South direction to boost your fame.',
  'mobile_number_optional': 'Mobile Number (Optional)',
  'mobile_hint': 'e.g., 9876543210',
  'compatibility_calculator': 'Compatibility Calculator',
  'change_language': 'Change Language',
  'personal_month_label': 'Personal Month',
  'month_1': 'January',
  'month_2': 'February',
  'month_3': 'March',
  'month_4': 'April',
  'month_5': 'May',
  'month_6': 'June',
  'month_7': 'July',
  'month_8': 'August',
  'month_9': 'September',
  'month_10': 'October',
  'month_11': 'November',
  'month_12': 'December',
  'complete_name_analysis': 'Complete Name Analysis',
  'expression_full_name': 'Expression (Full Name)',
  'first_name_vibration': 'First Name Vibration',
  'family_legacy': 'Family Legacy (Last Name)',
  'soul_urge_label': 'Soul Urge (Inner Desire)',
  'personality_label': 'Personality (Outer Image)',
  'age_phase_analysis': 'Age-Phase Analysis',
  'origin_first_letter': 'Origin (First Letter)',
  'destination_last_letter': 'Destination (Last Letter)',
  'rahu_warning': 'Name starts with {letter} — may indicate struggles in early life (Rahu-like)',
  'dangerous_ending_warning': 'Name ends with {letter} — flagged as risky for late-life; consider alternatives',
  'nickname_label': 'Nickname (what people call you)',
    },
    
    'kn': {
      // App Title
      'app_title': 'ಅರಾ ಗ್ರಿಡ್ಸ್',
      'app_subtitle': 'ಸಂಖ್ಯಾಶಾಸ್ತ್ರ ಲೆಕ್ಕಾಚಾರ',
      
      // Home Screen
      'discover_destiny': 'ನಿಮ್ಮ ಭವಿಷ್ಯವನ್ನು ಅನ್ವೇಷಿಸಿ',
      'enter_details': 'ಸಂಖ್ಯಾಶಾಸ್ತ್ರದ ಒಳನೋಟಗಳನ್ನು ಅನ್ಲಾಕ್ ಮಾಡಲು ನಿಮ್ಮ ವಿವರಗಳನ್ನು ನಮೂದಿಸಿ',
      'full_name': 'ಪೂರ್ಣ ಹೆಸರು',
      'name_hint': 'ಉದಾ: ರಾಮ ಕುಮಾರ್',
      'select_birth_date': 'ಜನ್ಮ ದಿನಾಂಕ ಆಯ್ಕೆಮಾಡಿ',
      'dob_label': 'ಜನ್ಮ ದಿನಾಂಕ',
      'gender': 'ಲಿಂಗ',
      'male': 'ಪುರುಷ',
      'female': 'ಮಹಿಳೆ',
      'reveal_button': 'ನನ್ನ ಭವಿಷ್ಯವನ್ನು ಬಹಿರಂಗಪಡಿಸಿ',
      'toggle_theme': 'ಥೀಮ್ ಬದಲಿಸಿ',
      
      // Validation
      'select_date_error': 'ದಯವಿಟ್ಟು ನಿಮ್ಮ ಜನ್ಮ ದಿನಾಂಕವನ್ನು ಆಯ್ಕೆಮಾಡಿ',
    'select_both_birth_dates': 'ದಯವಿಟ್ಟು ಎರಡೂ ಜನ್ಮ ದಿನಾಂಕಗಳನ್ನು ಆಯ್ಕೆಮಾಡಿ',
      
      // Results Section
      'lucky_compass': 'ನಿಮ್ಮ ಅದೃಷ್ಟದ ದಿಕ್ಸೂಚಿ',
      'lucky_colors': 'ಅದೃಷ್ಟದ ಬಣ್ಣಗಳು',
      'lucky_day': 'ಅದೃಷ್ಟದ ದಿನ',
      'direction': 'ದಿಕ್ಕು',
  // Additional UI labels translations
  'lo_shu_grid': 'ಲೋ ಶು ಗ್ರಿಡ್',
  'core_numbers': 'ಕೋರ್ ಸಂಖ್ಯೆಗಳು',
  'time_cycles': 'ಕಾಲ ಚಕ್ರಗಳು',
  'numbers_label': 'ಸಂಖ್ಯೆಗಳು: ',
  'name_analysis': 'ಹೆಸರು ವಿಶ್ಲೇಷಣೆ',
  'enter_name_to_analyze': 'ವಿಶ್ಲೇಷಿಸಲು ಹೆಸರನ್ನು ನಮೂದಿಸಿ',
  // New sections translations
  'name_correction': 'ಹೆಸರು ಸರಿಪಡಿಸುವಿಕೆ ಮತ್ತು ಶಿಫಾರಸುಗಳು',
  'enter_name_to_suggest': 'ಶಿಫಾರಸುಗಳನ್ನು ನೋಡಲು ನಿಮ್ಮ ಪೂರ್ಣ ಹೆಸರನ್ನು ನಮೂದಿಸಿ ಮತ್ತು ಗಣನೆ ಮಾಡಿ.',
  'no_name_suggestions': 'ಯಾವುದೇ ಶಿಫಾರಸುಗಳಿಲ್ಲ — ನಿಮ್ಮ ಹೆಸರು ಈಗಾಗಲೆ ಉತ್ತಮ ಹೊಂದಿಕೊಂಡಿದೆ.',
  'apply_suggestion': 'ಶಿಫಾರಸು ಅನ್ವಯಿಸಿ',
  'mobile_analysis': 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ವಿಶ್ಲೇಷಣೆ',
  'enter_mobile_to_analyze': 'ಅನುಕೂಲತೆಯನ್ನು ವಿಶ್ಲೇಷಿಸಲು ಮೊಬೈಲ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ.',
  'strengths': 'ಶಕ್ತಿಗಳು',
  'weaknesses': 'ದೌರ್ಬಲ್ಯಗಳು',
  'suggestions': 'ಶಿಫಾರಸುಗಳು',
  'better_numbers': 'ಶಿಫಾರಸು ಮಾಡಿದ ಉತ್ತಮ ಸಂಖ್ಯೆಗಳು',
  'cancel': 'ರದ್ದು',
  'apply': 'ಅನ್ವಯಿಸು',
  'copied_clipboard': 'ಕ್ಲಿಪ್‍ಬೋರ್ಡ್ಗೆ ನಕಲಿಸಲಾಗಿದೆ',
    'grid_frequency_analysis': 'ಗ್ರಿಡ್ ಫ್ರಿಕ್ವೆನ್ಸಿ ವಿಶ್ಲೇಷಣೆ',
    'arrow_patterns': 'ತೋಯ್ದು ವಿನ್ಯಾಸಗಳು',
    'grid_explanation': 'ದಿನಾಂಕದ ಅಂಕೆಗಳು + ಚಾಲಕ (ದಿನ ≥ 10 ಆಗಿದ್ದರೆ) + ಕಂಡಕ್ಟರ್ + ಕುವಾ',
    'excessive_numbers': '🔴 ಜಾಸ್ತಿ ಸಂಖ್ಯೆಗಳು (5+ ಬಾರಿ)',
    'balanced_numbers': '🟢 ಸಮತೋಲನ ಸಂಖ್ಯೆಗಳು (2-3 ಬಾರಿ)',
    'missing_numbers': '❌ ಕಾಣೆಯಾದ ಸಂಖ್ಯೆಗಳನ್ನು',
    'appears_times': 'ಪ್ರದರ್ಶಿಸುತ್ತದೆ {count} ಬಾರಿ',
      
      // Numerology Summary
      'numerology_summary': 'ಸಂಖ್ಯಾಶಾಸ್ತ್ರದ ಸಾರಾಂಶ',
      'driver_psychic': 'ಚಾಲಕ (ಮಾನಸಿಕ)',
      'conductor_destiny': 'ನಡೆಸುವವನು (ಭವಿಷ್ಯ)',
      'kua_number': 'ಕುವಾ (ಯಶಸ್ಸು) ಸಂಖ್ಯೆ',
      'name_number': 'ಹೆಸರಿನ ಸಂಖ್ಯೆ',
      'personal_year': 'ವೈಯಕ್ತಿಕ ವರ್ಷ',
    'download_pdf': 'PDF ಡೌನ್ಲೋಡ್ ಮಾಡಿ',
    'person': 'ವ್ಯಕ್ತಿ',
    'calculate_compatibility': 'ಅನುಕೂಲತೆ ಲೆಕ್ಕಿಸು',
      
      // Strengths & Planes
      'strengths_planes': 'ಶಕ್ತಿಗಳು ಮತ್ತು ಸಮತಲಗಳು',
      
      // Remedies
      'personalized_remedies': 'ವೈಯಕ್ತಿಕ ಪರಿಹಾರಗಳು',
      'strengthen_missing': 'ನಿಮ್ಮ ಚಾರ್ಟ್‌ನಲ್ಲಿ ಕಾಣೆಯಾದ ಸಂಖ್ಯೆಗಳನ್ನು ಬಲಪಡಿಸಿ',
      
      // Days of Week
      'sunday': 'ಭಾನುವಾರ',
      'monday': 'ಸೋಮವಾರ',
      'tuesday': 'ಮಂಗಳವಾರ',
      'wednesday': 'ಬುಧವಾರ',
      'thursday': 'ಗುರುವಾರ',
      'friday': 'ಶುಕ್ರವಾರ',
      'saturday': 'ಶನಿವಾರ',
      
      // Directions
      'east': 'ಪೂರ್ವ',
      'west': 'ಪಶ್ಚಿಮ',
      'north': 'ಉತ್ತರ',
      'south': 'ದಕ್ಷಿಣ',
      'north_east': 'ಈಶಾನ್ಯ',
      'north_west': 'ವಾಯುವ್ಯ',
      'south_east': 'ಆಗ್ನೇಯ',
      'south_west': 'ನೈಋತ್ಯ',
      
      // Colors
      'yellow_gold': 'ಹಳದಿ, ಚಿನ್ನ',
      'white_silver': 'ಬಿಳಿ, ಬೆಳ್ಳಿ',
      'yellow_orange': 'ಹಳದಿ, ಕಿತ್ತಳೆ',
      'blue_grey': 'ನೀಲಿ, ಬೂದು',
      'green': 'ಹಸಿರು',
      'white_light_blue': 'ಬಿಳಿ, ತಿಳಿ ನೀಲಿ',
      'light_green_white': 'ತಿಳಿ ಹಸಿರು, ಬಿಳಿ',
      'dark_blue_black': 'ಗಾಢ ನೀಲಿ, ಕಪ್ಪು',
      'red_pink': 'ಕೆಂಪು, ಗುಲಾಬಿ',
      
      // Planes
      'mental_plane': 'ಮಾನಸಿಕ ಸಮತಲ (ತೀಕ್ಷ್ಣ ಚಿಂತನೆ/ತರ್ಕ)',
      'emotional_plane': 'ಭಾವನಾತ್ಮಕ ಸಮತಲ (ಅಂತಃಪ್ರಜ್ಞೆ/ಶಾಂತಿ)',
      'practical_plane': 'ಪ್ರಾಯೋಗಿಕ ಸಮತಲ (ಕಠಿಣ ಪರಿಶ್ರಮ/ಕ್ರಿಯೆ)',
      'thought_plane': 'ಚಿಂತನೆ ಸಮತಲ (ಯೋಜನೆ/ದೃಷ್ಟಿ)',
      'will_plane': 'ಇಚ್ಛಾಶಕ್ತಿ ಸಮತಲ (ನಿರ್ಧಾರ/ಯಶಸ್ಸು)',
      'action_plane': 'ಕ್ರಿಯಾ ಸಮತಲ (ಕಾರ್ಯಗತಗೊಳಿಸುವಿಕೆ/ವೇಗ)',
      'golden_yog': 'ಸುವರ್ಣ ಯೋಗ (ಅತ್ಯಂತ ಸಂಪತ್ತು/ಯಶಸ್ಸು)',
      'silver_yog': 'ರಜತ ಯೋಗ (ಆಸ್ತಿ/ಸ್ಥಿರತೆ)',
      
      // Personal Year Messages
      'py_1': 'ಹೊಸ ಆರಂಭಗಳು ಮತ್ತು ನಾಯಕತ್ವದ ವರ್ಷ.',
      'py_2': 'ತಾಳ್ಮೆ, ಪಾಲುದಾರಿಕೆ ಮತ್ತು ಯೋಜನೆಯ ವರ್ಷ.',
      'py_3': 'ಸೃಜನಾತ್ಮಕತೆ, ಸಾಮಾಜಿಕೀಕರಣ ಮತ್ತು ಬೆಳವಣಿಗೆಯ ವರ್ಷ.',
      'py_4': 'ಕಠಿಣ ಪರಿಶ್ರಮ, ಶಿಸ್ತು ಮತ್ತು ಅಡಿಪಾಯದ ವರ್ಷ.',
      'py_5': 'ಬದಲಾವಣೆ, ಪ್ರಯಾಣ ಮತ್ತು ಸ್ವಾತಂತ್ರ್ಯದ ವರ್ಷ.',
      'py_6': 'ಕುಟುಂಬ, ಜವಾಬ್ದಾರಿ ಮತ್ತು ಸಂಬಂಧಗಳ ವರ್ಷ.',
      'py_7': 'ಆತ್ಮಾವಲೋಕನ, ಕಲಿಕೆ ಮತ್ತು ಆಧ್ಯಾತ್ಮಿಕತೆಯ ವರ್ಷ.',
      'py_8': 'ಹಣ, ಶಕ್ತಿ ಮತ್ತು ಭೌತಿಕ ಯಶಸ್ಸಿನ ವರ್ಷ.',
      'py_9': 'ಪೂರ್ಣತೆ, ತ್ಯಜಿಸುವುದು ಮತ್ತು ರೂಪಾಂತರದ ವರ್ಷ.',
      
      // Remedies
      'remedy_1': 'ಬೆಳ್ಳಿ ನಾಣ್ಯವನ್ನು ಹೊತ್ತುಕೊಳ್ಳಿ ಅಥವಾ ನಿಮ್ಮ ಮನೆಯ ಉತ್ತರ ದಿಕ್ಕಿನಲ್ಲಿ ನೀರಿನ ಕಾರಂಜಿಯನ್ನು ಬಳಸಿ.',
      'remedy_2': 'ಗುಲಾಬಿ ಸ್ಫಟಿಕಗಳ ಜೋಡಿಯನ್ನು ಇಡಿ ಅಥವಾ ನಿಮ್ಮ ಬೆರಳಿಗೆ ಬೆಳ್ಳಿಯ ಉಂಗುರವನ್ನು ಧರಿಸಿ.',
      'remedy_3': 'ಹಸಿರು ಗಿಡವನ್ನು (ತುಳಸಿ) ಇಡಿ ಅಥವಾ ಮರದ/ತುಳಸಿ ಬಳೆಯನ್ನು ಧರಿಸಿ.',
      'remedy_4': 'ನಿಮ್ಮ ಮಣಿಕಟ್ಟಿಗೆ ಹಸಿರು ದಾರವನ್ನು ಕಟ್ಟಿ ಅಥವಾ ದೈನಂದಿನ ಕೆಲಸಕ್ಕೆ ಮರದ ಪೆನ್ನನ್ನು ಬಳಸಿ.',
      'remedy_5': 'ಹಳದಿ ದಾರವನ್ನು ಧರಿಸಿ ಅಥವಾ ಮನೆಯ ಮಧ್ಯದಲ್ಲಿ (ಬ್ರಹ್ಮಸ್ಥಾನ) ಹಿತ್ತಾಳೆಯ ಗಂಟೆಯನ್ನು ಬಳಸಿ.',
      'remedy_6': 'ಬಿಳಿ ಗಡಿಯಾರವನ್ನು ಧರಿಸಿ ಅಥವಾ ಶುಕ್ರ ಶಕ್ತಿಯನ್ನು ಆಕರ್ಷಿಸಲು ಚಿನ್ನ/ಬೆಳ್ಳಿ ಅಲಂಕಾರಗಳನ್ನು ಬಳಸಿ.',
      'remedy_7': 'ಬೆಳ್ಳಿಯ ಸರವನ್ನು ಧರಿಸಿ ಅಥವಾ ನಿಮ್ಮ ಕೋಣೆಯ ಪಶ್ಚಿಮ ದಿಕ್ಕಿನಲ್ಲಿ ಲೋಹದ ಪಿರಮಿಡ್ ಅನ್ನು ಇಡಿ.',
      'remedy_8': 'ನೀಲಮಣಿ ಸ್ಫಟಿಕವನ್ನು ಬಳಸಿ ಅಥವಾ ಈಶಾನ್ಯ ದಿಕ್ಕಿನಲ್ಲಿ ಕಲ್ಲಿನ ವಸ್ತುವನ್ನು ಇಡಿ.',
      'remedy_9': 'ನಿಮ್ಮ ಖ್ಯಾತಿಯನ್ನು ಹೆಚ್ಚಿಸಲು ದಕ್ಷಿಣ ದಿಕ್ಕಿನಲ್ಲಿ ಕೆಂಪು ದೀಪ ಅಥವಾ ಕೆಂಪು ಮೇಣದಬತ್ತಿಯನ್ನು ಇಡಿ.',
    'mobile_number_optional': 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ (ಐಚ್ಛಿಕ)',
    'mobile_hint': 'ಉದಾ: 9876543210',
    'compatibility_calculator': 'ಅನುಕೂಲತೆ ಲೆಕ್ಕಾಚಾರ',
    'change_language': 'ಭಾಷೆ ಬದಲಿಸಿ',
    'personal_month_label': 'ವೈಯಕ್ತಿಕ ತಿಂಗಳು',
    'month_1': 'ಜನವರಿ',
    'month_2': 'ಫೆಬ್ರುವರಿ',
    'month_3': 'ಮಾರ್ಚ್',
    'month_4': 'ಏಪ್ರಿಲ್',
    'month_5': 'ಮೇ',
    'month_6': 'ಜೂನ್',
    'month_7': 'ಜುಲೈ',
    'month_8': 'ಆಗಸ್ಟ್',
    'month_9': 'ಸೆಪ್ಟೆಂಬರ್',
    'month_10': 'ಅಕ್ಟೋಬರ್',
    'month_11': 'ನವೆಂಬರ್',
    'month_12': 'ಡಿಸೆಂಬರ್',
  'complete_name_analysis': 'ಸಂಪೂರ್ಣ ಹೆಸರು ವಿಶ್ಲೇಷಣೆ',
  'expression_full_name': 'ವ್ಯಕ್ತಿತ್ವ (ಪೂರ್ಣ ಹೆಸರು)',
  'first_name_vibration': 'ಮೊದಲ ಹೆಸರು ಕಂಪನ',
  'family_legacy': 'ಕುಟುಂಬ ವಾರಸಾದ (ಅಂತಿಮ ಹೆಸರು)',
  'soul_urge_label': 'ಆತ್ಮ ಆಸೆ (ಆಂತರಿಕ ಇಚ್ಛೆ)',
  'personality_label': 'ವ್ಯಕ್ತಿತ್ವ (ಬಾಹ್ಯ ಚಿತ್ರ)',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for common translations
  String get appTitle => translate('app_title');
  String get discoverDestiny => translate('discover_destiny');
  String get enterDetails => translate('enter_details');
  String get fullName => translate('full_name');
  String get nameHint => translate('name_hint');
  String get selectBirthDate => translate('select_birth_date');
  String get dobLabel => translate('dob_label');
  String get gender => translate('gender');
  String get male => translate('male');
  String get female => translate('female');
  String get revealButton => translate('reveal_button');
  String get selectDateError => translate('select_date_error');
  String get luckyCompass => translate('lucky_compass');
  String get luckyColors => translate('lucky_colors');
  String get luckyDay => translate('lucky_day');
  String get direction => translate('direction');
  String get nameCorrection => translate('name_correction');
  String get enterNameToSuggest => translate('enter_name_to_suggest');
  String get noNameSuggestions => translate('no_name_suggestions');
  String get applySuggestion => translate('apply_suggestion');
  String get mobileAnalysis => translate('mobile_analysis');
  String get enterMobileToAnalyze => translate('enter_mobile_to_analyze');
  String get loShuGrid => translate('lo_shu_grid');
  String get coreNumbers => translate('core_numbers');
  String get timeCycles => translate('time_cycles');
  String get numbersLabel => translate('numbers_label');
  String get nameAnalysis => translate('name_analysis');
  String get enterNameToAnalyze => translate('enter_name_to_analyze');
  String get gridFrequencyAnalysis => translate('grid_frequency_analysis');
  String get arrowPatterns => translate('arrow_patterns');
  String get gridExplanation => translate('grid_explanation');
  String get excessiveNumbers => translate('excessive_numbers');
  String get balancedNumbers => translate('balanced_numbers');
  String get missingNumbers => translate('missing_numbers');
  String get appearsTimes => translate('appears_times');
  String get mobileNumberOptional => translate('mobile_number_optional');
  String get mobileHint => translate('mobile_hint');
  String get compatibilityCalculator => translate('compatibility_calculator');
  String get changeLanguage => translate('change_language');
  String get personalMonthLabel => translate('personal_month_label');
  String get strengths => translate('strengths');
  String get weaknesses => translate('weaknesses');
  String get suggestions => translate('suggestions');
  String get betterNumbers => translate('better_numbers');
  String get cancel => translate('cancel');
  String get apply => translate('apply');
  String get copiedClipboard => translate('copied_clipboard');
  String get numerologySummary => translate('numerology_summary');
  String get driverPsychic => translate('driver_psychic');
  String get conductorDestiny => translate('conductor_destiny');
  String get kuaNumber => translate('kua_number');
  String get nameNumber => translate('name_number');
  String get personalYear => translate('personal_year');
  String get strengthsPlanes => translate('strengths_planes');
  String get personalizedRemedies => translate('personalized_remedies');
  String get strengthenMissing => translate('strengthen_missing');
  String get person => translate('person');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'kn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
