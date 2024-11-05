import 'package:kiwis_flutter/core/constants/app_export.dart';

class ChangeListViewSectionItemModel {
  ChangeListViewSectionItemModel({this.use, this.listView, this.id}) {
    use = use ?? Rx("use");
    listView = listView ?? Rx("listView");
    id = id ?? Rx("id");
  }

  Rx<String>? use;
  Rx<String>? listView;
  Rx<String>? id;
}
