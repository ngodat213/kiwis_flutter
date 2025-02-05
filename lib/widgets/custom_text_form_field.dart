import 'package:flutter/material.dart';
import '../core/constants/app_export.dart';

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillBlack => OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            4.h,
          ),
          topRight: Radius.circular(
            28.h,
          ),
          bottomLeft: Radius.circular(
            4.h,
          ),
          bottomRight: Radius.circular(
            28.h,
          ),
        ),
        borderSide: BorderSide.none,
      );
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.alignment,
      this.width,
      this.height,
      this.boxDecoration,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
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
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.labelText,
      this.labelStyle,
      this.onChanged,
      this.validator})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final double? height;

  final BoxDecoration? boxDecoration;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final bool? readOnly;

  final VoidCallback? onTap;

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

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final String? labelText;

  final TextStyle? labelStyle;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget)
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        // height: height ?? Get.height,
        decoration: boxDecoration,
        child: TextFormField(
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
          controller: controller,
          focusNode: focusNode,
          onTapOutside: (event) {
            if (focusNode != null) {
              focusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          onChanged: onChanged,
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.titleSmallGoogleSansMediumMedium,
          obscureText: obscureText!,
          readOnly: readOnly!,
          onTap: () {
            onTap?.call();
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        labelText: labelText,
        labelStyle: labelStyle ?? theme.textTheme.bodySmall,
        hintStyle: hintStyle ?? theme.textTheme.bodySmall,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 24.h,
              vertical: 38.h,
            ),
        filled: filled,
        fillColor: fillColor ?? theme.colorScheme.onPrimary.withOpacity(0.05),
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide.none,
            ),
        focusedBorder: (borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
            )),
      );
}
