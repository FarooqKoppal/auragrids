# Quick Setup Guide for New Users

This is a condensed guide to get you up and running quickly.

## ⚡ Super Quick Start (5 minutes)

### Prerequisites Check
```bash
# Do you have Flutter?
flutter --version

# If not, install from: https://docs.flutter.dev/get-started/install
```

### Setup & Run
```bash
# 1. Clone
git clone https://github.com/YOUR-USERNAME/auragrids.git
cd auragrids

# 2. Install dependencies
flutter pub get

# 3. Run on web (easiest)
flutter run -d chrome
```

That's it! App should open in Chrome. 🎉

---

## 📋 Detailed Setup (If Quick Start Failed)

### Step 1: Install Flutter

**macOS:**
```bash
# Download Flutter
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify
flutter doctor
```

**Windows:**
1. Download: https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add to System PATH
4. Restart terminal
5. Run `flutter doctor`

**Linux:**
```bash
sudo snap install flutter --classic
flutter doctor
```

### Step 2: Install an IDE

**VS Code (Recommended):**
```bash
# Download from: https://code.visualstudio.com/
# Install Flutter extension from Extensions panel
```

**Android Studio:**
```bash
# Download from: https://developer.android.com/studio
# Includes Android SDK automatically
```

### Step 3: Platform Setup

**For Web (No setup needed):**
- Just have Chrome installed

**For Android:**
```bash
# Install Android Studio
# Then run:
flutter doctor --android-licenses
# Press 'y' to accept all
```

**For iOS (macOS only):**
```bash
# Install Xcode from App Store
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo gem install cocoapods
```

---

## 🔧 Common Issues & Solutions

### "Flutter command not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

### "No devices found"
```bash
# For web: Install Chrome
# For Android: Start an emulator or connect device
# For iOS: Open Simulator
```

### "Packages not found"
```bash
flutter clean
flutter pub get
```

### "Build failed"
```bash
# Clear everything and rebuild
flutter clean
rm -rf build/
flutter pub get
flutter run
```

---

## 📱 Running on Different Platforms

### Web
```bash
flutter run -d chrome
# or
flutter run -d edge
# or
flutter run -d firefox
```

### Android
```bash
# List devices
flutter devices

# Run on device
flutter run

# Run on emulator
flutter emulators
flutter emulators --launch <emulator-id>
flutter run
```

### iOS (macOS only)
```bash
# Open simulator
open -a Simulator

# Run
flutter run
```

### Desktop
```bash
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

---

## 📦 Understanding the Project

### Required Packages (auto-installed)
- `flutter` - UI framework
- `flutter_localizations` - Language support
- `cupertino_icons` - Icons

### File You'll Edit Most
- `lib/main.dart` - App entry
- `lib/screens/home_screen.dart` - Main screen
- `lib/calculator.dart` - Calculation logic
- `lib/l10n/app_localizations.dart` - Translations

### Don't Touch These (unless you know what you're doing)
- `android/` - Android config
- `ios/` - iOS config
- `web/` - Web config
- `pubspec.lock` - Locked dependencies

---

## 🎯 What to Do After Setup

1. **Explore the App**
   ```bash
   flutter run -d chrome
   ```

2. **Try Hot Reload**
   - Make a change in code
   - Press `r` in terminal
   - See instant update!

3. **Change Language**
   - Click 🌐 icon in app
   - Select Kannada
   - See UI change to ಕನ್ನಡ

4. **Switch Theme**
   - Click 🎨 icon
   - Toggle between light/dark

---

## 🚀 Next Steps

- Read full [README.md](README.md)
- Check [CONTRIBUTING.md](CONTRIBUTING.md) if you want to help
- See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for architecture
- Build APK: See [BUILD_APK_GUIDE.md](BUILD_APK_GUIDE.md)

---

## 📞 Need Help?

### Check These First
1. Run `flutter doctor` and fix any ❌
2. Try `flutter clean && flutter pub get`
3. Restart your IDE
4. Check Flutter version: `flutter --version`

### Still Stuck?
- Open a GitHub Issue
- Include:
  - Your OS
  - Flutter version
  - Error message
  - What you tried

---

## ✅ Verification Checklist

Before you start developing, verify:

- [ ] `flutter --version` works
- [ ] `flutter doctor` shows ✓ for Flutter
- [ ] `flutter doctor` shows ✓ for Chrome (or your platform)
- [ ] `flutter pub get` completes successfully
- [ ] `flutter run -d chrome` opens the app
- [ ] You can change language in the app
- [ ] You can switch themes in the app

If all ✓ = You're ready to code! 🎉

---

**Time to complete:** 15-30 minutes (first time)

**Next time:** Just `git pull && flutter pub get && flutter run` (30 seconds!)
