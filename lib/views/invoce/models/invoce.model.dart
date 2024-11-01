import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/views/invoce/models/invoce_one_item.model.dart';

class InvoceModel {
  Rx<List<InvoceOneItemModel>> invoceOneItemList =
      Rx<List<InvoceOneItemModel>>([
    InvoceOneItemModel(transportOne: "River".obs),
    InvoceOneItemModel(transportOne: "Lake".obs),
    InvoceOneItemModel(transportOne: "Place".obs),
    InvoceOneItemModel(transportOne: "Cafe".obs),
  ]);
}
