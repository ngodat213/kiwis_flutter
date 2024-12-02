import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/explore_location_main/models/explore_location_main.model.dart';

class ExploreLocationMainController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<ExploreLocationMainModel> exploreLocationMainModelObj =
      ExploreLocationMainModel().obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchController.dispose();
  }
}
