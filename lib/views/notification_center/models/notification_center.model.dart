import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/views/notification_center/models/notification_list_item.model.dart';

class NotificationCenterModel {
  Rx<List<NotificationListItemModel>> notificationListItemList =
      Rx<List<NotificationListItemModel>>([
        NotificationListItemModel(),
        NotificationListItemModel(),
        NotificationListItemModel(),
      ]);
}
