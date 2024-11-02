import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/detail_post/models/detail_post_list_item.model.dart';

class DetailPostController extends BaseController {
  Rx<DetailPostModel> detailPostModelObj = DetailPostModel().obs;
}
