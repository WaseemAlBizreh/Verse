import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/injection.dart';
import 'core/services/cache_service.dart';
import 'core/services/network_service/internet_utils.dart';
import 'core/ui/resources/localization_manager.dart';
import 'core/ui/resources/theme_manager.dart';
import 'core/ui/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await InternetUtils.init();
  configureDependencies();
  final currentLanguage = await locator<CacheService>().getLanguage();
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationManager.supportedLocales,
      path: LocalizationManager.translationsPath,
      fallbackLocale: LocalizationManager.fallbackLocale,
      startLocale: Locale(currentLanguage),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static BuildContext? get appContext => navigationKey.currentContext;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: locator<AppRouter>().config(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: LightModeTheme(context).themeData,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
