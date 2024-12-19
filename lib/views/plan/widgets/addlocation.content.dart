import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class AddLocationContent extends GetView<PlanController> {
  const AddLocationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.h),
          topRight: Radius.circular(24.h),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Center(
            child: Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18.h),
              ),
            ),
          ),
          SizedBox(height: 24),
          "Add location"
              .tr
              .text
              .bold
              .black
              .textStyle(theme.textTheme.titleLarge)
              .make(),
          SizedBox(height: 8),
          'Fill in the information below to add a location'
              .tr
              .text
              .black
              .textStyle(theme.textTheme.bodySmall)
              .make(),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Location name",
            hintStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            labelText: "Location name".tr,
            labelStyle:
                theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            textStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            height: 56 + 16,
            fillColor: Colors.grey.shade200,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
            controller: controller.locationNameTEC,
          ),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Estimated cost",
            hintStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            labelText: "Estimated cost".tr,
            labelStyle:
                theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            textStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            height: 56 + 16,
            fillColor: Colors.grey.shade200,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
            controller: controller.estimatedCostTEC,
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 8),
          CustomTextFormField(
            hintText: "Estimated time",
            hintStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            labelText: "Estimated time".tr,
            labelStyle:
                theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            textStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.black),
            height: 56 + 16,
            fillColor: Colors.grey.shade200,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
            controller: controller.estimatedTimeTEC,
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 32),
          CustomElevatedButton(
            buttonStyle: CustomButtonStyles.fillGreen,
            onPressed: () => controller.changeCurrentLocation(),
            text: "Add location".tr,
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
