// There are used in the code as a reference to create your UI Responsively
import 'package:flutter/widgets.dart';

const num FIGMA_DESIGN_WIDTH = 390;
const num FIGMA_DESIGN_HEIGHT = 844;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ReponsiviExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width)) / FIGMA_DESIGN_WIDTH;
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
  BuildContext context, {
  Orientation orientation,
  DeviceType deviceType,
});

class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils.setScreenSize(constraints, orientation);
            return builder(context, orientation: orientation);
          },
        );
      },
    );
  }
}

// ignore_for_file: must_
class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints constraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's width
  static late double width;

  /// Device's height
  static late double height;

  static void setScreenSize(
    BoxConstraints boxConstraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    currentOrientation = currentOrientation;

    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}
