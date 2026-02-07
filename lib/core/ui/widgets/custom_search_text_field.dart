import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.onChanged,
    this.suffixIcon,
    this.fillColor,
    this.minHeight = 55,
  });

  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorManager.colorBlack.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        cursorHeight: 20,
        cursorColor: ColorManager.colorPrimary,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          constraints: BoxConstraints(minHeight: minHeight),
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: UnconstrainedBox(
            child: SvgPicture.asset(
              IconsAssets.searchIcon,
              width: 24,
              height: 24,
            ),
          ),
          contentPadding: const EdgeInsets.all(0),
          filled: true,
          fillColor: fillColor ?? ColorManager.colorBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.colorTextFieldFocusedBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.colorTextFieldFocusedBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.colorTextFieldFocusedBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.colorTextFieldFocusedBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onTapOutside: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
