import 'package:kiwis_flutter/core/constants/app_export.dart';

class ListSectionItemModel {
  ListSectionItemModel(
      {this.thainlandTwo,
      this.reviews,
      this.reviewsCounter,
      this.text,
      this.id}) {
    thainlandTwo = thainlandTwo ?? Rx("buttontinyFour");
    reviews = reviews ?? Rx("buttontinyFour1");
    reviewsCounter = reviewsCounter ?? Rx("1");
    text = text ?? Rx("1");
    id = id ?? Rx("1");
  }
  Rx<String>? thainlandTwo;
  Rx<String>? reviews;
  Rx<String>? reviewsCounter;
  Rx<String>? text;
  Rx<String>? id;
}
