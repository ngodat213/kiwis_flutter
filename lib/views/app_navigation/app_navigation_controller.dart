import 'package:get/get.dart';
import 'package:kiwis_flutter/views/app_navigation/app_navigation_model.dart';

class AppNavigationController extends GetxController {
  Rx<AppNavigationModel> appNavigationModelObj = AppNavigationModel().obs;
}
