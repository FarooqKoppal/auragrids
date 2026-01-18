# AuraGrids - Numerology Calculator 🔮

A beautiful and intuitive Flutter application for numerological calculations based on Lo Shu Grid, Kua Numbers, and Chaldean Numerology.

## ✨ Features

- **Lo Shu Grid Calculator** - Ancient Chinese numerology grid visualization
- **Lucky Compass** - Displays lucky colors (visual circles), days, and directions
- **Personal Year Calculation** - Know what 2026 holds for you
- **Kua Number** - Feng Shui success number based on birth year and gender
- **Chaldean Name Number** - Calculate your name's vibrational energy
- **Personalized Remedies** - Get spiritual solutions for missing numbers
- **Plane Detection** - Discover your strengths (Golden Yog, Silver Yog, Mental/Emotional/Practical Planes)
- **Dual Themes** - Switch between Zen (Light) and Minimalist (Dark) themes
- **Smooth Animations** - Elegant fade-in effects for results

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── calculator.dart              # Core numerology calculation logic
├── models/
│   └── numerology_data.dart    # Data models (Gender, NumerologyResult, LuckyFactors)
├── screens/
│   └── home_screen.dart        # Main home screen with input and results
├── theme/
│   └── app_theme.dart          # Centralized theme configuration
└── widgets/
    ├── lucky_compass_card.dart # Lucky compass component with color circles
    ├── loshu_grid.dart         # 3x3 Lo Shu Grid visualization
    ├── info_card.dart          # Reusable info card for summaries
    └── remedy_card.dart        # Beautiful remedy display cards
```

## 🎨 UI Enhancements

### Lucky Compass
- **Visual Color Display**: Instead of just text, shows actual color circles
- **Gradient Background**: Amber to orange gradient for premium look
- **Dividers**: Clean separation between lucky factors
- **Icons**: Calendar for days, compass for directions

### Lo Shu Grid
- **Gradient Container**: Teal gradient background
- **Animated Cells**: Smooth transitions when numbers appear
- **Kua Highlighting**: Special amber highlight for Kua number
- **Count Badges**: Shows repetition count for numbers appearing multiple times
- **Glow Effects**: Box shadows for active cells

### Remedy Cards
- **Gradient Design**: White to amber gradient
- **Number Badges**: Circular gradient badges for missing numbers
- **Lightbulb Icon**: Visual indicator for remedy tips
- **Border Accents**: Subtle amber borders

### Input Section
- **Validation**: Shows snackbar if birth date is missing
- **Gender Icons**: Male/Female icons in choice chips
- **Color-coded Gender**: Blue for male, pink for female
- **Date Format**: Clean DD / MM / YYYY display
- **Call-to-action**: Prominent "REVEAL MY DESTINY" button

## 🔧 Technical Improvements

### Modularization
- **Separation of Concerns**: UI, logic, and data are separated
- **Reusable Components**: All widgets can be reused
- **Easy Maintenance**: Changes in one file don't affect others
- **Scalability**: Easy to add new features

### Code Quality
- **Type Safety**: Proper type definitions and enums
- **Single Responsibility**: Each class has one clear purpose
- **DRY Principle**: No code duplication
- **Clean Architecture**: Clear folder structure

### Performance
- **Animation Controller**: Proper disposal to prevent memory leaks
- **Lazy Loading**: Results only render after calculation
- **Optimized Rebuilds**: Only necessary widgets rebuild

## 🚀 Running the App

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run on mobile device
flutter run

# Build for production
flutter build web
flutter build apk
flutter build ios
```

## 📱 Supported Platforms

- ✅ Web (Chrome, Firefox, Safari, Edge)
- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🎯 Future Enhancements

- [ ] Multi-language support (Hindi, Chinese)
- [ ] Share results as image
- [ ] Save calculation history
- [ ] Detailed reports with PDF export
- [ ] Compatibility checker (two birth dates)
- [ ] Auspicious date calculator
- [ ] Gemstone recommendations
- [ ] Interactive tutorials

## 📚 Numerology Concepts

### Driver Number (Psychic)
- Based on birth day
- Represents inner self and desires
- Determines lucky colors, days, and directions

### Conductor Number (Destiny)
- Sum of full birth date
- Life path and purpose
- External personality

### Kua Number
- Based on birth year and gender
- Feng Shui success number
- Male: 11 - (year sum), Female: 4 + (year sum)

### Name Number
- Chaldean numerology system
- Vibrational energy of name
- Influences career and relationships

### Personal Year
- Changes yearly
- Based on birth date + current year
- Predicts themes for the year

## 🛠️ Tech Stack

- **Flutter**: UI framework
- **Dart**: Programming language
- **Material Design 3**: Design system

## 📄 License

This project is open source and available for educational purposes.

## 👨‍💻 Developer

Created with ❤️ for numerology enthusiasts

---

**Note**: This app is for entertainment and spiritual guidance purposes. Results should be interpreted with wisdom and personal judgment.
