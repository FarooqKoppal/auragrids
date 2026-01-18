# Changelog

All notable changes to AuraGrids will be documented in this file.

## [1.1.0] - 2026-01-17

### Added
- **Dynamic Year Calculation**: Personal Year now automatically uses the current year instead of hardcoded 2026
- **Enhanced Planes Display**: Strengths & Planes section now shows the specific numbers that form each plane
  - Visual indicators for plane types (horizontal, vertical, diagonal)
  - Color-coded numbers for better readability
  - Type-specific icons:
    - 🔵 Blue (horizontal planes)
    - 🟢 Green (vertical planes)
    - 🟡 Amber (diagonal planes - Golden/Silver Yog)

### Changed
- Removed hardcoded year (2026) from localization strings
- Enhanced planes visualization with individual number badges
- Improved plane card UI with type-based styling

### Technical Details
- Added `getCompletedPlanesWithNumbers()` method to calculator.dart
- Created custom `_buildPlanesCard()` widget in home_screen.dart
- Maintained backward compatibility with existing `getCompletedPlanes()` method

## [1.0.0] - 2026-01-15

### Initial Release
- Lo Shu Grid visualization with 3×3 grid
- Numerology calculations:
  - Driver Number (Psychic Number)
  - Conductor Number (Destiny Number)
  - Kua Number (Feng Shui Success Number)
  - Name Number (Chaldean Numerology)
  - Personal Year calculation
- Lucky Compass with actual color visualization
- Strengths & Planes detection
- Personalized remedies for missing numbers
- Multi-language support (English & Kannada)
- Dual themes (Zen & Minimalist)
- Responsive design for web, Android, iOS, and desktop
- GitHub Actions for automated APK builds
- Comprehensive documentation

---

## Version Format

Format: `[Major.Minor.Patch]`
- **Major**: Breaking changes
- **Minor**: New features (backward compatible)
- **Patch**: Bug fixes

## Categories

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security improvements
