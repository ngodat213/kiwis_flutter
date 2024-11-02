import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/invoce/invoce_controller.dart';
import 'package:kiwis_flutter/views/invoce/models/invoce_one_item.model.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class InvoceOneItemWidget extends StatelessWidget {
  InvoceOneItemWidget(this.invoceOneItemModelObj, {Key? key})
      : super(
          key: key,
        );

  InvoceOneItemModel invoceOneItemModelObj;

  var controller = Get.find<InvoceController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => CustomImageView(
            imagePath: invoceOneItemModelObj.transportOne!.value,
            height: 20.h,
            width: 22.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Obx(
            () => Text(
              invoceOneItemModelObj.transportTwo!.value,
              style: theme.textTheme.titleSmall,
            ),
          ),
        ),
        Spacer(),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Text(
                    invoceOneItemModelObj.text!.value,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                SizedBox(width: 8.h),
                CustomImageView(
                  imagePath: ImageConstant.svgDollar,
                  height: 16.h,
                  width: 16.h,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
