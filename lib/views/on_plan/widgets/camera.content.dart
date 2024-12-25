import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/on_plan/on_plan_controller.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';

class CameraContent extends GetView<OnPlanController> {
  const CameraContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: GlossyContainer(
        height: Get.height * 0.7,
        width: Get.width * 0.9,
        borderRadius: BorderRadius.circular(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                // Camera Preview
                Obx(() {
                  if (controller.onPost.value) {
                    return Container(
                      height: Get.width - 70.h + 32,
                      width: Get.width - 70.h + 32,
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width - 70.h + 32,
                            height: Get.width - 70.h + 32,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(controller.imageXFile.value.path),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                    width: Get.width - 109.h + 33,
                                    decoration: BoxDecoration(
                                      color: appTheme.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: appTheme.black.withOpacity(0.3),
                                      ),
                                    ),
                                    child: CustomTextFormField(
                                      controller: controller.captionTEC,
                                      boxDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 32.h, vertical: 16.h),
                                      hintText: 'Thêm chú thích...',
                                      hintStyle:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                          ).marginOnly(bottom: 16.h, left: 16.h, right: 16.h),
                        ],
                      ),
                    );
                  } else {
                    if (controller.isCameraInitialized.value) {
                      return Container(
                        width: Get.width - 70.h + 32,
                        height: Get.width - 70.h + 32,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CameraPreview(controller.cameraController),
                        ),
                      );
                    } else {
                      return Container(
                        width: Get.width - 70.h + 32,
                        height: Get.width - 70.h + 32,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }
                  }
                }),
              ],
            ),
            SizedBox(height: 20.h),
            Obx(
              () => controller.onPost.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: controller.closeOnPost,
                          child: Container(
                            width: 60.h,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: controller.closeOnPost,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.handlePost(context),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:
                                  theme.colorScheme.onPrimary.withOpacity(0.05),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 60.h,
                          height: 60.h,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            controller.isFlashOn.value
                                ? Icons.flash_on
                                : Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: controller.toggleFlash,
                        ),
                        GestureDetector(
                          onTap: controller.takePicture,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: controller.toggleRotate,
                        ),
                      ],
                    ),
            ),
          ],
        ).paddingSymmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
