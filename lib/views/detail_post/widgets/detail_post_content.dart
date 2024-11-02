import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/detail_post/models/detail_post.model.dart';
import 'package:kiwis_flutter/views/detail_post/models/detail_post_list_item.model.dart';
import 'package:kiwis_flutter/views/detail_post/widgets/detail_post_list_item.widget.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton_one.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton_one.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';

class DetailPostContent extends StatelessWidget {
  DetailPostContent({super.key, required this.detailPostModelObj});

  final Rx<DetailPostModel> detailPostModelObj;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBar(),
        ),
        _buildDetailPostList(),
      ],
    );
  }

  /// Section Widget
  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
        leadingWidth: 68.h,
        leading: AppbarLeadingIconbuttonOne(
          imagePath: ImageConstant.imgArrowLeftOnprimary,
          margin: EdgeInsets.only(left: 24.h),
          onTap: () {
            onTapArrowleftone();
          },
        ),
        centerTitle: true,
        title: AppbarTitle(
          text: "lbl_buckingham".tr,
        ),
        actions: [
          AppbarTrailingIconbuttonOne(
            imagePath: ImageConstant.svgMore,
            margin: EdgeInsets.only(right: 24.h),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDetailPostList() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.h,
          top: 92.h,
          right: 16.h,
        ),
        child: Obx(
          () => ListView.separated(
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 16.h,
              );
            },
            itemCount:
                detailPostModelObj.value.detailpostlistItemList.value.length,
            itemBuilder: (context, index) {
              DetailPostListItemModel model =
                  detailPostModelObj.value.detailpostlistItemList.value[index];
              return DetailpostlistItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMenuBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 240.h),
      padding: EdgeInsets.symmetric(
        horizontal: 32.h,
        vertical: 48.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [appTheme.gray900.withOpacity(0), appTheme.gray900],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 52.h),
            child: CustomIconButton(
              height: 56.h,
              width: 56.h,
              padding: EdgeInsets.all(16.h),
              decoration: IconButtonStyleHelper.fillOnPrimaryTL281,
              child: CustomImageView(
                imagePath: ImageConstant.imgInterfacePrimary,
              ),
            ),
          ),
          SizedBox(width: 8.h),
          SizedBox(width: 8.h),
          CustomElevatedButton(
            text: "lbl_use_tour".tr,
            width: 262.h,
            buttonStyle: CustomButtonStyles.fillPrimary,
          ),
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
