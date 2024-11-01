import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/history_search/history_search_controller.dart';
import 'package:kiwis_flutter/views/history_search/models/history_section_item.model.dart';
import 'package:kiwis_flutter/views/history_search/widgets/list_section_item.widget.dart';
import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class HistorysearchfrTabPage extends StatelessWidget {
  HistorysearchfrTabPage({Key? key})
      : super(
          key: key,
        );

  HistorySearchController controller = Get.put(HistorySearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 24.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: _buildListSection(),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListSection() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 12.h,
          );
        },
        itemCount: controller
            .historysearchfrTabModelObj.value.listSectionItemList.value.length,
        itemBuilder: (context, index) {
          ListSectionItemModel model = controller.historysearchfrTabModelObj
              .value.listSectionItemList.value[index];
          return ListsectionItemWidget(
            model,
          );
        },
      ),
    );
  }
}
