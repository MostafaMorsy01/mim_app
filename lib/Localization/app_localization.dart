import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constants/app_constants.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedValues = {};
  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString("assets/languages/${locale.languageCode}.json");
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    return _localizedValues[key] ?? "";
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

String getTranslated(BuildContext context, String titleKey) {
  String? word = AppLocalizations.of(context)?.getTranslatedValue(titleKey);
  if (word != null && word != "null") {
    return word;
  } else {
    return titleKey;
  }
}

Alignment setAlignmnetToCenterStart(BuildContext context) {
  if (AppConstants.locale == "en") {
    return Alignment.centerLeft;
  } else {
    return Alignment.centerRight;
  }
}

Alignment setAlignmnetToCenterEnd(BuildContext context) {
  if (AppConstants.locale == "ar") {
    return Alignment.centerLeft;
  } else {
    return Alignment.centerRight;
  }
}
