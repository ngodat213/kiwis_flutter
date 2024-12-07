import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class GroupNameContent extends GetView<MessageController> {
  const GroupNameContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Change group name".tr,
        actions: [
          "Save"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .bold
              .make()
              .onTap(() {
            controller.handleChangeGroupName(context);
          }),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(
                child: Obx(
                  () => controller.isOnchangeAvatar.value
                      ? CustomImageView(
                          imageBytes: controller.editGroupAvatar.value
                              .readAsBytesSync(),
                          imageType: ImageType.memory,
                          onTap: controller.pickAvatar,
                          height: 100.h,
                          width: 100.h,
                          radius: BorderRadius.circular(100.h),
                        )
                      : CustomImageView(
                          onTap: () => controller.pickAvatar(),
                          imagePath: controller.getAvatarGroup(),
                          imageType: ImageType.file,
                          height: 100.h,
                          width: 100.h,
                          radius: BorderRadius.circular(100.h),
                        ),
                ),
              ),
              SizedBox(height: 32),
              "Group name"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleLarge)
                  .bold
                  .make(),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Group name",
                controller: controller.editGroupNameTEC,
                height: 56 + 16,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.h),
                ),
              ).marginOnly(bottom: 16),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
