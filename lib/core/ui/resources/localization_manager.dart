import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../config/injection.dart';
import '../../services/cache_service.dart';

abstract class LocalizationManager {
  static const String translationsPath = 'assets/translations';
  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];
  static const Locale fallbackLocale = Locale('en');

  static String get currentLanguage =>
      (MyApp.appContext?.locale.languageCode) ?? 'en';

  static bool get isArabic => currentLanguage == 'ar';

  static bool get isEnglish => currentLanguage == 'en';

  static Future<void> changeLanguage(String language) async {
    final context = MyApp.appContext;
    if (context != null && supportedLocales.contains(Locale(language))) {
      locator<CacheService>().saveLanguage(language);
      await context.setLocale(Locale(language));
    }
  }

  static Future<void> toggleLanguage() async {
    final context = MyApp.appContext;
    if (context != null) {
      final currentLang = context.locale.languageCode;
      final newLocale = currentLang == 'en' ? 'ar' : 'en';
      await changeLanguage(newLocale);
    }
  }
}
