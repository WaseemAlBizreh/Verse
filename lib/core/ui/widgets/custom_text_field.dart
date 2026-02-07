import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.title,
    required this.hint,
    this.icon,
    required this.textEditingController,
    required this.textInputType,
    this.suffixIcon = const SizedBox(),
    this.obscureText = false,
    this.onTap,
    this.validator,
    required this.fillColor,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.minHeight,
    this.fontColor,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.titleColor,
    this.contentPadding,
    this.requiredField,
    this.prefixConstraints = const BoxConstraints(minWidth: 0, minHeight: 0),
    this.inputFormatters,
    this.fieldKey,
    this.textDirection,
  });

  final GlobalKey<FormFieldState>? fieldKey;
  final String? title;
  final String hint;
  final Widget? icon;
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final Widget suffixIcon;
  final TextDirection? textDirection;
  final bool obscureText;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color fillColor;
  final Color? fontColor;
  final Color? titleColor;
  final FontWeight fontWeight;
  final AutovalidateMode? autoValidateMode;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final bool? requiredField;
  final TextInputAction? textInputAction;
  final double? minHeight;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final BoxConstraints? prefixConstraints;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: title == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        title != null
            ? RichText(
                text: TextSpan(
                  text: title!,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: titleColor),
                  children: requiredField == true
                      ? [
                          TextSpan(
                            text: ' *',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ]
                      : [],
                ),
              )
            : const SizedBox.shrink(),
        title != null ? const SizedBox(height: 8.0) : const SizedBox.shrink(),
        Container(
          alignment: title == null ? Alignment.center : null,
          constraints: BoxConstraints(minHeight: minHeight ?? AppSize.s50),
          child: TextFormField(
            key: fieldKey,
            focusNode: focusNode,
            onTap: onTap,
            readOnly: readOnly,
            validator: validator,
            onChanged: onChanged,
            textInputAction: textInputAction,
            autovalidateMode: autoValidateMode,
            obscureText: obscureText,
            controller: textEditingController,
            minLines: minLines,
            maxLines: maxLines,
            keyboardType: maxLines > 1
                ? TextInputType.multiline
                : textInputType,
            style: TextStyle(
              fontSize: FontSize.s16,
              fontWeight: fontWeight,
              color: fontColor,
            ),
            textAlign: textAlign,
            textDirection: textDirection,
            inputFormatters: inputFormatters,
            cursorHeight: 20,
            cursorColor: ColorManager.colorPrimary,
            decoration: InputDecoration(
              counterText: '',
              constraints: BoxConstraints(minHeight: minHeight ?? AppSize.s50),
              hintText: hint,
              hintTextDirection: textDirection,
              isDense: true,
              prefixIconConstraints: prefixConstraints,
              prefixIcon: icon == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSize.s10),
                      child: icon,
                    ),
              contentPadding: contentPadding,
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s10),
                child: suffixIcon,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              filled: true,
              fillColor: fillColor,
              errorMaxLines: 2,
            ),
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
