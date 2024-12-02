import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/grid_view/models/grid_view.model.dart';
import 'package:kiwis_flutter/views/grid_view/models/grid_view_free_ini_tab.model.dart';

class GridViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<GridViewModel> gridViewModelObj = GridViewModel().obs;

  late TabController tabViewController =
      Get.put(TabController(length: 2, vsync: this));

  Rx<int> tabIndex = 0.obs;

  Rx<GridViewFreeIniTabModel> gridViewFreeIniTabModelObj =
      GridViewFreeIniTabModel().obs;
}
