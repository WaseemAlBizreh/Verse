import 'package:easy_localization/easy_localization.dart';

class ValidationUtils {
  static String? validatePhone(String? phone, {String? customMessage}) {
    if (phone == null || phone.isEmpty) {
      return 'validation_phone_required'.tr();
    }

    // Remove any spaces or special characters, keep only digits
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    if (cleanPhone.length < ValidationConstants.minPhoneLength) {
      return 'validation_phone_min_length'.tr(
        namedArgs: {'minLength': ValidationConstants.minPhoneLength.toString()},
      );
    }

    if (cleanPhone.length > ValidationConstants.maxPhoneLength) {
      return 'validation_phone_max_length'.tr(
        namedArgs: {'maxLength': ValidationConstants.maxPhoneLength.toString()},
      );
    }

    return null;
  }

  static String? validateInternationalPhone(
    String? phone, {
    String? customMessage,
  }) {
    if (phone == null || phone.isEmpty) {
      return 'validation_phone_required'.tr();
    }

    // Remove any spaces or special characters, keep only digits
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    // International phone numbers typically range from 7 to 15 digits
    const int minInternationalPhoneLength = 7;
    const int maxInternationalPhoneLength = 15;

    if (cleanPhone.length < minInternationalPhoneLength) {
      return 'validation_phone_min_length'.tr(
        namedArgs: {'minLength': minInternationalPhoneLength.toString()},
      );
    }

    if (cleanPhone.length > maxInternationalPhoneLength) {
      return 'validation_phone_max_length'.tr(
        namedArgs: {'maxLength': maxInternationalPhoneLength.toString()},
      );
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'validation_password_required'.tr();
    }

    if (password.length < ValidationConstants.minPasswordLength) {
      return 'validation_password_min_length'.tr(
        namedArgs: {
          'minLength': ValidationConstants.minPasswordLength.toString(),
        },
      );
    }

    if (password.length > ValidationConstants.maxPasswordLength) {
      return 'validation_password_max_length'.tr(
        namedArgs: {
          'maxLength': ValidationConstants.maxPasswordLength.toString(),
        },
      );
    }

    // // 1. Check for uppercase letter
    // if (!ValidationConstants.passwordUpperCase.hasMatch(password)) {
    //   return 'validation_password_uppercase'.tr();
    // }
    //
    // // 2. Check for lowercase letter
    // if (!ValidationConstants.passwordLowerCase.hasMatch(password)) {
    //   return 'validation_password_lowercase'.tr();
    // }

    // Check for digit
    if (!ValidationConstants.passwordDigit.hasMatch(password)) {
      return 'validation_password_digit'.tr();
    }

    // // Check for special character
    // if (!ValidationConstants.passwordSpecialChar.hasMatch(password)) {
    //   return 'validation_password_special'.tr();
    // }

    return null;
  }

  static String? validatePasswordConfirmation(
    String? password,
    String? confirmationPassword,
  ) {
    if (confirmationPassword == null || confirmationPassword.isEmpty) {
      return 'validation_password_confirm_required'.tr();
    }

    if (password != confirmationPassword) {
      return 'validation_password_confirm_match'.tr();
    }

    return null;
  }

  static String? validateName(String? name, {int? minNameLength}) {
    final min = minNameLength ?? ValidationConstants.minNameLength;
    if (name == null || name.isEmpty) {
      return 'validation_name_required'.tr();
    }

    final trimmedName = name.trim();

    if (trimmedName.length < min) {
      return 'validation_name_min_length'.tr(
        namedArgs: {'minLength': min.toString()},
      );
    }

    if (trimmedName.length > ValidationConstants.maxNameLength) {
      return 'validation_name_max_length'.tr(
        namedArgs: {'maxLength': ValidationConstants.maxNameLength.toString()},
      );
    }

    // Check for valid characters (letters, spaces, and common accented characters)
    if (!ValidationConstants.nameRegex.hasMatch(trimmedName)) {
      return 'validation_name_characters'.tr();
    }

    // Check for consecutive spaces
    if (trimmedName.contains('  ')) {
      return 'validation_name_consecutive_spaces'.tr();
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'validation_email_required'.tr();
    }

    if (!ValidationConstants.emailRegex.hasMatch(email)) {
      return 'validation_email_invalid'.tr();
    }

    return null;
  }

