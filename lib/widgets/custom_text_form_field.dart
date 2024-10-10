import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onTap,
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final bool filled;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildTextFormField(context))
        : _buildTextFormField(context);
  }

  Widget _buildTextFormField(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        style: textStyle ?? CustomTextStyles.titleSmallGoogleSansMediumMedium,
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(context),
        validator: validator,
        onTap: onTap,
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle ?? Theme.of(context).textTheme.bodySmall,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      isDense: true,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 24.h, vertical: 38.h),
      fillColor: fillColor ?? Theme.of(context).colorScheme.onPrimary,
      filled: filled,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder().copyWith(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.h),
      borderSide: BorderSide.none,
    );
  }
}

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillBlack => OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.h),
          topRight: Radius.circular(28.h),
          bottomLeft: Radius.circular(4.h),
          bottomRight: Radius.circular(28.h),
        ),
        borderSide: BorderSide.none,
      );
}
