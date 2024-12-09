import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dotted_line/dotted_line.dart';

class LocationCard extends GetView<PlanController> {
  const LocationCard(
      {super.key,
      required this.name,
      required this.estimatedCost,
      required this.estimatedTime,
      required this.address,
      this.isLast = false,
      required this.index});
  final String name;
  final String estimatedCost;
  final String estimatedTime;
  final String address;
  final bool? isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: VStack([
            HStack([
              Row(
                children: [
                  name.text.bold.textStyle(theme.textTheme.titleLarge).make(),
                  SizedBox(width: 10),
                  '${estimatedTime} Minutes'
                      .text
                      .bold
                      .textStyle(theme.textTheme.titleSmall)
                      .make(),
                ],
              ),
              Spacer(),
              'Remove'
                  .tr
                  .text
                  .bold
                  .textStyle(theme.textTheme.titleSmall)
                  .make()
                  .onTap(() => controller.removeLocation(index)),
            ]),
            '${estimatedCost} VNĐ'
                .text
                .bold
                .textStyle(theme.textTheme.titleSmall)
                .make(),
            SizedBox(height: 10),
            address.text.textStyle(theme.textTheme.bodySmall).make(),
          ]),
        ),
        SizedBox(height: 10),
        Visibility(
          visible: isLast == false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1,
                  dashLength: 4,
                  dashGapLength: 2,
                  dashColor: Colors.white,
                ),
              ),
              CustomIconButton(
                height: 36.h,
                width: 36.h,
                padding: EdgeInsets.all(10.h),
                onTap: () {
                  controller.onTapSwapLocation(index);
                },
                child: Center(
                  child: Icon(
                    size: 16,
                    Icons.swap_vert,
                    color: Colors.white,
                  ),
                ),
              ).marginSymmetric(horizontal: 10),
              Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1,
                  dashLength: 4,
                  dashGapLength: 2,
                  dashColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
