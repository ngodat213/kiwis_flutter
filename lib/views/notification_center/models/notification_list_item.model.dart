import 'package:kiwis_flutter/core/constants/app_export.dart';

class NotificationListItemModel {
  NotificationListItemModel({this.title, this.london, this.text, this.id}) {
    title = title ?? Rx("title");
    london = london ?? Rx("london");
    text = text ?? Rx("text");
    id = id ?? Rx("id");
  }

  Rx<String>? title;
  Rx<String>? london;
  Rx<String>? text;
  Rx<String>? id;
}
