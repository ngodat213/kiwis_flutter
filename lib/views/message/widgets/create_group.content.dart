import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class MenberSettingContent extends GetView<MessageController> {
  final String title;
  final Function() onTap;
  final bool isCreate;

  const MenberSettingContent({
    super.key,
    required this.title,
    required this.onTap,
    required this.isCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: title,
        actions: [
          "Create"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .bold
              .make()
              .onTap(() {
            onTap();
          }),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isCreate,
                child: Column(
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
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 23.h, vertical: 23.h),
                      boxDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.h),
                      ),
                      controller: controller.createGroupNameTEC,
                    ).marginOnly(bottom: 16),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: controller.selectedFriends.map((friend) {
                      return GestureDetector(
                        onTap: () {
                          controller.onPressedRemoveFriend(friend);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 52.h,
                                width: 52.h,
                                child: Stack(
                                  children: [
                                    CustomImageView(
                                      imagePath:
                                          friend.user?.avatar?.imageUrl ??
                                              AppValues.defaultAvatar,
                                      height: 47.h,
                                      width: 47.h,
                                      radius: BorderRadius.circular(100),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: CustomImageView(
                                          color: Colors.black,
                                          imagePath:
                                              ImageConstant.imgClosePrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              friend.user!.fullName.text
                                  .textStyle(
                                    theme.textTheme.titleSmall!.copyWith(
                                      color: theme.colorScheme.onPrimary
                                          .withOpacity(1),
                                    ),
                                  )
                                  .make(),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                      controller.onPressedRemoveFriend(friend);
                    },
                    leading: CustomImageView(
                      imagePath: friend.user?.avatar?.imageUrl ??
                          AppValues.defaultAvatar,
                      height: 47.h,
                      width: 47.h,
                      radius: BorderRadius.circular(100),
                      fit: BoxFit.cover,
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
                      () => controller.selectedFriends.contains(friend)
                          ? CustomImageView(
                              imagePath: ImageConstant.svgCheckCircle,
                              height: 24.h,
                              width: 24.h,
                            )
                          : CustomImageView(
                              imagePath: ImageConstant.svgCircle,
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
