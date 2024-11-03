import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/views/menu/menu_controller.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';

import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<MessageController>(MessageController());
    Get.put<HomeController>(HomeController());
    Get.put<MenuController>(MenuController());
  }
}
