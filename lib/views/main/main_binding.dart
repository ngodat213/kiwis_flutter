import 'package:get/get.dart';
import 'package:kiwis_flutter/views/expense/expense_controller.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';

import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.put<ExpenseController>(ExpenseController());
    Get.put<MessageController>(MessageController());
    Get.put<HomeController>(HomeController());
  }
}
