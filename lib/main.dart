import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() => runApp(const AuraGridsApp());

class AuraGridsApp extends StatefulWidget {
  const AuraGridsApp({super.key});

  @override
  State<AuraGridsApp> createState() => _AuraGridsAppState();
}

class _AuraGridsAppState extends State<AuraGridsApp> {
  bool isZenTheme = true;
  Locale _locale = const Locale('en');

  void _toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'en' 
          ? const Locale('kn') 
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuraGrids - Numerology Calculator',
      theme: isZenTheme ? AppTheme.zenTheme() : AppTheme.minimalistTheme(),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('kn', ''), // Kannada
      ],
      home: HomeScreen(
        onToggleTheme: () => setState(() => isZenTheme = !isZenTheme),
        onToggleLanguage: _toggleLanguage,
        currentLocale: _locale,
      ),
    );
  }
}
