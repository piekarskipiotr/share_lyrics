import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    required this.label,
    required this.textController,
    this.maxLines = 1,
    this.isRequired = false,
    this.isReadOnly = false,
    this.prefixIcon,
    this.onChange,
    super.key,
  });

  final TextEditingController textController;
  final String label;
  final int maxLines;
  final bool isRequired;
  final bool isReadOnly;
  final IconData? prefixIcon;
  final void Function(String)? onChange;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  var _hasFocus = false;
  var _focusNode = FocusNode();

  bool get isFocusLost => _hasFocus && !_focusNode.hasFocus;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final opacity = _hasFocus ? 1.0 : 0.75;
    final hintColor = AppColors.white.withOpacity(opacity);
    return TextFormField(
      readOnly: widget.isReadOnly,
      controller: widget.textController,
      autocorrect: false,
      focusNode: _focusNode,
      onChanged: (value) {
        widget.onChange?.call(value);
      },
      onTapOutside: (_) {
        _focusNode.unfocus();
      },
      maxLines: widget.maxLines,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: AppTextStyles.h9(fontWeight: FontWeight.w500, color: hintColor),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(widget.prefixIcon, color: hintColor),
            const SizedBox(width: 8),
          ],
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 48),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        border: _textFormFieldBorder(),
        enabledBorder: _textFormFieldBorder(),
        focusedBorder: _textFormFieldBorder(borderColor: AppColors.white),
        disabledBorder: _textFormFieldBorder(),
        filled: true,
        fillColor: AppColors.fieldBg,
        helperStyle: AppTextStyles.h11(fontWeight: FontWeight.w300),
      ),
      style: AppTextStyles.h9(fontWeight: FontWeight.w500),
    );
  }

  static InputBorder _textFormFieldBorder({Color borderColor = AppColors.transparent}) => OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(32),
      );
}
