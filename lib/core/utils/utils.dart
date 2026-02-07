import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../ui/extensions/context_extensions.dart';
import '../ui/resources/color_manager.dart';
import '../ui/resources/values_manager.dart';
import 'validation_utils.dart';

class Utils {
  // Arabic Checker
  static bool isArabicText(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
    return arabicRegex.hasMatch(text);
  }

  static bool intToBool(int value) {
    return value == 1 ? true : false;
  }

  static num stringToNum(String value) {
    return num.tryParse(value.isNotEmpty ? value : '0') ?? 0;
  }

  static int boolToInt(bool value) {
    return value ? 1 : 0;
  }

  static bool isValidPositiveNonZeroNumber(String input) {
    final regex = RegExp(r'^(?:[1-9]\d*|[1-9]\d*\.\d+|0\.[1-9]\d*)$');
    return regex.hasMatch(input);
  }

  static bool? intToBoolOrNull(int? value) {
    if (value == null) return null;
    return value == 1 ? true : false;
  }

  static int? boolToIntOrNull(bool? value) {
    if (value == null) return null;
    return value ? 1 : 0;
  }

  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // add alpha if not provided
    }
    return Color(int.parse(hex, radix: 16));
  }

  // Date Picker
  static Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? initialDate,
    DateTime? maximumDate,
  }) async {
    DateTime currentDateTime = initialDate ?? DateTime.now();
    final screenHeight = AppSize.sHeight;
    final screenWidth = AppSize.sWidth;
    final result = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        final dialogHeight = screenHeight * 0.4;
        final headerHeight = AppSize.s50;
        final borderWidth = AppSize.s1 * 0.5;

        return Container(
          height: dialogHeight,
          width: screenWidth,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                height: headerHeight,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.separator.resolveFrom(context),
                      width: borderWidth,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s16,
                        vertical: AppSize.s8,
                      ),
                      child: Text(
                        'cancel'.tr(),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: ColorManager.colorFontPrimary,
                        ),
                      ),
                      onPressed: () => context.pop(),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s16,
                        vertical: AppSize.s8,
                      ),
                      child: Text(
                        'done'.tr(),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: ColorManager.colorFontPrimary,
                        ),
                      ),
                      onPressed: () => context.pop(currentDateTime),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: currentDateTime,
                  minimumDate: firstDate ?? DateTime(1900, 8),
                  maximumDate: maximumDate ?? DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    currentDateTime = newDateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    return result;
  }


  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    try {
      // check valid email
      if (isValidEmail(url)) return true;
      final uri = Uri.parse(url);
      return uri.hasScheme || (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  static bool isValidEmail(String email) =>
      ValidationConstants.emailRegex.hasMatch(email);

  static Color hexStringToColor(String hex) {
    String normalized = hex.trim();
    if (normalized.startsWith('#')) {
      normalized = normalized.substring(1);
    }
    if (normalized.length == 6) {
      normalized = 'FF$normalized';
    }
    final value = int.parse(normalized, radix: 16);
    return Color(value);
  }
}



