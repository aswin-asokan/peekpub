import 'package:flutter/material.dart';
import 'package:trelza_pubseek/main.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { english, spanish }

extension AppLanguageExtension on AppLanguage {
  String get label {
    switch (this) {
      case AppLanguage.english:
        return "English";
      case AppLanguage.spanish:
        return "Español";
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.spanish:
        return const Locale('es');
    }
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
      _selected = langCode == 'es' ? AppLanguage.spanish : AppLanguage.english;
    });
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
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.loc.chooseLang, style: context.textTheme.titleSmall),
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
                          setState(() {
                            _selected = value;
                          });
                          MyApp.setLocale(context, value.locale);
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
