import 'package:kiwis_flutter/core/constants/app_export.dart';

class ChipView4ItemModel {
  ChipView4ItemModel(
      {this.buttontinyFour, this.buttontinyFour1, this.isSelected}) {
    buttontinyFour = buttontinyFour ?? Rx("buttontinyFour");
    buttontinyFour1 = buttontinyFour1 ?? Rx("buttontinyFour1");
    isSelected = isSelected ?? Rx(false);
  }

  Rx<String>? buttontinyFour;
  Rx<String>? buttontinyFour1;
  Rx<bool>? isSelected;
}
