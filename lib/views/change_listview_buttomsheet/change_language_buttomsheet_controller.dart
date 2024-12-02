import 'package:get/get.dart';
import 'package:kiwis_flutter/views/change_listview_buttomsheet/models/change_list_view.model.dart';

class ChangeListViewController extends GetxController {
  Rx<ChangeListViewModel> changeListViewModelObj = ChangeListViewModel().obs;
}
