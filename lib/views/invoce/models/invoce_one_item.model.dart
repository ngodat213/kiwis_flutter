import 'package:kiwis_flutter/core/constants/app_export.dart';

class InvoceOneItemModel {
  InvoceOneItemModel(
      {this.transportOne, this.transportTwo, this.text, this.id}) {
    transportOne = transportOne ?? Rx("buttontinyFour");
    transportTwo = transportTwo ?? Rx("buttontinyFour1");
    text = text ?? Rx("1");
    id = id ?? Rx("1");
  }

  Rx<String>? transportOne;
  Rx<String>? transportTwo;
  Rx<String>? text;
  Rx<String>? id;
}
