import 'package:kiwis_flutter/core/constants/app_export.dart';

class DetailPostListItemModel {
  DetailPostListItemModel(
      {this.date, this.foridaNessi, this.description, this.id}) {
    date = date ?? Rx("26/10/2003");
    foridaNessi = foridaNessi ?? Rx("Ngô Văn Tiến Đạt");
    description = description ??
        Rx("Nostrud enim enim elit duis dolore eu adipisicing sunt ex exercitation minim aliqua.");
    id = id ?? Rx("id");
  }

  Rx<String>? date;
  Rx<String>? foridaNessi;
  Rx<String>? description;
  Rx<String>? id;
}
