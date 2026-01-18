# Contributing to AuraGrids

Thank you for your interest in contributing to AuraGrids! 🎉

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Code Style](#code-style)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Adding New Features](#adding-new-features)
- [Adding New Languages](#adding-new-languages)

## 🚀 Getting Started

1. **Fork the repository**
   - Click "Fork" button on GitHub
   - Clone your fork: `git clone https://github.com/YOUR-USERNAME/auragrids.git`

2. **Set up upstream**
   ```bash
   cd auragrids
   git remote add upstream https://github.com/ORIGINAL-OWNER/auragrids.git
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run -d chrome
   ```

## 🛠️ Development Setup

### Required Tools
- Flutter SDK 3.0.0+
- Dart 3.0.0+
- VS Code or Android Studio
- Git

### Recommended VS Code Extensions
- Flutter
- Dart
- GitLens
- Error Lens
- Better Comments

### Environment Setup

```bash
# Verify Flutter installation
flutter doctor -v

# Enable all platforms
flutter config --enable-web
flutter config --enable-android
flutter config --enable-ios
flutter config --enable-macos
flutter config --enable-windows
flutter config --enable-linux

# Check for issues
flutter doctor
```

## 📝 Code Style

### Dart Code Style

Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

```dart
// Good
class MyWidget extends StatelessWidget {
  final String title;
  
  const MyWidget({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

// Use meaningful variable names
final int driverNumber = calculateDriver();

// Use const where possible
const SizedBox(height: 20);
```

### File Organization

```dart
// 1. Imports (organized)
import 'package:flutter/material.dart';  // Flutter imports
import 'package:auragrids/models/data.dart';  // Package imports
import '../calculator.dart';  // Relative imports

// 2. Class definition
class MyClass {
  // 3. Fields
  final String field1;
  
  // 4. Constructor
  const MyClass({required this.field1});
  
  // 5. Methods
  void myMethod() {}
}
```

### Naming Conventions

- **Classes:** `PascalCase` (e.g., `HomeScreen`, `LuckyCompass`)
- **Files:** `snake_case` (e.g., `home_screen.dart`, `lucky_compass.dart`)
- **Variables:** `camelCase` (e.g., `driverNumber`, `isZenTheme`)
- **Constants:** `camelCase` (e.g., `defaultPadding`)
- **Enums:** `PascalCase` for type, `camelCase` for values (e.g., `Gender.male`)

### Widget Structure

```dart
// Prefer StatelessWidget when possible
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Extract complex widgets
Widget _buildComplexSection() {
  return Column(
    children: [
      _buildHeader(),
      _buildContent(),
      _buildFooter(),
    ],
  );
}
```

### Code Formatting

```bash
# Format all Dart files
dart format .

# Format specific file
dart format lib/main.dart

# Check formatting (CI/CD)
dart format --set-exit-if-changed .
```

## 🔄 Making Changes

### Branch Naming

```bash
# Feature
git checkout -b feature/add-new-calculator

# Bug fix
git checkout -b fix/grid-display-issue

# Enhancement
git checkout -b enhance/improve-ui

# Documentation
git checkout -b docs/update-readme
```

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Format: <type>(<scope>): <subject>

# Examples:
git commit -m "feat(calculator): add vedic numerology support"
git commit -m "fix(grid): correct number placement in Lo Shu grid"
git commit -m "docs(readme): add installation instructions"
git commit -m "style(theme): update color scheme"
git commit -m "refactor(widgets): extract common card widget"
git commit -m "test(calculator): add unit tests for driver number"
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

## 🧪 Testing

### Run Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/calculator_test.dart

# With coverage
flutter test --coverage

# Watch mode (re-run on changes)
flutter test --watch
```

### Writing Tests

```dart
// test/calculator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:auragrids/calculator.dart';

void main() {
  group('AuraCalculator', () {
    test('getDriverNumber calculates correctly', () {
      expect(AuraCalculator.getDriverNumber(15), equals(6));
      expect(AuraCalculator.getDriverNumber(28), equals(1));
    });
    
    test('calculateLoShu returns valid grid', () {
      final grid = AuraCalculator.calculateLoShu(5, 6, 1992);
      expect(grid, isNotEmpty);
      expect(grid.containsKey(5), isTrue);
    });
  });
}
```

### Widget Tests

```dart
testWidgets('LuckyCompassCard displays correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: LuckyCompassCard(driver: 1),
      ),
    ),
  );
  
  expect(find.text('Your Lucky Compass'), findsOneWidget);
  expect(find.byIcon(Icons.palette), findsOneWidget);
});
```

## 📤 Submitting Changes

### Before Submitting

```bash
# 1. Update from upstream
git fetch upstream
git rebase upstream/main

