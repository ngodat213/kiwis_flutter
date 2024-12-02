import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/history_search/models/history_section_item.model.dart';

class HistorySearchFrTabModel {
  Rx<List<ListSectionItemModel>> listSectionItemList = Rx([
    ListSectionItemModel(),
    ListSectionItemModel(),
    ListSectionItemModel(),
    ListSectionItemModel(),
    ListSectionItemModel(),
    ListSectionItemModel(),
  ]);
}
