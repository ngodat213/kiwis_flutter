import 'package:kiwis_flutter/core/app_export.dart';

class DetailPostListItemModel {
  DetailPostListItemModel(
      {this.date, this.foridaNessi, this.description, this.id}) {
    date = date ?? Rx("date");
    foridaNessi = foridaNessi ?? Rx("foridaNessi");
    description = description ?? Rx("description");
    id = id ?? Rx("id");
  }

  Rx<String>? date;
  Rx<String>? foridaNessi;
  Rx<String>? description;
  Rx<String>? id;
}
