# Using GitHub Actions to Build APK

## 🚀 Automatic APK Builds

Your project is now set up to automatically build Android APK files using GitHub Actions!

## How It Works

### Automatic Builds
Every time you push code to GitHub, the system will automatically:
1. ✅ Set up Flutter environment
2. ✅ Install dependencies
3. ✅ Build release APK
4. ✅ Build split APKs (smaller sizes)
5. ✅ Upload APKs as downloadable artifacts

### Manual Builds
You can also trigger builds manually:
1. Go to your GitHub repository
2. Click "Actions" tab
3. Click "Build Android APK" workflow
4. Click "Run workflow" button
5. Select branch and click "Run workflow"

## 📥 How to Download Your APK

### After Each Build:

1. **Go to GitHub Actions**
   - Open: https://github.com/LuSho/auragrids/actions
   - (Replace with your actual repo URL)

2. **Click on Latest Workflow Run**
   - You'll see "Build Android APK"
   - Click on the most recent run

3. **Download Artifacts**
   - Scroll down to "Artifacts" section
   - You'll see:
     - **app-release** (universal APK ~15-20 MB)
     - **split-apks** (optimized APKs ~8-10 MB each)

4. **Extract and Install**
   - Download the ZIP file
   - Extract it
   - Transfer APK to your Android device
   - Install

## 📱 Which APK to Use?

| APK File | Size | Use For |
|----------|------|---------|
| **app-release.apk** | ~20 MB | Any Android device |
| **app-arm64-v8a-release.apk** | ~10 MB | Modern phones (2018+) |
| **app-armeabi-v7a-release.apk** | ~10 MB | Older phones |
| **app-x86_64-release.apk** | ~10 MB | Emulators |

**Recommendation:** Download **app-release.apk** - it works on all devices.

## 🏷️ Creating Releases

### To create a versioned release:

```bash
# Tag your version
git tag v1.0.0
git push origin v1.0.0
```

This will:
- ✅ Build the APK
- ✅ Create a GitHub Release
- ✅ Attach APKs to the release
- ✅ Make it easy to download

### Example Release URLs:
- https://github.com/LuSho/auragrids/releases/tag/v1.0.0
- Direct download from Releases page

## 🎯 Step-by-Step: Get Your First APK

### 1. Push to GitHub (if not already done)
```bash
cd /Users/I563281/Documents/GitHub/LuSho/auragrids
git add .
git commit -m "Add GitHub Actions for APK builds"
git push origin main
```

### 2. Wait for Build (5-10 minutes)
- GitHub will automatically start building
- You can watch progress in Actions tab

### 3. Download APK
- Go to Actions tab
- Click on your workflow run
- Download from Artifacts section

## 🔄 Build Status Badge

Add this to your README.md to show build status:

```markdown
![Build APK](https://github.com/LuSho/auragrids/workflows/Build%20Android%20APK/badge.svg)
```

## ⚡ Quick Commands

### Push code and trigger build:
```bash
git add .
git commit -m "Update app"
git push
```

### Create a new release:
```bash
# Update version in pubspec.yaml first
git add pubspec.yaml
git commit -m "Bump version to 1.1.0"
git tag v1.1.0
git push origin main
git push origin v1.1.0
```

## 📊 Build Time

- **First build:** ~8-10 minutes (downloads dependencies)
- **Subsequent builds:** ~5-7 minutes (uses cache)

## 🐛 Troubleshooting

### Build fails?
1. Check the Actions tab for error details
2. Make sure all code is committed
3. Verify pubspec.yaml has no errors

### Can't find APK?
1. Wait for build to complete (green checkmark)
2. Scroll to bottom of workflow run page
3. Look for "Artifacts" section

### Build successful but no artifact?
- Make sure you're looking at the completed workflow run
- Check that the build step succeeded

## 💡 Benefits

✅ **No Android Studio needed** - Builds happen in the cloud
✅ **Free** - GitHub Actions is free for public repositories
✅ **Automatic** - Builds on every push
✅ **Multiple formats** - Universal and split APKs
✅ **Always available** - Download anytime from Actions tab

## 📝 Notes

- Builds are stored for 90 days
- You can download them multiple times
- Each push creates a new build
- Old artifacts are automatically cleaned up

---

## 🎉 You're All Set!

Your project is now configured for automatic APK builds. Just push your code to GitHub and get your APK! 🚀
