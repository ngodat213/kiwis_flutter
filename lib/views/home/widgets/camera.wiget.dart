import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class CameraWidget extends GetView<HomeController> {
  const CameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.2),
        Stack(
          children: [
            // Camera Preview
            Obx(() {
              if (controller.onPost.value) {
                return Container(
                  height: Get.width - 70.h,
                  width: Get.width - 70.h,
                  child: Stack(
                    children: [
                      Container(
                        width: Get.width - 70.h,
                        height: Get.width - 70.h,
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
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: Get.width - 97.h,
                              decoration: BoxDecoration(
                                color: appTheme.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: appTheme.black.withOpacity(0.3),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.h),
                                child: TextField(
                                  controller: controller.captionTEC,
                                  maxLines: 1,
                                  maxLength: 30,
                                  style: TextStyle(color: appTheme.black),
                                  decoration: InputDecoration(
                                    hintText: 'Enter text',
                                    hintStyle: TextStyle(color: appTheme.black),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).marginOnly(bottom: 16.h),
                    ],
                  ),
                );
              } else {
                if (controller.isCameraInitialized.value) {
                  return Container(
                    width: Get.width - 70.h,
                    height: Get.width - 70.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CameraPreview(controller.cameraController),
                    ),
                  );
                } else {
                  return Container(
                    width: Get.width - 70.h,
                    height: Get.width - 70.h,
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
          () {
            return controller.onPost.value
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
                                color: appTheme.black,
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
                              color: appTheme.black,
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
                          color: appTheme.black,
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
                              color: appTheme.black,
                              width: 4,
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: appTheme.black,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.flip_camera_ios,
                          color: appTheme.black,
                          size: 30,
                        ),
                        onPressed: controller.toggleRotate,
                      ),
                    ],
                  );
          },
        )
      ],
    );
  }
}
