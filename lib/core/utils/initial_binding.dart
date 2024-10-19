import 'package:get/get.dart';
import 'package:kiwis_flutter/core/utils/pref.utils.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
  }
}