  static String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'validation_otp_required'.tr();
    }

    if (otp.length != ValidationConstants.otpLength) {
      return 'validation_otp_length'.tr(
        namedArgs: {'length': ValidationConstants.otpLength.toString()},
      );
    }

    return null;
  }

  static String? validateDateOfBirth(DateTime? dateOfBirth) {
    if (dateOfBirth == null) {
      return 'validation_date_of_birth_required'.tr();
    }

    final now = DateTime.now();
    final age = now.year - dateOfBirth.year;
    final monthDifference = now.month - dateOfBirth.month;
    final dayDifference = now.day - dateOfBirth.day;

    // Calculate exact age considering month and day
    int exactAge = age;
    if (monthDifference < 0 || (monthDifference == 0 && dayDifference < 0)) {
      exactAge--;
    }

    if (exactAge < 15) {
      return 'validation_date_of_birth_min_age'.tr();
    }

    return null;
  }

  static String? validateEmpty<T>(
    T? value, {
    required String errorMessage,
    int? minLength,
    String? minLengthErrorMessage,
  }) {
    if (value == null) {
      return errorMessage.tr();
    }
    if (value is String) {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) {
        return errorMessage.tr();
      }
      if (minLength != null && trimmedValue.length < minLength) {
        return minLengthErrorMessage?.tr(
              namedArgs: {'minLength': minLength.toString()},
            ) ??
            errorMessage.tr();
      }
    }
    return null;
  }

  static String? validateLength(
    String? value, {
    required int exactLength,
    required String emptyErrorMessage,
    required String lengthErrorMessage,
    bool removeNonDigits = false,
  }) {
    if (value == null || value.isEmpty) {
      return emptyErrorMessage.tr();
    }

    String cleanValue = value.trim();

    if (removeNonDigits) {
      cleanValue = cleanValue.replaceAll(RegExp(r'\D'), '');
    }

    if (cleanValue.isEmpty) {
      return emptyErrorMessage.tr();
    }

    if (cleanValue.length != exactLength) {
      return lengthErrorMessage.tr();
    }

    return null;
  }

  static String? validateAmount(
    String? value, {
    required String emptyErrorMessage,
    required String zeroErrorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyErrorMessage.tr();
    }

    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return emptyErrorMessage.tr();
    }

    // Try to parse as double
    final amount = double.tryParse(trimmedValue);
    if (amount == null) {
      return emptyErrorMessage.tr();
    }

    // Check if amount is zero or negative
    if (amount <= 0) {
      return zeroErrorMessage.tr();
    }

    return null;
  }
}

class ValidationConstants {
  // Password validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;

  // OTP validation
  static const int otpLength = 4;

  // Phone number validation
  static const int minPhoneLength = 7;
  static const int maxPhoneLength = 15;

  // Regular expressions for validation
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp nameRegex = RegExp(
    r'^[a-zA-ZÀ-ÿ\u00C0-\u017F\u0100-\u024F\u1E00-\u1EFF\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF\s]+$',
  );

  // Password strength requirements
  static final RegExp passwordUpperCase = RegExp(r'[A-Z]');
  static final RegExp passwordLowerCase = RegExp(r'[a-z]');
  static final RegExp passwordDigit = RegExp(r'[\d\u0660-\u0669]');
  static final RegExp passwordSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  // Name validation
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  static final RegExp doubleRegExp = RegExp(r'[0-9.]');
  static final RegExp intRegExp = RegExp(r'[0-9]');
}
