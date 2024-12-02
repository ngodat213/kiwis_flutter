import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/search_post/search_post_model.dart';

class SearchPostController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<SearchPostModel> searchPostModelObj = SearchPostModel().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
