import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/explore_location_main/explore_location_main_controller.dart';
import 'package:kiwis_flutter/views/explore_location_main/models/post_list_item.model.dart';
import 'package:kiwis_flutter/views/explore_location_main/widgets/post_list_item.widget.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_search_view.dart';

class ExploreLocationMainScreen
    extends GetWidget<ExploreLocationMainController> {
  const ExploreLocationMainScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 1040.h,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  _buildHeaderStack(),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      bottom: 22.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSearchSection(),
                        SizedBox(height: 16.h),
                        _buildPostList(),
                        SizedBox(height: 16.h),
                        _buildMostLikedRow(),
                        SizedBox(height: 16.h),
                        _buildFeaturedPost()
                      ],
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2005,
                    height: 280.h,
                    width: 274.h,
                    alignment: Alignment.topRight,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2006Green600516x342,
                    height: 516.h,
                    width: 344.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderStack() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 282.h,
        decoration: BoxDecoration(
          color: appTheme.gray900,
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgGroup231,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle9922,
              height: 240.h,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 24.h,
                  top: 32.h,
                  right: 24.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      leadingWidth: 44.h,
                      leading: AppbarLeadingIconbutton(
                        imagePath: ImageConstant.imgArrowLeftOnprimary,
                        onTap: () {
                          onTapArrowleftone();
                        },
                      ),
                      title: AppbarTitle(
                        text: "lbl_tours".tr,
                        margin: EdgeInsets.only(left: 16.h),
                      ),
                    ),
                    SizedBox(height: 54.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_exploer_in".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          TextSpan(
                            text: "lbl_london".tr,
                            style: theme.textTheme.displayMedium,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMoreButton() {
    return CustomElevatedButton(
      width: 70.h,
      text: "lbl_more".tr,
      buttonStyle: CustomButtonStyles.fillOnPrimaryTL183,
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }

  /// Section Widget
  Widget _buildSearchSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 8.h,
        right: 24.h,
      ),
      child: Column(
        children: [
          CustomSearchView(
            controller: controller.searchController,
            hintText: "lbl_search".tr,
            contentPadding: EdgeInsets.fromLTRB(28.h, 16.h, 16.h, 16.h),
            borderDecoration: SearchViewStyleHelper.fillOnPrimary,
            fillColor: theme.colorScheme.onPrimary,
          ),
          SizedBox(height: 32.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  height: 28.h,
                  width: 28.h,
                  padding: EdgeInsets.all(8.h),
                  decoration: IconButtonStyleHelper.fillPinkA,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgStackOnprimary,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      bottom: 6.h,
                    ),
                    child: Text(
                      "lbl_pined_post".tr,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                Spacer(),
                _buildMoreButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPostList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 8.h),
        child: Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 12.h,
              children: List.generate(
                controller.exploreLocationMainModelObj.value.postListItemModels
                    .value.length,
                (index) {
                  PostListItemModel model = controller
                      .exploreLocationMainModelObj
                      .value
                      .postListItemModels
                      .value[index];
                  return PostlistItemWidget(
                    model,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNewestButton() {
    return CustomElevatedButton(
      height: 36.h,
      width: 100.h,
      text: "lbl_newest".tr,
      rightIcon: Container(
        margin: EdgeInsets.only(left: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowUp,
          height: 16.h,
          width: 16.h,
          fit: BoxFit.contain,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillOnPrimaryTL183,
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }

  /// Section Widget
  Widget _buildMostLikedRow() {
    return Container(
      margin: EdgeInsets.only(right: 16.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: CustomIconButton(
              height: 28.h,
              width: 28.h,
              padding: EdgeInsets.all(8.h),
              decoration: IconButtonStyleHelper.fillGreenTL14,
              child: CustomImageView(
                imagePath: ImageConstant.imgStarOnprimary48x48,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              bottom: 6.h,
            ),
            child: Text(
              "lbl_most_like_post".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          _buildNewestButton()
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFeaturedPost() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 16.h),
      padding: EdgeInsets.fromLTRB(12.h, 16.h, 12.h, 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgAvatarOnprimary,
                  height: 40.h,
                  width: 40.h,
                  radius: BorderRadius.circular(
                    20.h,
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl_post_in".tr,
                          style: CustomTextStyles
                              .labelLargeGoogleSansMediumOnPrimary,
                        ),
                        Text(
                          "lbl_tower_of_london".tr,
                          style: theme.textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.h),
                CustomIconButton(
                  height: 40.h,
                  width: 40.h,
                  padding: EdgeInsets.all(8.h),
                  decoration: IconButtonStyleHelper.fillOnPrimaryTL20,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgArrowRight,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CustomImageView(
            imagePath: ImageConstant.imgFrame47240,
            height: 200.h,
            width: double.maxFinite,
            radius: BorderRadius.circular(
              24.h,
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
