import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/search_post/search_post_controller.dart';
import 'package:kiwis_flutter/views/search_post/search_resultgrid_item_model.dart';
import 'package:kiwis_flutter/views/search_post/widgets/rearchresultgrid_item_widget.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_titlesearch_view_one.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class SearchPostScreen extends GetWidget<SearchPostController> {
  const SearchPostScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: 798.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2006Green600,
                height: 274.h,
                width: 344.h,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2005Primary282x272,
                height: 282.h,
                width: 274.h,
                alignment: Alignment.topRight,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 32.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: _buildAppbar(),
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.customBorderTL24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [_buildSearchResultsGrid()],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 56.h,
      title: AppbarTitleSearchviewOne(
        hintText: "lbl_typing".tr,
        controller: controller.searchController,
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSearchResultsGrid() {
    return Expanded(
      child: Obx(
        () => ResponsiveGridListBuilder(
          minItemWidth: 1,
          minItemsPerRow: 2,
          maxItemsPerRow: 2,
          horizontalGridSpacing: 6.h,
          verticalGridSpacing: 6.h,
          builder: (context, items) => ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            children: items,
          ),
          gridItems: List.generate(
            controller.searchPostModelObj.value.searchresultsgridItemList.value
                .length,
            (index) {
              SearchresultsgridItemModel model = controller.searchPostModelObj
                  .value.searchresultsgridItemList.value[index];
              return SearchresultsgridItemWidget(
                model,
              );
            },
          ),
        ),
      ),
    );
  }
}
