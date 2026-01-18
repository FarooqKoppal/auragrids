# AuraGrids - Numerology Calculator 🔮

A beautiful, feature-rich Flutter application for numerological calculations based on Lo Shu Grid, Kua Numbers, and Chaldean Numerology. Available in **English** and **ಕನ್ನಡ (Kannada)**.

![Flutter](https://img.shields.io/badge/Flutter-3.27.1-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.6.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📱 Features

- ✨ **Lo Shu Grid Calculator** - Ancient Chinese numerology grid visualization
- 🧭 **Lucky Compass** - Visual display of lucky colors, days, and directions
- 📅 **Personal Year Calculator** - Know what 2026 holds for you
- 🎯 **Kua Number** - Feng Shui success number based on birth year and gender
- 📝 **Chaldean Name Number** - Calculate your name's vibrational energy
- 💡 **Personalized Remedies** - Spiritual solutions for missing numbers
- 🎨 **Dual Themes** - Switch between Zen (Light) and Minimalist (Dark) themes
- 🌐 **Multi-Language** - Full support for English and Kannada
- 📊 **Plane Detection** - Discover strengths (Golden Yog, Silver Yog, etc.)
- 🎭 **Beautiful UI** - Gradient cards, smooth animations, color visualization
- 📴 **Offline** - Works without internet connection

## 🖼️ Screenshots

| Home Screen | Lo Shu Grid | Lucky Compass | Remedies |
|------------|-------------|---------------|----------|
| Input Form | 3×3 Grid | Colors & Days | Solutions |

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

#### 1. **Flutter SDK** (Required)

**Check if Flutter is installed:**
```bash
flutter --version
```

**If not installed:**

**macOS/Linux:**
```bash
# Download Flutter
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Add to your shell config (~/.zshrc or ~/.bashrc)
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter doctor
```

**Windows:**
1. Download from: https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add to PATH
4. Run `flutter doctor`

**Minimum Required Version:** Flutter 3.0.0+

---

#### 2. **Development Tools**

Install **ONE** of the following:

**Option A: VS Code** (Lightweight, Recommended)
```bash
# Install VS Code from: https://code.visualstudio.com/

# Install Flutter Extension:
# 1. Open VS Code
# 2. Press Cmd+Shift+X (Mac) or Ctrl+Shift+X (Windows)
# 3. Search "Flutter"
# 4. Install "Flutter" extension by Dart Code
```

**Option B: Android Studio** (Full-featured)
```bash
# Download from: https://developer.android.com/studio
# Install and setup Android SDK
```

---

#### 3. **Platform-Specific Setup**

**For Web Development (Recommended for quick start):**
```bash
# Chrome is required
# Install Chrome from: https://www.google.com/chrome/
```

**For Android Development:**
```bash
# Install Android Studio
# Setup Android SDK
# Accept licenses:
flutter doctor --android-licenses
```

**For iOS Development (macOS only):**
```bash
# Install Xcode from App Store
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Install CocoaPods
sudo gem install cocoapods
```

---

### 📥 Installation

#### Step 1: Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/auragrids.git
cd auragrids
```

#### Step 2: Install Dependencies

```bash
# Get all Flutter packages
flutter pub get
```

This will install:
- `flutter_localizations` - For multi-language support
- `cupertino_icons` - iOS-style icons
- All other required packages from `pubspec.yaml`

#### Step 3: Verify Setup

```bash
# Check for any issues
flutter doctor -v

# Expected output:
# ✓ Flutter (Channel stable, 3.x.x)
# ✓ Chrome - develop for the web (or other platforms)
```

---

### ▶️ Running the Application

#### Run on Web (Easiest - No setup needed)

**Quick Start (Recommended):**
```bash
./run.sh
# Choose option 2 for release mode (fast, clean)
```

**Manual Commands:**
```bash
# Development mode (has harmless warnings)
flutter run -d chrome

# Release mode (RECOMMENDED: fast, no warnings)
flutter run -d chrome --release
```

**Access the app at:** `http://localhost:port` (auto-opens in Chrome)

⚠️ **Note:** Debug mode may show harmless "pointer binding" console warnings - these are normal Flutter Web artifacts and don't affect functionality. Use release mode for clean experience.

📚 **Troubleshooting:** See [TROUBLESHOOTING_WEB.md](TROUBLESHOOTING_WEB.md) for common issues.

---

#### Run on Android Device/Emulator

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>

# Release mode
flutter run --release
```

---

#### Run on iOS Simulator (macOS only)

```bash
# List available simulators
flutter devices

# Run on iOS simulator
flutter run -d iPhone

# Specific simulator
open -a Simulator
flutter run -d <simulator-id>
```

---

#### Run on Desktop

**macOS:**
```bash
flutter run -d macos
```

**Windows:**
```bash
flutter run -d windows
```

**Linux:**
```bash
flutter run -d linux
```

---

### 🔧 Troubleshooting Common Issues

#### Issue 1: "Flutter not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
# Or use full path:
/path/to/flutter/bin/flutter run
```

#### Issue 2: "Packages not found"
```bash
# Clean and reinstall
flutter clean
flutter pub get
```

#### Issue 3: "Chrome not found"
```bash
# Install Chrome browser
# Or specify Chrome path:
export CHROME_EXECUTABLE=/path/to/chrome
```

#### Issue 4: "Android licenses not accepted"
```bash
flutter doctor --android-licenses
# Press 'y' to accept all
```

#### Issue 5: "CocoaPods not installed" (macOS)
```bash
sudo gem install cocoapods
pod setup
```

#### Issue 6: "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

---

## 🏗️ Project Structure

```
auragrids/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── calculator.dart              # Core numerology logic
│   ├── l10n/
│   │   └── app_localizations.dart   # Multi-language translations
│   ├── models/
│   │   └── numerology_data.dart     # Data models
│   ├── screens/
│   │   └── home_screen.dart         # Main screen
│   ├── theme/
│   │   └── app_theme.dart           # App themes
│   ├── utils/
│   │   └── localized_data.dart      # Localization helpers
│   └── widgets/
│       ├── info_card.dart           # Info display card
│       ├── loshu_grid.dart          # Lo Shu grid widget
│       ├── lucky_compass_card.dart  # Lucky compass widget
│       └── remedy_card.dart         # Remedy display card
├── android/                         # Android-specific files
├── ios/                             # iOS-specific files
├── web/                             # Web-specific files
├── test/                            # Unit tests
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

---

## 📦 Building for Production

### Build Web App

```bash
# Build for production
flutter build web --release

# Output: build/web/
# Deploy to any web hosting service
```

### Build Android APK

**Option 1: Using GitHub Actions (Recommended)**
```bash
# Push to GitHub and Actions will build automatically
git push origin main
# Download APK from GitHub Actions tab
```

**Option 2: Build Locally (Requires Android SDK)**
```bash
# Universal APK (~15-20 MB)
flutter build apk --release

# Split APKs (~8-10 MB each)
flutter build apk --split-per-abi --release

# Output: build/app/outputs/flutter-apk/
```

**See:** [BUILD_APK_GUIDE.md](BUILD_APK_GUIDE.md) for detailed instructions

### Build iOS App (macOS only)

```bash
# Build IPA
flutter build ios --release

# Or open in Xcode
open ios/Runner.xcworkspace
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

---

## 📚 Dependencies

All dependencies are managed in `pubspec.yaml`:

### Main Dependencies:
- **flutter** - UI framework
- **flutter_localizations** - Multi-language support
- **cupertino_icons** - iOS-style icons

### Dev Dependencies:
- **flutter_test** - Testing framework
- **flutter_lints** - Code quality

**To update dependencies:**
```bash
flutter pub upgrade
```

---

## 🌐 Internationalization (i18n)

Currently supported languages:
- 🇬🇧 English (`en`)
- 🇮🇳 ಕನ್ನಡ Kannada (`kn`)

**To add a new language:**

1. Edit `lib/l10n/app_localizations.dart`
2. Add translations for new language code
3. Update `supportedLocales` in `main.dart`
4. See: [KANNADA_LOCALIZATION.md](KANNADA_LOCALIZATION.md)

---

## 🎨 Themes

Two built-in themes:
1. **Zen Theme** (Light) - Teal & Cream colors
2. **Minimalist Theme** (Dark) - Black & White

Toggle themes using the palette icon (🎨) in the app bar.

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 Additional Documentation

- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) - Detailed architecture
- [BUILD_APK_GUIDE.md](BUILD_APK_GUIDE.md) - How to build Android APK
- [GITHUB_ACTIONS_GUIDE.md](GITHUB_ACTIONS_GUIDE.md) - Automated builds
- [KANNADA_LOCALIZATION.md](KANNADA_LOCALIZATION.md) - Language support
- [GET_YOUR_APK.md](GET_YOUR_APK.md) - Quick APK download guide

