import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/detail_post/detail_post_controller.dart';
import 'package:kiwis_flutter/views/detail_post/models/detail_post.model.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class DetailpostlistItemWidget extends StatelessWidget {
  DetailpostlistItemWidget(this.detailpostlistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  DetailPostListItemModel detailpostlistItemModelObj;

  var controller = Get.find<DetailPostController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 8.h),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      top: 12.h,
                      right: 12.h,
                      bottom: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder32,
                      image: DecorationImage(
                        image: AssetImage(
                          ImageConstant.imgFrame47240200x342,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 136.h),
                        CustomIconButton(
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillOnPrimaryTL202,
                          child: CustomImageView(
                            color: Colors.black,
                            imagePath: ImageConstant.svgFullscreen,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.onPrimary,
                    width: 1.h,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary.withOpacity(1),
                            borderRadius: BorderRadiusStyle.circleBorder18,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgAvatar40x40,
                                height: 40.h,
                                width: double.maxFinite,
                                radius: BorderRadius.circular(
                                  20.h,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  detailpostlistItemModelObj.date!.value,
                                  style: CustomTextStyles
                                      .labelLargeGoogleSansMediumOnPrimary,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  detailpostlistItemModelObj.foridaNessi!.value,
                                  style: theme.textTheme.titleSmall,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 16.h),
                        CustomIconButton(
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.all(8.h),
                          decoration: IconButtonStyleHelper.none,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgStarGreen300,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 26.h),
                  SizedBox(
                    width: 322.h,
                    child: Obx(
                      () => Text(
                        detailpostlistItemModelObj.description!.value,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelLargeGoogleSansMedium
                            .copyWith(
                          height: 1.67,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
