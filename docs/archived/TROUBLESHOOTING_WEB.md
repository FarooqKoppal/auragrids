# Troubleshooting Guide - Web Platform

## Common Issues When Running `flutter run -d chrome`

### 1. Pointer Binding Assertions (Debug Mode)

**Error Message:**
```
DartError: Assertion failed: org-dartlang-sdk:///lib/_engine/engine/pointer_binding/event_position_helper.dart:70:10
targetElement == domElement
"The targeted input element must be the active input element"
```

**Cause:** This is a known Flutter Web debug mode issue when interacting with TextField widgets.

**Impact:** ⚠️ **HARMLESS** - Does not affect functionality. The app works perfectly.

**Solutions:**
1. **Ignore it** - It's just a debug warning
2. **Use release mode:**
   ```bash
   flutter run -d chrome --release
   ```
3. **Build for production:**
   ```bash
   flutter build web --release
   cd build/web
   python3 -m http.server 8000
   # Open http://localhost:8000
   ```

**Reference:** https://github.com/flutter/flutter/issues/98417

---

### 2. Failed to Load Fonts

**Error Message:**
```
Failed to load font Roboto at https://fonts.gstatic.com/s/roboto/v20/KFOmCnqEu92Fr1Me5WZLCzYlKw.ttf
```

**Cause:** 
- Network connectivity issues
- Corporate firewall blocking Google Fonts CDN
- VPN/Proxy restrictions

**Impact:** ⚠️ **MINOR** - App uses fallback system fonts instead.

**Solutions:**

1. **Check Internet Connection:**
   ```bash
   curl -I https://fonts.gstatic.com
   ```

2. **Use Custom Fonts Locally:**
   - Download Roboto font
   - Add to `pubspec.yaml`:
     ```yaml
     flutter:
       fonts:
         - family: Roboto
           fonts:
             - asset: fonts/Roboto-Regular.ttf
             - asset: fonts/Roboto-Bold.ttf
               weight: 700
     ```

3. **Disable Google Fonts** (use system fonts):
   - App already falls back automatically
   - No action needed

---

### 3. Failed to Fetch CanvasKit

**Error Message:**
```
TypeError: Failed to fetch dynamically imported module: 
https://www.gstatic.com/flutter-canvaskit/.../canvaskit.js
```

**Cause:** 
- Same as fonts - network/firewall issue
- Flutter trying to load CanvasKit renderer from CDN

**Solutions:**

1. **Use HTML Renderer** (deprecated but works):
   ```bash
   flutter run -d chrome --web-renderer html
   ```
   
2. **Use Release Mode** (bundles CanvasKit locally):
   ```bash
   flutter build web --release
   ```

3. **Wait for initial download** - First run downloads and caches CanvasKit

---

### 4. Slow Initial Load Time

**Issue:** App takes 10-15 seconds to load in debug mode.

**Cause:** Debug mode includes:
- DevTools debugger
- Hot reload functionality
- Source maps
- Unminified code

**Solutions:**

1. **Use Release Mode:**
   ```bash
   flutter run -d chrome --release
   ```
   Load time: **2-3 seconds** ⚡

2. **Use Profile Mode** (debug + performance):
   ```bash
   flutter run -d chrome --profile
   ```

3. **Build Static Web:**
   ```bash
   flutter build web --release
   ```
   Then serve with:
   ```bash
   cd build/web
   python3 -m http.server 8000
   ```

---

### 5. App Crashes on Hot Reload

**Issue:** App crashes when pressing 'r' for hot reload.

**Solutions:**
1. Use **Hot Restart** instead: Press `R` (capital R)
2. Restart app completely: `q` then `flutter run -d chrome`
3. Clear cache:
   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

---

## 🚀 Recommended Development Workflow

### For Development (Debug Mode)
```bash
flutter run -d chrome
```
- **Pros:** Hot reload, debugging, DevTools
- **Cons:** Slower, shows warnings
- **When:** Active development

### For Testing (Release Mode)
```bash
flutter run -d chrome --release
```
- **Pros:** Fast, no warnings, production-like
- **Cons:** No hot reload, no debugging
- **When:** Testing final behavior

### For Production (Build)
```bash
flutter build web --release
cd build/web
python3 -m http.server 8000
```
- **Pros:** Fastest, optimized, cached
- **Cons:** Need to rebuild for changes
- **When:** Final testing, deployment

---

## 🎯 Quick Fixes Summary

| Issue | Quick Fix |
|-------|-----------|
| Pointer binding errors | Ignore (harmless) or use `--release` |
| Font loading failed | Ignore (uses fallback fonts) |
| CanvasKit failed | Use `--web-renderer html` |
| Slow load time | Use `--release` mode |
| Network issues | Check firewall/proxy settings |

---

## 📊 Performance Comparison

| Mode | Load Time | App Size | Hot Reload | Debugging |
|------|-----------|----------|------------|-----------|
| Debug | 10-15s | ~15 MB | ✅ Yes | ✅ Yes |
| Profile | 5-8s | ~8 MB | ❌ No | ⚠️ Limited |
| Release | 2-3s | ~2 MB | ❌ No | ❌ No |

---

## ✅ Verification Checklist

- [ ] App loads in browser (even with warnings)
- [ ] Can enter name and date
- [ ] Can click "Reveal Your Aura"
- [ ] Results display correctly
- [ ] Can switch language (🌐 icon)
- [ ] Can switch theme (🎨 icon)
- [ ] Planes show with numbers

**If all checked** → App is working perfectly! Warnings are normal in debug mode.

---

## 🆘 Still Having Issues?

1. **Clear Flutter cache:**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Update Flutter:**
   ```bash
   flutter upgrade
   ```

3. **Check Flutter doctor:**
   ```bash
   flutter doctor -v
   ```

4. **Try different browser:**
   ```bash
   flutter run -d edge
   # or
   flutter run -d firefox
   ```

5. **Check Chrome version:**
   - Minimum: Chrome 100+
   - Update Chrome if needed

---

**Bottom Line:** If the app loads and works (even with console warnings), you're good! The warnings are debug-mode artifacts that won't appear in production. 🎉
