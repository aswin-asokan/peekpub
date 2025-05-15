import 'package:flutter/material.dart';
import 'package:trelza_peekpub/main.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, spanish, hindi, malayalam }

extension AppLanguageExtension on AppLanguage {
  String get label {
    switch (this) {
      case AppLanguage.english:
        return "English";
      case AppLanguage.spanish:
        return "Español";
      case AppLanguage.hindi:
        return "Hindi";
      case AppLanguage.malayalam:
        return "Malayalam";
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.spanish:
        return const Locale('es');
      case AppLanguage.hindi:
        return const Locale('hi');
      case AppLanguage.malayalam:
        return const Locale('ml');
    }
  }

  static AppLanguage fromCode(String code) {
    switch (code) {
      case 'es':
        return AppLanguage.spanish;
      case 'hi':
        return AppLanguage.hindi;
      case 'ml':
        return AppLanguage.malayalam;
      case 'en':
      default:
        return AppLanguage.english;
    }
  }

  String get code {
    return locale.languageCode;
  }
}

class LangPage extends StatefulWidget {
  const LangPage({super.key});

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  AppLanguage _selected = AppLanguage.english;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code') ?? 'en';
    setState(() {
      _selected = AppLanguageExtension.fromCode(langCode);
    });
  }

  Future<void> _updateLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', language.code);
    setState(() {
      _selected = language;
    });
    MyApp.setLocale(context, language.locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.language, style: context.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: context.colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.loc.chooseLang, style: context.textTheme.titleSmall),
            const SizedBox(height: 12),
            Column(
              children:
                  AppLanguage.values.map((lang) {
                    return RadioListTile<AppLanguage>(
                      title: Text(
                        lang.label,
                        style: context.textTheme.bodyMedium,
                      ),
                      value: lang,
                      fillColor: WidgetStatePropertyAll(
                        context.colorScheme.primary,
                      ),
                      groupValue: _selected,
                      onChanged: (AppLanguage? value) {
                        if (value != null) {
                          _updateLanguage(value);
                        }
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
