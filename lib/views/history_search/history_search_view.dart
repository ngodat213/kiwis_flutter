import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/history_search/history_search_controller.dart';
import 'package:kiwis_flutter/views/history_search/history_searchfv_tab_page.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leading_image.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class HistorySearchScreen extends GetWidget<HistorySearchController> {
  const HistorySearchScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 1040.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildHorizontalScrollSection(),
              Container(
                height: 1008.h,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2006Green600516x342,
                      height: 516.h,
                      width: 344.h,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.symmetric(horizontal: 16.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.customBorderTL24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildAppBarSection(),
                            ),
                            SizedBox(height: 28.h),
                            _buildTabview(),
                            Expanded(
                              child: Container(
                                child: TabBarView(
                                  controller: controller.tabviewController,
                                  children: [
                                    Container(),
                                    Container(),
                                    HistorysearchfrTabPage(),
                                    HistorysearchfrTabPage(),
                                    HistorysearchfrTabPage(),
                                    HistorysearchfrTabPage(),
                                    HistorysearchfrTabPage(),
                                    HistorysearchfrTabPage()
                                  ],
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
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHorizontalScrollSection() {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: SizedBox(
            height: 798.h,
            width: 662.h,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 798.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16.h,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment(0.5, 0),
                      end: Alignment(0.5, 1),
                      colors: [
                        appTheme.gray900,
                        appTheme.gray900.withOpacity(0.14)
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse2005Primary280x544,
                  height: 280.h,
                  width: 546.h,
                  alignment: Alignment.topRight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBarSection() {
    return CustomAppBar(
      height: 28.h,
      leadingWidth: 24.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarTitle(
        text: "lbl_history_search".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return Obx(
      () => Container(
        width: 366.h,
        margin: EdgeInsets.only(left: 8.h),
        child: TabBar(
          controller: controller.tabviewController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: theme.colorScheme.onPrimary.withOpacity(1),
          labelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Google Sans',
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(1),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.fSize,
            fontFamily: 'Google Sans',
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(18.h),
                ),
                child: Text(
                  "lbl_beach".tr,
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 1
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_newyork".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 2
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_free".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 3
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_skip".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 4
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_skip".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 5
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_skip".tr,
                  ),
                ),
              ),
            ),
            Tab(
              height: 36,
              child: Container(
                alignment: Alignment.center,
                decoration: controller.tabIndex.value == 7
                    ? BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ))
                    : BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(
                          18.h,
                        ),
                      ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 10.h,
                  ),
                  child: Text(
                    "lbl_skip".tr,
                  ),
                ),
              ),
            )
          ],
          indicatorColor: Colors.transparent,
          onTap: (index) {
            controller.tabIndex.value = index;
          },
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
