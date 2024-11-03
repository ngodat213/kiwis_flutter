import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:kiwis_flutter/core/app_export.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.notificationOnPressed,
    required this.detailPostOnPressed,
    required this.cameraController,
    required this.isCameraInitialized,
    required this.isFlashOn,
    required this.toggleFlash,
    required this.takePicture,
    required this.toggleRotate,
  });

  final Function() notificationOnPressed;
  final Function() detailPostOnPressed;
  final Function() toggleFlash;
  final Function() takePicture;
  final Function() toggleRotate;
  final CameraController cameraController;
  final RxBool isCameraInitialized;
  final RxBool isFlashOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _cameraWidget();
              }
              return _postSection();
            },
            scrollDirection: Axis.vertical,
            itemCount: 3 + 1,
            loop: false,
            fade: 0.1,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
          ),
        ],
      ),
    );
  }

  Widget _postSection() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvatar,
                      height: 40.h,
                      width: 40.h,
                      radius: BorderRadius.circular(
                        30.h,
                      ),
                    ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "11/11/2024",
                            style: CustomTextStyles
                                .labelLargeGoogleSansMediumOnPrimary,
                          ),
                          Text(
                            "lbl_samms".tr,
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Color(0x0DFFFFFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgStar,
                              height: 40.h,
                              width: 40.h,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.h),
                          GestureDetector(
                            onTap: detailPostOnPressed,
                            child: Container(
                              width: 40.h,
                              height: 40.h,
                              padding: EdgeInsets.all(8.h),
                              decoration: BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.svgArrowRight,
                                height: 40.h,
                                width: 40.h,
                                radius: BorderRadius.circular(
                                  30.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Stack(
                  children: [
                    CustomImageView(
                      radius: BorderRadius.circular(12.h),
                      imagePath: ImageConstant.imgFrame47240200x342,
                      height: Get.width - 72.h,
                      width: Get.width - 72.h,
                    ),
                    Positioned(
                      bottom: 16.h,
                      right: 16.h,
                      child: Row(
                        children: [
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgHeart,
                              height: 40.h,
                              width: 40.h,
                              color: Colors.white,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Container(
                            width: 40.h,
                            height: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CustomImageView(
                              imagePath: ImageConstant.svgComment,
                              height: 40.h,
                              width: 40.h,
                              radius: BorderRadius.circular(
                                30.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Esse incididunt dolore incididunt qui minim eiusmod aliquip reprehenderit duis nisi. Amet dolor aute enim eiusmod aliquip veniam est sit officia. Magna anim nisi laborum sit non minim incididunt pariatur ullamco consectetur. Esse tempor est adipisicing minim sit irure consectetur irure.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.labelLargeGoogleSansMedium.copyWith(
                    height: 1.67,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Container(
          padding: EdgeInsets.all(24.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            borderRadius: BorderRadiusStyle.roundedBorder24,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.svgMenuDefault,
                          height: 24.h,
                          width: 24.h,
                        ),
                        SizedBox(width: 24.h),
                        CustomImageView(
                          imagePath: ImageConstant.imgAvatar,
                          height: 40.h,
                          width: 40.h,
                          radius: BorderRadius.circular(
                            30.h,
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_hello".tr,
                                style: theme.textTheme.labelLarge,
                              ),
                              Text(
                                "lbl_samms".tr,
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: notificationOnPressed,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                borderRadius: BorderRadius.circular(100)),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.h,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.svgBell,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(width: 16.h),
                                Container(
                                  width: 24.h,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF1F41F4),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: theme.textTheme.titleLarge,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraWidget() {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.2),
        Stack(
          children: [
            // Camera Preview
            Obx(() {
              if (isCameraInitialized.value) {
                return Container(
                  width: Get.width - 70.h,
                  height: Get.width - 70.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CameraPreview(cameraController),
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
            }),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 30,
              ),
              onPressed: toggleFlash,
            ),
            GestureDetector(
              onTap: takePicture,
              child: Container(
                width: 70,
                height: 70,
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
              onPressed: toggleRotate,
            ),
          ],
        ),
      ],
    );
  }
}
