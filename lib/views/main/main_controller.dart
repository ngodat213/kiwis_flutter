import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/main/models/main_screen.model.dart';

class MainController extends BaseController {
  Rx<MainScreenModel> mainScreenModel = MainScreenModel().obs;
  RxInt currentIndex = 0.obs;
}
