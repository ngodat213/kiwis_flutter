import 'package:get/get.dart';
import 'package:kiwis_flutter/views/notification_center/models/notification_center.model.dart';

class NotificationCenterController extends GetxController {
  Rx<NotificationCenterModel> notificationCenterModelObj =
      NotificationCenterModel().obs;
}
