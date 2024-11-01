import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/invoce/invoce_controller.dart';
import 'package:kiwis_flutter/views/invoce/models/invoce_one_item.model.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton_one.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton_two.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/invoce_one_item_widget.dart'; // ignore_for_file: must_be_immutable

class InvoceScreen extends GetWidget<InvoceController> {
  const InvoceScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 798.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildLocationInfo(),
                  _buildInvoiceDetails(),
                  _buildSummarySection(),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2005,
                    height: 280.h,
                    width: 274.h,
                    alignment: Alignment.topRight,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2006,
                    height: 340.h,
                    width: 240.h,
                    alignment: Alignment.bottomLeft,
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
  Widget _buildLocationInfo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 32.h),
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBar(
              leadingWidth: 44.h,
              leading: AppbarLeadingIconbuttonOne(
                imagePath: ImageConstant.imgArrowLeftOnprimary,
                onTap: () {
                  onTapArrowleftone();
                },
              ),
              title: AppbarTitle(
                text: "lbl_invoice_trip".tr,
                margin: EdgeInsets.only(left: 16.h),
              ),
              actions: [
                AppbarTrailingIconbuttonTwo(
                  imagePath: ImageConstant.imgArrowDownCircle,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                )
              ],
            ),
            SizedBox(height: 32.h),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 8.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse203964x64,
                    height: 64.h,
                    width: 64.h,
                    radius: BorderRadius.circular(
                      32.h,
                    ),
                  ),
                  Container(
                    width: 196.h,
                    margin: EdgeInsets.only(left: 24.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_greenwich2".tr,
                            style: theme.textTheme.headlineLarge,
                          ),
                          TextSpan(
                            text: "msg_royal_observatory".tr,
                            style: CustomTextStyles.titleSmallGoogleSansMedium,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  /// Section Widget
  Widget _buildInvoiceDetails() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 196.h),
        padding: EdgeInsets.symmetric(
          horizontal: 36.h,
          vertical: 22.h,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.onPrimary,
              width: 1.h,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.h),
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 30.h);
                  },
                  itemCount: controller
                      .invoceModelObj.value.invoceOneItemList.value.length,
                  itemBuilder: (context, index) {
                    InvoceOneItemModel model = controller
                        .invoceModelObj.value.invoceOneItemList.value[index];
                    return InvoceOneItemWidget(model);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSummarySection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 54.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.fromLTRB(32.h, 18.h, 32.h, 20.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.onPrimary,
                  width: 1.h,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        height: 28.h,
                        width: 28.h,
                        padding: EdgeInsets.all(8.h),
                        decoration: IconButtonStyleHelper.fillOnPrimaryTL14,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowDownCircleOnprimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "lbl_discount".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "lbl_30_000".tr,
                              style: theme.textTheme.labelLarge,
                            ),
                            SizedBox(width: 8.h),
                            CustomImageView(
                              imagePath: ImageConstant.imgDollar,
                              height: 16.h,
                              width: 16.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                        height: 28.h,
                        width: 28.h,
                        padding: EdgeInsets.all(8.h),
                        decoration: IconButtonStyleHelper.fillGreenTL14,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgPlusOnprimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "lbl_total".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "lbl_2600_00".tr,
                              style: theme.textTheme.labelLarge,
                            ),
                            SizedBox(width: 8.h),
                            CustomImageView(
                              imagePath: ImageConstant.imgDollar,
                              height: 16.h,
                              width: 16.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 26.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 20.h),
            child: Column(
              children: [
                Text(
                  "msg_lorem_ipsum_is_simply8".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleSmallGoogleSansMediumOnPrimary
                      .copyWith(height: 1.71),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        height: 56.h,
                        width: 56.h,
                        padding: EdgeInsets.all(16.h),
                        decoration: IconButtonStyleHelper.fillOnPrimaryTL28,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgUser,
                        ),
                      ),
                      CustomIconButton(
                        height: 56.h,
                        width: 56.h,
                        padding: EdgeInsets.all(16.h),
                        decoration: IconButtonStyleHelper.fillOnPrimaryTL28,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgGoogle,
                        ),
                      ),
                      CustomIconButton(
                        height: 56.h,
                        width: 56.h,
                        padding: EdgeInsets.all(16.h),
                        decoration: IconButtonStyleHelper.fillOnPrimaryTL28,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgFacebook,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  onTapArrowleftone() {
    Get.back();
  }
}
