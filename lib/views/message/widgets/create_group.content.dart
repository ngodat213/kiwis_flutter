import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateGroupContent extends GetView<MessageController> {
  const CreateGroupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Create group".tr,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Group name"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleLarge)
                  .bold
                  .make(),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: "Group name",
                height: 56 + 16,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.h),
                ),
                controller: controller.groupNameTEC,
              ).marginOnly(bottom: 16),
              "Recommend friends"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleLarge)
                  .bold
                  .make(),
              SizedBox(height: 8),
              ListView.builder(
                itemCount: controller.user.value.friends?.length ?? 0,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final friend = controller.user.value.friends![index];
                  return ListTile(
                    onTap: () {
                      controller.selectedFriends.add(friend.user!.userId!);
                    },
                    leading: CustomImageView(
                      imagePath: friend.user?.avatar?.imageUrl ??
                          AppValues.defaultAvatar,
                      height: 47.h,
                      width: 47.h,
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        friend.user!.fullName.text
                            .textStyle(
                              theme.textTheme.titleSmall!.copyWith(
                                color:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                              ),
                            )
                            .make(),
                      ],
                    ),
                    trailing: Obx(
                      () => controller.selectedFriends
                              .contains(friend.user!.userId)
                          ? CustomImageView(
                              imagePath: ImageConstant.svgCircle,
                              height: 24.h,
                              width: 24.h,
                            )
                          : CustomImageView(
                              imagePath: ImageConstant.svgCheckCircle,
                              height: 24.h,
                              width: 24.h,
                            ),
                    ),
                  );
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