# 2. Run tests
flutter test

# 3. Check for errors
flutter analyze

# 4. Format code
dart format .

# 5. Build to verify
flutter build web --release
```

### Pull Request Process

1. **Create PR** with clear title and description
2. **Link related issues** using `Closes #123`
3. **Add screenshots** for UI changes
4. **Update documentation** if needed
5. **Wait for review** and address feedback

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added
- [ ] Manual testing done

## Screenshots
(if applicable)

## Checklist
- [ ] Code follows project style
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings
```

## ✨ Adding New Features

### Feature Development Workflow

1. **Discuss First**
   - Open an issue to discuss the feature
   - Get feedback before coding

2. **Create Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Implement Feature**
   - Follow code style
   - Add tests
   - Update documentation

4. **Test Thoroughly**
   - Unit tests
   - Widget tests
   - Manual testing on multiple platforms

5. **Submit PR**
   - Clear description
   - Screenshots/videos
   - Breaking changes noted

### Example: Adding a New Calculator

```dart
// 1. Add to calculator.dart
class AuraCalculator {
  static int calculateNewNumber(int value) {
    // Implementation
    return result;
  }
}

// 2. Add to localization
'new_number': 'New Number',
'new_number_kn': 'ಹೊಸ ಸಂಖ್ಯೆ',

// 3. Update UI
Text(l10n.translate('new_number'))

// 4. Add tests
test('calculateNewNumber works', () {
  expect(AuraCalculator.calculateNewNumber(5), equals(10));
});
```

## 🌐 Adding New Languages

### Steps to Add a Language

1. **Edit `app_localizations.dart`**

```dart
static final Map<String, Map<String, String>> _localizedValues = {
  'en': { /* existing */ },
  'kn': { /* existing */ },
  'hi': {  // New language: Hindi
    'app_title': 'औरा ग्रिड्स',
    'discover_destiny': 'अपने भाग्य की खोज करें',
    // ... add all translations
  },
};
```

2. **Update `isSupported` method**

```dart
@override
bool isSupported(Locale locale) {
  return ['en', 'kn', 'hi'].contains(locale.languageCode);
}
```

3. **Update `main.dart`**

```dart
supportedLocales: const [
  Locale('en', ''),
  Locale('kn', ''),
  Locale('hi', ''),  // Add new locale
],
```

4. **Add to language switcher**

```dart
PopupMenuItem(
  value: 'hi',
  child: Row(
    children: [
      Text(currentLocale.languageCode == 'hi' ? '✓ ' : '  '),
      const Text('हिन्दी (Hindi)'),
    ],
  ),
),
```

5. **Test thoroughly**
   - Switch to new language
   - Verify all screens
   - Check text wrapping
   - Test on multiple devices

## 🐛 Reporting Bugs

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g. macOS 12.0]
- Flutter version: [e.g. 3.10.0]
- Platform: [e.g. Web, Android]
- Device: [e.g. iPhone 12, Chrome]

**Additional context**
Any other information about the problem.
```

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)

## 🎯 Good First Issues

Look for issues labeled:
- `good-first-issue`
- `help-wanted`
- `documentation`
- `beginner-friendly`

## ❓ Questions?

- Open a GitHub Discussion
- Comment on related issues
- Reach out to maintainers

---

Thank you for contributing to AuraGrids! 🌟
