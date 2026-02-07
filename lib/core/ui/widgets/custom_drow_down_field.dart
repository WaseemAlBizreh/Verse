import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomDropdownField<T> extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    this.controller,
    this.value,
    this.onChanged,
    this.boxShadow,
    this.icon,
    required this.fillColor,
    this.requiredField,
    this.titleColor,
    this.fontColor,
    this.minHeight = 50,
    this.borderRadius = 20,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.prefixConstraints = const BoxConstraints(minWidth: 0, minHeight: 0),
    this.validator,
    this.borderColor,
    this.fieldKey,
    // Pagination parameters
    this.itemsPerPage,
    this.onLoadMore,
    this.hasMore = false,
    // Search parameters
    this.onSearch,
    this.initialSearchQuery,
    // Dropdown item text style
    this.dropdownItemTextStyle,
  });

  final GlobalKey<FormFieldState>? fieldKey;
  final String? title;
  final String hint;
  final List<BoxShadow>? boxShadow;
  final List<DropdownMenuEntry<T>> items;
  final T? value;
  final TextEditingController? controller;
  final void Function(T?)? onChanged;
  final Widget? icon;
  final Color fillColor;
  final bool? requiredField;
  final Color? titleColor;
  final Color? borderColor;
  final Color? fontColor;
  final double minHeight;
  final double borderRadius;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final BoxConstraints? prefixConstraints;
  final String? Function(T?)? validator;

  // Pagination parameters
  final int? itemsPerPage;
  final VoidCallback? onLoadMore;
  final bool hasMore;

  // Search parameters
  final void Function(String query)? onSearch;
  final String? initialSearchQuery;

  // Dropdown item text style
  final TextStyle? dropdownItemTextStyle;

  @override
  State<CustomDropdownField<T>> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isPaginationEnabled = false;
  bool _isLoadingMore = false;
  int _previousItemsLength = 0;

  @override
  void initState() {
    super.initState();
    _isPaginationEnabled =
        widget.itemsPerPage != null && widget.onLoadMore != null;
    if (_isPaginationEnabled) {
      _scrollController.addListener(_onScroll);
    }
    _previousItemsLength = widget.items.length;
  }

  @override
  void didUpdateWidget(CustomDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final wasLoading = _isLoadingMore;
    if (_isLoadingMore) {
      if (widget.items.length > _previousItemsLength ||
          !_areItemsEqual(oldWidget.items, widget.items)) {
        _isLoadingMore = false;
      }
    }
    final loadingStateChanged = wasLoading != _isLoadingMore;
    _previousItemsLength = widget.items.length;

    if (_isDropdownOpen && _overlayEntry != null) {
      final itemsChanged =
          oldWidget.items.length != widget.items.length ||
          !_areItemsEqual(oldWidget.items, widget.items);
      final hasMoreChanged = oldWidget.hasMore != widget.hasMore;

      if (itemsChanged || hasMoreChanged || loadingStateChanged) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_isDropdownOpen && _overlayEntry != null) {
            _overlayEntry!.markNeedsBuild();
          }
        });
      }
    }
  }

  bool _areItemsEqual(
    List<DropdownMenuEntry<T>> list1,
    List<DropdownMenuEntry<T>> list2,
  ) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].value != list2[i].value ||
          list1[i].label != list2[i].label) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _closeDropdown();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0) return;
    final isAtBottom = (position.maxScrollExtent - position.pixels) <= 5;

    if (isAtBottom &&
        widget.hasMore &&
        !_isLoadingMore &&
        widget.onLoadMore != null) {
      _isLoadingMore = true;
      _previousItemsLength = widget.items.length;
      if (_overlayEntry != null && _isDropdownOpen) {
        _overlayEntry!.markNeedsBuild();
      }
      widget.onLoadMore!();
    }
  }

  void _toggleDropdown(FormFieldState<T> field) {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown(field);
    }
  }

  void _openDropdown(FormFieldState<T> field) {
    if (_isDropdownOpen) return;

    final overlay = Overlay.of(context);
    final RenderBox? renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return _PaginatedDropdownMenu<T>(
          items: widget.items,
          buttonSize: size,
          buttonOffset: offset,
          onSelected: (value) {
            field.didChange(value);
            widget.onChanged?.call(value);
          },
          selectedValue: widget.value,
          borderRadius: widget.borderRadius,
          itemsPerPage: widget.itemsPerPage,
          onLoadMore: () {
            if (!_isLoadingMore &&
                widget.hasMore &&
                widget.onLoadMore != null) {
              _isLoadingMore = true;
              _previousItemsLength = widget.items.length;
              // Trigger overlay rebuild immediately to show loading
              _overlayEntry?.markNeedsBuild();
              widget.onLoadMore!();
            }
          },
          hasMore: widget.hasMore,
          isLoadingMore: _isLoadingMore,
          scrollController: _scrollController,
          onClose: _closeDropdown,
          onSearch: widget.onSearch,
          initialSearchQuery: widget.initialSearchQuery,
          dropdownItemTextStyle: widget.dropdownItemTextStyle,
        );
      },
    );

    overlay.insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    if (!_isDropdownOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
      _isLoadingMore = false;
    });
  }

  String _getDisplayText() {
    if (widget.value == null || widget.items.isEmpty) return widget.hint;
    final selectedItem = widget.items.firstWhere(
      (item) => item.value == widget.value,
      orElse: () => widget.items.first,
    );
    return selectedItem.label;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: widget.fieldKey,
      initialValue: widget.value,
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              RichText(
                text: TextSpan(
                  text: widget.title!,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: widget.titleColor),
                  children: widget.requiredField == true
                      ? [
                          TextSpan(
                            text: ' *',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ]
                      : [],
                ),
              ),
            if (widget.title != null) const SizedBox(height: 8.0),
            LayoutBuilder(
              builder: (context, constraints) {
                if (_isPaginationEnabled) {
                  return Container(
                    key: _buttonKey,
                    alignment: widget.title == null ? Alignment.center : null,
                    constraints: BoxConstraints(
                      minHeight: field.hasError ? 0 : widget.minHeight,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: widget.boxShadow,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    child: InkWell(
                      onTap: () => _toggleDropdown(field),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Container(
                        padding:
                            widget.contentPadding ??
                            EdgeInsets.symmetric(
                              horizontal: AppSize.s14,
                              vertical: AppSize.s12,
                            ),
                        decoration: BoxDecoration(
                          color: widget.fillColor,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                          border: Border.all(
                            color: field.hasError
                                ? ColorManager.colorTextFieldErrorBorder
                                : widget.borderColor ??
                                      ColorManager.colorTextFieldFocusedBorder,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (widget.icon != null) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.s14,
                                ),
                                child: widget.icon!,
                              ),
                            ],
                            Expanded(
                              child: Text(
                                _getDisplayText(),
                                style: widget.value == null
                                    ? Theme.of(
                                        context,
                                      ).inputDecorationTheme.hintStyle
                                    : Theme.of(context).textTheme.titleMedium,
                                textAlign: widget.textAlign,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Transform.rotate(
                              angle: _isDropdownOpen ? pi : 0,
                              child: SvgPicture.asset(IconsAssets.arrowDown),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    alignment: widget.title == null ? Alignment.center : null,
                    constraints: BoxConstraints(
                      minHeight: field.hasError ? 0 : widget.minHeight,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: widget.boxShadow,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    child: DropdownMenu<T>(
                      key: ValueKey(widget.value),
                      width: constraints.maxWidth,
                      controller: widget.controller,
                      initialSelection: widget.value,
                      enableFilter: false,
                      requestFocusOnTap: false,
                      leadingIcon: widget.icon != null
                          ? Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: AppSize.s14,
                              ),
                              child: widget.icon!,
                            )
                          : null,
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: widget.fillColor,
                        isDense: true,
                        contentPadding: widget.contentPadding,
                        prefixIconConstraints: widget.prefixConstraints,
                        border: Theme.of(context).inputDecorationTheme.border!
                            .copyWith(
                              borderSide: BorderSide(
                                color: field.hasError
                                    ? ColorManager.colorTextFieldErrorBorder
                                    : widget.borderColor ??
                                          ColorManager
                                              .colorTextFieldFocusedBorder,
                                width: 2,
                              ),
                            ),
                        enabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder!
                            .copyWith(
                              borderSide: BorderSide(
                                color: field.hasError
                                    ? ColorManager.colorTextFieldErrorBorder
                                    : widget.borderColor ??
                                          ColorManager
                                              .colorTextFieldFocusedBorder,
                                width: 2,
                              ),
                            ),
                        errorStyle: const TextStyle(height: 0),
                      ),
                      menuStyle: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          ColorManager.colorWhite,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                          ),
                        ),
                        maximumSize: WidgetStatePropertyAll(
                          Size(constraints.maxWidth, AppSize.sHeight * 0.3),
                        ),
                      ),
                      hintText: widget.hint,
                      selectedTrailingIcon: Transform.rotate(
                        angle: pi,
                        child: SvgPicture.asset(IconsAssets.arrowDown),
                      ),
                      trailingIcon: SvgPicture.asset(IconsAssets.arrowDown),
                      onSelected: (val) {
                        field.didChange(val);
                        widget.onChanged?.call(val);
                      },
                      dropdownMenuEntries: widget.items.map((entry) {
                        final themeTextStyle = Theme.of(
                          context,
                        ).dropdownMenuTheme.textStyle;
                        return DropdownMenuEntry<T>(
                          value: entry.value,
                          label: entry.label,
                          leadingIcon: entry.leadingIcon,
                          trailingIcon: entry.trailingIcon,
                          style: MenuItemButton.styleFrom(
                            textStyle:
                                widget.dropdownItemTextStyle ?? themeTextStyle,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s6,
                  horizontal: AppSize.s8,
                ),
                child: Text(
                  field.errorText!,
                  style: Theme.of(context).inputDecorationTheme.errorStyle,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PaginatedDropdownMenu<T> extends StatefulWidget {
  const _PaginatedDropdownMenu({
    required this.items,
    required this.buttonSize,
    required this.buttonOffset,
    required this.onSelected,
    this.selectedValue,
    required this.borderRadius,
    this.itemsPerPage,
    this.onLoadMore,
    this.hasMore = false,
    this.isLoadingMore = false,
    required this.scrollController,
    required this.onClose,
    this.onSearch,
    this.initialSearchQuery,
    this.dropdownItemTextStyle,
  });

  final List<DropdownMenuEntry<T>> items;
  final Size buttonSize;
  final Offset buttonOffset;
  final void Function(T?) onSelected;
  final T? selectedValue;
  final double borderRadius;
  final int? itemsPerPage;
  final VoidCallback? onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final ScrollController scrollController;
  final VoidCallback onClose;
  final void Function(String query)? onSearch;
  final String? initialSearchQuery;
  final TextStyle? dropdownItemTextStyle;

  @override
  State<_PaginatedDropdownMenu<T>> createState() =>
      _PaginatedDropdownMenuState<T>();
}

class _PaginatedDropdownMenuState<T> extends State<_PaginatedDropdownMenu<T>> {
  late final TextEditingController _searchController;
  String _searchQuery = '';
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.initialSearchQuery ?? '',
    );
    _searchQuery = widget.initialSearchQuery ?? '';
    // Trigger initial search if there's an initial query
    if (widget.initialSearchQuery != null &&
        widget.initialSearchQuery!.isNotEmpty &&
        widget.onSearch != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSearch!(widget.initialSearchQuery!);
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      // Reset scroll position when search changes
      if (widget.scrollController.hasClients) {
        widget.scrollController.jumpTo(0);
      }
    });

    // Debounce API call
    _debounceTimer?.cancel();
    if (widget.onSearch != null) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        widget.onSearch!(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight * 0.3;
    final menuWidth = widget.buttonSize.width;

    // Position the menu below the button, adjust if it would go off-screen
    double menuLeft = widget.buttonOffset.dx;
    if (menuLeft + menuWidth > screenWidth) {
      menuLeft = screenWidth - menuWidth - 8;
    }
    if (menuLeft < 8) {
      menuLeft = 8;
    }
    final menuTop = widget.buttonOffset.dy + widget.buttonSize.height + 4;

    final showLoadMore =
        widget.hasMore &&
        (widget.onSearch != null ? true : _searchQuery.isEmpty);

    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onClose,
          child: Container(
            color: Colors.transparent,
            width: screenWidth,
            height: screenHeight,
          ),
        ),
        Positioned(
          left: menuLeft,
          top: menuTop,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: menuWidth,
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                color: ColorManager.colorWhite,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search field
                    if (widget.onSearch != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.s12,
                          vertical: AppSize.s8,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: ColorManager.colorGrey1,
                              width: 1,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          onChanged: _onSearchChanged,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorManager.colorFontPrimary,
                              ),
                          decoration: InputDecoration(
                            hintText: 'search'.tr(),
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(AppSize.s12),
                              child: SvgPicture.asset(
                                IconsAssets.searchIcon,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 20),
                                    onPressed: () {
                                      _searchController.clear();
                                      _onSearchChanged('');
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSize.s8,
                              vertical: AppSize.s8,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    Flexible(
                      child: widget.items.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(AppSize.s16),
                              child: Center(
                                child: Text(
                                  'no_results_found'.tr(),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ),
                            )
                          : ListView.separated(
                              controller: widget.scrollController,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  widget.items.length + (showLoadMore ? 1 : 0),
                              separatorBuilder: (context, index) {
                                if (index >= widget.items.length - 1) {
                                  return const SizedBox.shrink();
                                }
                                return Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: ColorManager.colorGrey1,
                                );
                              },
                              itemBuilder: (context, index) {
                                if (index == widget.items.length) {
                                  // Loading indicator at the bottom
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppSize.s12,
                                      horizontal: AppSize.s16,
                                    ),
                                    child: Center(
                                      child: widget.isLoadingMore
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  );
                                }

                                final item = widget.items[index];
                                final isSelected =
                                    item.value == widget.selectedValue;

                                return InkWell(
                                  onTap: () {
                                    widget.onSelected(item.value);
                                    widget.onClose();
                                  },
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
                                        Expanded(
                                          child: Text(
                                            item.label,
                                            style:
                                                widget.dropdownItemTextStyle ??
                                                Theme.of(
                                                  context,
                                                ).dropdownMenuTheme.textStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDownChild extends StatelessWidget {
  const CustomDropDownChild({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
