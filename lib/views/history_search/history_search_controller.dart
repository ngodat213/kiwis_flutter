import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/history_search/models/histortsearchfr_tab.model.dart';
import 'package:kiwis_flutter/views/history_search/models/history_search.model.dart';

class HistorySearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<HistorySearchModel> historySearchModelObj = HistorySearchModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 8));

  Rx<int> tabIndex = 0.obs;

  Rx<HistorySearchFrTabModel> historysearchfrTabModelObj =
      HistorySearchFrTabModel().obs;
}
