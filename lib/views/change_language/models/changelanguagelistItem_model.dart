import 'package:kiwis_flutter/core/app_export.dart';

class ChangelanguagelistItemModel {
  ChangelanguagelistItemModel({
    this.allRegion,
    this.yourLocation,
    this.id,
  }) {
    allRegion = allRegion ?? Rx("Vietnamese");
    yourLocation = yourLocation ?? Rx("Your Location");
    id = id ?? Rx("1");
  }

  Rx<String>? allRegion;

  Rx<String>? yourLocation;

  Rx<String>? id;
}
