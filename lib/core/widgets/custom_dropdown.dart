import 'dart:developer';

import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/extensions/list_extension.dart';
import './label_text_field.dart';
import './popup/popup.dart';

final class CustomDropdownEntry<T> {
  final T value;
  final String label;

  const CustomDropdownEntry(this.value, this.label);
}

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    this.activeItem,
    this.onChanged,
    required this.textController,
    required this.label,
    required this.hintText,
  });

  final List<CustomDropdownEntry<T>> items;
  final CustomDropdownEntry<T>? activeItem;
  final ValueChanged<CustomDropdownEntry<T>>? onChanged;
  final TextEditingController textController;
  final String label;
  final String hintText;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconAnimation;
  CustomDropdownEntry<T>? _activeItem;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _iconAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
    _activeItem = widget.activeItem;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown(OverlayPortalController controller) {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    controller.isShowing ? controller.hide() : controller.show();
  }

  void _setActiveItem(
    CustomDropdownEntry<T> item,
    OverlayPortalController controller,
  ) {
    setState(() {
      _activeItem = item;
    });
    widget.textController.text = item.label;
    widget.onChanged?.call(item);
    log('${_activeItem?.label}');
    controller.hide();
    if (_controller.isCompleted) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Popup(
      child: (context, controller) => TapRegion(
        debugLabel: 'CustomDropdown',
        groupId: controller,
        child: LabelTextField(
          controller: widget.textController,
          label: widget.label,
          hintText: widget.hintText,
          readOnly: true,
          suffixIcon: RotationTransition(
            turns: _iconAnimation,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          onTap: () {
            _toggleDropdown(controller);
          },
          // onTap: widget.onChanged == null
          //     ? null
          //     : () {
          //         _toggleDropdown(controller);
          //       },
        ),
      ),
      follower: (context, controller) => PopupFollower(
        onDismiss: controller.hide,
        tapRegionGroupId: controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: AppColors.w50,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.mapIndexed(
                  (index, item) => ListTile(
                    selected: item == _activeItem,
                    selectedTileColor: AppColors.p50,
                    trailing: item == _activeItem
                        ? const Icon(
                            Icons.done,
                            color: Color(0xff232323),
                          )
                        : null,
                    autofocus:
                        _activeItem == null ? index == 0 : item == _activeItem,
                    title: Text(
                      item.label,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: AppColors.b300),
                    ),
                    onTap: () {
                      _setActiveItem(item, controller);
                      // widget.onChanged?.call(item);
                      // controller.hide();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