---

## 🐛 Known Issues

### Web-specific:
- Minor pointer binding warnings in Chrome console (doesn't affect functionality)
- These are Flutter Web engine issues and can be safely ignored

---

## 📱 Platform Support

| Platform | Status | Tested |
|----------|--------|--------|
| Web | ✅ Full Support | ✓ |
| Android | ✅ Full Support | ✓ |
| iOS | ✅ Full Support | ○ |
| macOS | ✅ Full Support | ○ |
| Windows | ✅ Full Support | ○ |
| Linux | ✅ Full Support | ○ |

**Minimum Requirements:**
- Web: Modern browser (Chrome, Firefox, Safari, Edge)
- Android: 5.0 Lollipop (API 21) or higher
- iOS: 12.0 or higher
- macOS: 10.14 or higher
- Windows: Windows 10 or higher
- Linux: Ubuntu 20.04 or equivalent

---

## 📊 Performance

- App size (Release APK): ~15-20 MB (Universal), ~8-10 MB (Split)
- First load: < 3 seconds
- Calculations: Instant
- Supports offline usage

---

## 🔐 Privacy

- No data collection
- No internet connection required
- All calculations done locally
- No third-party analytics

---

## 📞 Support

If you encounter any issues:

1. Check [Troubleshooting](#-troubleshooting-common-issues) section
2. Run `flutter doctor -v` and fix any issues
3. Clean and rebuild: `flutter clean && flutter pub get`
4. Check existing GitHub Issues
5. Create a new issue with details

---

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👨‍💻 Author

Created with ❤️ for numerology enthusiasts

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Lo Shu Grid and numerology experts for the calculations
- Open source community

---

## 🚀 Quick Start Commands

```bash
# Complete setup and run
git clone https://github.com/YOUR-USERNAME/auragrids.git
cd auragrids
flutter pub get
flutter run -d chrome

# That's it! The app should open in Chrome.
```

---

## 💡 Tips for New Contributors

1. **Start with Web:** Easiest to set up and test
2. **Use Hot Reload:** Press `r` in terminal while app is running
3. **Check Documentation:** Comprehensive guides in `/docs` folder
4. **Run Tests:** Before submitting PRs
5. **Follow Flutter Best Practices:** Use `flutter analyze`

---

**Happy Numerology Calculating! 🌟**
