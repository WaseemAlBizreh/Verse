import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class AppDropdownButton<T> extends StatefulWidget {
  const AppDropdownButton({
    super.key,
    required this.value,
    required this.options,
    required this.itemBuilder,
    required this.onChanged,
    this.width,
    this.maxHeight,
    this.padding,
    this.backgroundColor = ColorManager.colorWhite,
    this.borderRadius = 20,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 12,
        spreadRadius: 3,
        offset: Offset(0, 3),
      ),
    ],
    this.icon,
    this.dropdownColor,
    this.textStyle,
  });

  @override
  State<AppDropdownButton<T>> createState() => _AppDropdownButtonState<T>();

  final T? value;
  final List<T> options;
  final DropDownItem<T> Function(T value) itemBuilder;
  final void Function(T?) onChanged;
  final double? width;
  final double? maxHeight;
  final EdgeInsets? padding;
  final Color backgroundColor;
  final double borderRadius;
  final List<BoxShadow> boxShadow;
  final Widget? icon;
  final Color? dropdownColor;
  final TextStyle? textStyle;
}

class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey();

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_isOpen) return;

    final overlay = Overlay.of(context);
    final RenderBox? renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildOverlayMenu(offset, size),
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    if (!_isOpen) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _selectItem(T value) {
    widget.onChanged(value);
    _closeDropdown();
  }

  DropDownItem<T>? _getSelectedEntry() {
    if (widget.value == null) return null;
    for (final option in widget.options) {
      final entry = widget.itemBuilder(option);
      if (entry.value == widget.value) {
        return entry;
      }
    }
    return null;
  }

  Widget _buildButton() {
    final actualPadding =
        widget.padding ??
        EdgeInsets.symmetric(horizontal: AppSize.s16, vertical: AppSize.s12);
    final selectedEntry = _getSelectedEntry();

    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        key: _buttonKey,
        width: widget.width,
        constraints: BoxConstraints(maxHeight: widget.maxHeight ?? AppSize.s45),
        padding: actualPadding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: widget.boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedEntry?.label ?? '',
                style: widget.textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.icon != null)
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: widget.icon!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayMenu(Offset buttonOffset, Size buttonSize) {
    final buttonWidth = widget.width ?? buttonSize.width;
    final menuColor = widget.dropdownColor ?? ColorManager.colorWhite;
    final maxMenuHeight = AppSize.sHeight * 0.25;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: _closeDropdown,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Menu positioned below button
        Positioned(
          left: buttonOffset.dx,
          top: buttonOffset.dy + buttonSize.height + AppSize.s4,
          width: buttonWidth,
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.95 + (value * 0.05),
                    alignment: Alignment.topCenter,
                    child: child,
                  ),
                );
              },
              child: Container(
                constraints: BoxConstraints(maxHeight: maxMenuHeight * 0.75),
                decoration: BoxDecoration(
                  color: menuColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.options.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 1,
                      color: ColorManager.colorGrey1,
                    ),
                    itemBuilder: (context, index) {
                      final option = widget.options[index];
                      final entry = widget.itemBuilder(option);
                      final isSelected = entry.value == widget.value;

                      return InkWell(
                        onTap: () => _selectItem(entry.value),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.s16,
                            vertical: AppSize.s12,
                          ),
                          color: isSelected
                              ? Colors.black12.withValues(alpha: 0.1)
                              : Colors.transparent,
                          child: Row(
                            children: [
                              if (entry.leadingIcon != null) ...[
                                entry.leadingIcon!,
                                SizedBox(width: AppSize.s12),
                              ],
                              Expanded(
                                child: Text(
                                  entry.label,
                                  style:
                                      widget.textStyle ??
                                      context.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.colorFontPrimary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }
}

class DropDownItem<T> {
  final T value;
  final String label;
  final Widget? leadingIcon;

  DropDownItem({required this.value, required this.label, this.leadingIcon});
}
