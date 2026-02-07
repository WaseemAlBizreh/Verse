import 'package:flutter/services.dart';

import 'validation_utils.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  final Function(String) onChanged;
  final String? protectedPrefix;
  final int? maxLength;

  PhoneNumberFormatter({
    required this.onChanged,
    this.protectedPrefix,
    this.maxLength,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Extract only digits from old and new values
    String oldText = oldValue.text.replaceAll(RegExp(r'\D'), '');
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // If protected prefix is set, ensure it's always present
    if (protectedPrefix != null && protectedPrefix!.isNotEmpty) {
      // If user is trying to delete the protected prefix, prevent it
      if (oldText.startsWith(protectedPrefix!) &&
          newText.length < protectedPrefix!.length) {
        newText = protectedPrefix!;
      }

      // Ensure it always starts with the protected prefix
      if (!newText.startsWith(protectedPrefix!)) {
        if (newText.isEmpty) {
          newText = protectedPrefix!;
        } else if (newText.startsWith(
          protectedPrefix![protectedPrefix!.length - 1],
        )) {
          // If starts with last character of prefix (e.g., '9'), add the prefix
          newText = '$protectedPrefix${newText.substring(1)}';
        } else {
          // If doesn't start with prefix, prepend it
          newText = '$protectedPrefix$newText';
        }
      }

      // Prevent deletion below protected prefix length
      if (newText.length < protectedPrefix!.length) {
        newText = protectedPrefix!;
      }
    }

    // Limit the length
    final effectiveMaxLength = maxLength ?? ValidationConstants.maxPhoneLength;
    if (newText.length > effectiveMaxLength) {
      newText = newText.substring(0, effectiveMaxLength);
    }

    // Update the unformatted number
    onChanged(newText);

    // Apply the specific formatting
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 4 || i == 7 || i == 10) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    // Calculate cursor position
    int cursorOffset = newValue.selection.baseOffset;
    int formattedCursorPosition = formattedText.length;

    // If protected prefix is set, ensure cursor doesn't go before it
    if (protectedPrefix != null && protectedPrefix!.isNotEmpty) {
      // Extract digits from the new value before formatting to find cursor position
      String digitsBeforeCursor = newValue.text
          .substring(0, cursorOffset)
          .replaceAll(RegExp(r'\D'), '');

      // If cursor is trying to be before protected prefix, keep it after prefix
      if (digitsBeforeCursor.length < protectedPrefix!.length) {
        formattedCursorPosition = protectedPrefix!.length;
      } else {
        // Calculate position in formatted text
        int digitCount = 0;
        for (int i = 0; i < formattedText.length; i++) {
          if (formattedText[i] != ' ') {
            digitCount++;
            if (digitCount >= digitsBeforeCursor.length) {
              formattedCursorPosition = i + 1;
              break;
            }
          }
        }
      }
    } else {
      // Default behavior: keep cursor at end
      formattedCursorPosition = formattedText.length;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedCursorPosition),
    );
  }
}

class PhoneInternationalNumberFormatter extends TextInputFormatter {
  PhoneInternationalNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 15) {
      // Limit the length to 15 digits
      return oldValue;
    }

    // Apply the specific formatting
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 6 || i == 10) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

