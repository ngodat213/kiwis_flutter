import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/group_controller.dart';

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupController>(
      () => GroupController(),
    );
  }
}
