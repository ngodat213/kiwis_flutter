import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

class CustomFloatingTextField extends StatelessWidget {
  CustomFloatingTextField(
      {Key? key,
      this.alignment,
      this.width,
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
      this.labelText,
      this.labelStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator,
      this.isTop = false,
      this.isBottom = false})
      : super(
          key: key,
        );
  final Alignment? alignment;
  final double? width;
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
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final bool? isTop;
  final bool? isBottom;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: floatingTextFieldWidget)
        : floatingTextFieldWidget;
  }

  Widget get floatingTextFieldWidget => Container(
        height: 70.h,
        width: width ?? double.maxFinite,
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
          autofocus: autofocus!,
          style: textStyle ?? theme.textTheme.titleMedium,
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
        hintStyle: hintStyle ?? theme.textTheme.bodySmall,
        // labelText: labelText ?? "",
        labelStyle: labelStyle,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 24.h,
              vertical: 30.h,
            ),
        fillColor: fillColor ?? theme.colorScheme.onPrimary,
        filled: filled,
        border: borderDecoration ??
            CustomOutlinedInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: isTop == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                topRight: isTop == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                bottomLeft: isBottom == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                bottomRight: isBottom == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
              ),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            CustomOutlinedInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: isTop == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                topRight: isTop == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                bottomLeft: isBottom == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
                bottomRight: isBottom == true
                    ? Radius.circular(16.h)
                    : Radius.circular(8.h),
              ),
              borderSide: BorderSide.none,
            ),
        focusedBorder: (borderDecoration ??
                CustomOutlinedInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: isTop == true
                        ? Radius.circular(16.h)
                        : Radius.circular(8.h),
                    topRight: isTop == true
                        ? Radius.circular(16.h)
                        : Radius.circular(8.h),
                    bottomLeft: isBottom == true
                        ? Radius.circular(16.h)
                        : Radius.circular(8.h),
                    bottomRight: isBottom == true
                        ? Radius.circular(16.h)
                        : Radius.circular(8.h),
                  ),
                  borderSide: BorderSide.none,
                ))
            .copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1,
          ),
        ),
      );
}

class CustomOutlinedInputBorder extends InputBorder {
  const CustomOutlinedInputBorder(
      {borderSide = const BorderSide(),
      this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
      this.borderGradient,
      this.fillGradient});
  final BorderRadius borderRadius;
  final Gradient? borderGradient;
  final Gradient? fillGradient;
  @override
  bool get isOutline => false;
  @override
  CustomOutlinedInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    Gradient? borderGradient,
    Gradient? fillGradient,
  }) {
    return CustomOutlinedInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      borderGradient: borderGradient ?? this.borderGradient,
      fillGradient: fillGradient ?? this.fillGradient,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  CustomOutlinedInputBorder scale(double t) {
    return CustomOutlinedInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      borderGradient: borderGradient,
      fillGradient: fillGradient,
    );
  }

  @override
  ShapeBorder? lerpFrom(
    ShapeBorder? a,
    double t,
  ) {
    if (a is CustomOutlinedInputBorder) {
      final CustomOutlinedInputBorder outline = a;
      return CustomOutlinedInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        borderGradient: outline.borderGradient,
        fillGradient: outline.fillGradient,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(
    ShapeBorder? b,
    double t,
  ) {
    if (b is CustomOutlinedInputBorder) {
      final CustomOutlinedInputBorder outline = b;
      return CustomOutlinedInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        borderGradient: outline.borderGradient,
        fillGradient: outline.fillGradient,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  Path getOuterPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  void paintInterior(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    TextDirection? textDirection,
  }) {
    if (fillGradient != null) {
      final Paint gradientPaint = Paint()
        ..shader = fillGradient!.createShader(rect)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
          borderRadius.resolve(textDirection).toRRect(rect), gradientPaint);
    } else {
      canvas.drawRRect(
          borderRadius.resolve(textDirection).toRRect(rect), paint);
    }
  }

  @override
  bool get preferPaintInterior => true;
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    if (fillGradient != null) {
      final Paint fillPaint = Paint()
        ..shader = fillGradient!.createShader(rect)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(center, fillPaint);
    }
    if (borderGradient != null) {
      final Paint borderPaint = Paint()
        ..shader = borderGradient!.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderSide.width;
      canvas.drawRRect(center, borderPaint);
    } else {
      final Paint borderPaint = borderSide.toPaint();
      canvas.drawRRect(center, borderPaint);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CustomOutlinedInputBorder &&
        other.borderSide == borderSide &&
        other.borderRadius == borderRadius &&
        other.borderGradient == borderGradient &&
        other.fillGradient == fillGradient;
  }

  @override
  int get hashCode =>
      Object.hash(borderSide, borderRadius, borderGradient, fillGradient);
}
