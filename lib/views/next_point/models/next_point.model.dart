import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/next_point/models/chip_view_4_item.model.dart';

class NextPointModel {
  Rx<List<ChipView4ItemModel>> chipView4ItemList =
      Rx<List<ChipView4ItemModel>>([
    ChipView4ItemModel(buttontinyFour: "River".obs),
    ChipView4ItemModel(buttontinyFour: "Lake".obs),
    ChipView4ItemModel(buttontinyFour: "Place".obs),
    ChipView4ItemModel(buttontinyFour: "Cafe".obs),
  ]);
}
