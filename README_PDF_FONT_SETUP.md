PDF font setup

To support Unicode text (Kannada and other scripts) in PDF exports, add a Unicode TTF font to the project.

1. Download Noto Sans Regular (or Noto Sans Kannada) from Google Fonts.
2. Place the TTF at: `assets/fonts/NotoSans-Regular.ttf` (create the folders if needed).
3. The `pubspec.yaml` already references this font. Run:

```bash
flutter pub get
```

4. The PDF generator in `home_screen.dart` will try to load this font from the asset and use it when generating text.

If you want, I can download and add the TTF file for you (I cannot fetch external networks without your permission). If you drop the TTF into `assets/fonts/` I will update the code to use it explicitly in the PDF theme.
