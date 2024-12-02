import 'package:get/get.dart';

import 'detail_post_controller.dart';

class DetailPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPostController>(
      () => DetailPostController(),
    );
  }
}
