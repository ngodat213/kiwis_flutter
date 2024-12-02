import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/change_language/models/change_language_model.dart';

class ChangeLanguageController extends BaseController {
  Rx<ChangeLanguageModel> changeLanguageModelObj = ChangeLanguageModel().obs;
}
