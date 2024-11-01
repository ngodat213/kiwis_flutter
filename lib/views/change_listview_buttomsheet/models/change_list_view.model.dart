import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/views/change_listview_buttomsheet/models/change_list_view_section_item.model.dart';

class ChangeListViewModel {
  Rx<List<ChangeListViewSectionItemModel>> changeListViewSectionItemList =
      Rx<List<ChangeListViewSectionItemModel>>([
    ChangeListViewSectionItemModel(),
    ChangeListViewSectionItemModel(),
    ChangeListViewSectionItemModel(),
    ChangeListViewSectionItemModel(),
  ]);
}
