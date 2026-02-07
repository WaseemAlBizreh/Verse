import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'localization_manager.dart';

abstract class MainThemeApp {
  late ThemeData themeData;
}

class LightModeTheme implements MainThemeApp {
  LightModeTheme(this._context);

  final BuildContext _context;

  @override
  late ThemeData themeData = ThemeData(
    dividerColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.colorPrimary),
    primaryColor: ColorManager.colorPrimary,
    canvasColor: ColorManager.colorWhite,
    scaffoldBackgroundColor: ColorManager.colorBackground,
    disabledColor: ColorManager.colorGrey1,
    splashColor: ColorManager.colorWhite,
    popupMenuTheme: const PopupMenuThemeData(
      surfaceTintColor: ColorManager.colorWhite,
      shadowColor: Colors.black,
      color: ColorManager.colorBackground,
    ),
    iconTheme: const IconThemeData(color: ColorManager.colorPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.grey,
        backgroundColor: ColorManager.colorPrimary,
        shadowColor: Colors.transparent,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        fixedSize: WidgetStatePropertyAll(Size(200, double.infinity)),
      ),
      textStyle: TextStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeight.w500,
        color: ColorManager.colorFontPrimary,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
    ),
    primaryColorLight: ColorManager.colorFontPrimary,
    primaryColorDark: ColorManager.colorFontSecondary,
    hintColor: ColorManager.colorFontSecondary,
    fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: FontSize.s30,
        fontWeight: FontWeight.bold,
        color: ColorManager.colorFontPrimary,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      headlineMedium: TextStyle(
        fontSize: FontSize.s24,
        color: ColorManager.colorFontPrimary,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      labelLarge: TextStyle(
        fontSize: FontSize.s18,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      titleLarge: TextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w600,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      titleMedium: TextStyle(
        fontSize: FontSize.s14,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w500,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      titleSmall: TextStyle(
        fontSize: FontSize.s12,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w500,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      bodyLarge: TextStyle(
        fontSize: FontSize.s18,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w600,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      bodyMedium: TextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w500,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      bodySmall: TextStyle(
        fontSize: FontSize.s14,
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w400,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
    ),
    dividerTheme: DividerThemeData(color: ColorManager.colorGrey1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.colorWhite,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.colorPrimary,
      unselectedItemColor: ColorManager.colorGrey2,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: FontSize.s12,
        color: ColorManager.colorPrimary,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s12,
        color: ColorManager.colorGrey2,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: ColorManager.colorPrimary,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: ColorManager.colorPrimary,
        // size: AppSize.s20,
      ),
      titleTextStyle: TextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeight.w600,
        color: ColorManager.colorWhite,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: ColorManager.colorBackground),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: ColorManager.colorBackground,
      elevation: 1,
      weekdayStyle: TextStyle(
        color: ColorManager.colorPrimary,
        fontWeight: FontWeight.bold,
        // fontSize: FontSize.s16,
      ),
      dayStyle: TextStyle(
        color: ColorManager.colorFontPrimary,
        fontWeight: FontWeight.w600,
        fontSize: FontSize.s13,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      hourMinuteColor: ColorManager.colorPrimary,
      cancelButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w600,
            fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
          ),
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w600,
            fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.colorWhite,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      hintStyle: TextStyle(
        color: ColorManager.colorFontSecondary,
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s14,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      errorStyle: TextStyle(
        color: ColorManager.colorError,
        fontWeight: FontWeight.w400,
        fontSize: FontSize.s13,
        fontFamily: FontManager.getFontFamily(_context.locale.languageCode),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldFocusedBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldFocusedBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldEnabledBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      // focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldFocusedBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldErrorBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.colorTextFieldErrorBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}

class AppStyles {
  static BoxDecoration defaultCirclePin = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: ColorManager.colorGrey1),
    color: ColorManager.colorGrey1,
  );

  static TextStyle errorTextStyle = TextStyle(
    color: ColorManager.colorError,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.s13,
    fontFamily: FontManager.getFontFamily(LocalizationManager.currentLanguage),
  );
}
