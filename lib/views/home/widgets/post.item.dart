import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/post.model.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';

class PostItem extends GetView<HomeController> {
  const PostItem({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
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
                      imagePath: post.user?.avatar?.imageUrl ??
                          AppValues.defaultAvatar,
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
                            post.formatPostedAt(),
                            style: CustomTextStyles
                                .labelLargeGoogleSansMediumOnPrimary,
                          ),
                          Text(
                            "${post.user?.lastName} ${post.user?.firstName}",
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
                            onTap: controller.detailPostOnPressed,
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
                      imagePath: post.images?.first.imageUrl ?? "",
                      height: Get.width - 72.h,
                      width: Get.width - 72.h,
                      fit: BoxFit.cover,
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
                  post.caption ?? "",
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
    ;
  }
}
