# Building Android APK - AuraGrids

## 📱 How to Build APK for Android

### Quick Build Commands

#### **1. Build Debug APK (For Testing)**
```bash
flutter build apk --debug
```
- Location: `build/app/outputs/flutter-apk/app-debug.apk`
- Size: ~45-50 MB
- Use: Testing on your device

#### **2. Build Release APK (Optimized)**
```bash
flutter build apk --release
```
- Location: `build/app/outputs/flutter-apk/app-release.apk`
- Size: ~15-20 MB (optimized)
- Use: Distribution to others

#### **3. Build Split APKs (Smaller Size)**
```bash
flutter build apk --split-per-abi
```
- Creates 3 separate APKs for different processors
- Locations:
  - `app-armeabi-v7a-release.apk` (older 32-bit devices)
  - `app-arm64-v8a-release.apk` (modern 64-bit devices)
  - `app-x86_64-release.apk` (emulators)
- Size: ~8-10 MB each
- Use: Upload to Play Store (automatically selects right one)

### 🚀 Step-by-Step Installation

#### **Step 1: Build the APK**
```bash
cd /Users/I563281/Documents/GitHub/LuSho/auragrids
flutter build apk --release
```

#### **Step 2: Locate the APK**
After build completes, find your APK at:
```
build/app/outputs/flutter-apk/app-release.apk
```

#### **Step 3: Transfer to Android Device**

**Option A: USB Cable**
1. Connect your Android device via USB
2. Copy `app-release.apk` to your device's Download folder
3. On device: Open "Files" or "My Files" app
4. Navigate to Downloads
5. Tap on `app-release.apk`
6. Allow "Install from unknown sources" if prompted
7. Tap "Install"

**Option B: Google Drive / Dropbox**
1. Upload `app-release.apk` to cloud storage
2. Open link on Android device
3. Download and install

**Option C: Email**
1. Email the APK to yourself
2. Open email on Android device
3. Download attachment and install

**Option D: ADB (Android Debug Bridge)**
```bash
# Make sure device is connected via USB with USB debugging enabled
adb install build/app/outputs/flutter-apk/app-release.apk
```

### 📋 App Configuration

Your app is now configured with:

**Package Name:** `com.lusho.auragrids`
**App Name:** AuraGrids
**Version:** 1.0.0 (Version Code: 1)
**Min SDK:** Android 5.0 (API 21) - Supports 99%+ devices
**Target SDK:** Android 14 (API 34)

### 🔧 Build Types Explained

| Build Type | Command | Size | Speed | Use Case |
|------------|---------|------|-------|----------|
| Debug | `flutter build apk --debug` | ~45 MB | Fast | Testing & debugging |
| Profile | `flutter build apk --profile` | ~20 MB | Medium | Performance testing |
| Release | `flutter build apk --release` | ~15 MB | Optimized | Distribution |

### ⚡ Advanced Build Options

#### **Build APK with custom name**
```bash
flutter build apk --release --target-platform android-arm64
```

#### **Build with verbose output**
```bash
flutter build apk --release -v
```

#### **Clean build (if having issues)**
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### 📱 Device Compatibility

Your APK will work on:
- ✅ Android 5.0 Lollipop (2014) and newer
- ✅ 99%+ of all Android devices
- ✅ Tablets (any size)
- ✅ Phones (any size)
- ✅ Foldable devices

### 🎨 Features in APK

The APK includes all features:
- ✅ English & Kannada language support
- ✅ Theme switching (Zen & Minimalist)
- ✅ Lo Shu Grid calculator
- ✅ Lucky Compass with color visualization
- ✅ Personal Year calculator
- ✅ Kua number calculator
- ✅ Name number (Chaldean)
- ✅ Personalized remedies
- ✅ Offline functionality (no internet required)

### 🔒 Security Notes

**Current Build:** Debug signing (for testing only)

For Play Store or production:
1. Generate a keystore
2. Configure `android/key.properties`
3. Update `android/app/build.gradle`

See: https://docs.flutter.dev/deployment/android#signing-the-app

### 📦 File Sizes (Approximate)

- **Debug APK:** ~45 MB
- **Release APK:** ~15-20 MB
- **Split APK (arm64-v8a):** ~8-10 MB
- **Split APK (armeabi-v7a):** ~8-10 MB

### 🐛 Troubleshooting

#### **Build fails with Gradle error**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

#### **"SDK not found" error**
```bash
flutter doctor
# Follow instructions to install Android SDK
```

#### **Permission denied (gradlew)**
```bash
cd android
chmod +x gradlew
cd ..
flutter build apk --release
```

### 📱 Testing the APK

After installation:
1. Look for "AuraGrids" app icon on your device
2. Open the app
3. Test language switching (🌐 icon)
4. Test theme switching (🎨 icon)
5. Enter your birth details
6. Verify all calculations work

### 🚀 Next Steps

1. **Test thoroughly** on multiple devices if possible
2. **Gather feedback** from users
3. **Consider Play Store** if you want wider distribution
4. **Version updates** - increment version number in `pubspec.yaml` and rebuild

### 📊 Build Output Location

```
auragrids/
└── build/
    └── app/
        └── outputs/
            └── flutter-apk/
                ├── app-release.apk           # Main release APK
                ├── app-debug.apk             # Debug APK
                ├── app-armeabi-v7a-release.apk   # 32-bit ARM
                ├── app-arm64-v8a-release.apk     # 64-bit ARM
                └── app-x86_64-release.apk        # x86 64-bit
```

### 💡 Tips

1. **Use split APKs** for Play Store - smaller download for users
2. **Test on real device** before sharing with others
3. **Keep APK file** for backup/reinstallation
4. **Document version** - note which version you're distributing

---

**Ready to build?** Run this command now:

```bash
flutter build apk --release
```

The APK will be ready in ~2-5 minutes! 🎉
