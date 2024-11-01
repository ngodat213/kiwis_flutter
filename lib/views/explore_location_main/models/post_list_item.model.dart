import 'package:kiwis_flutter/core/app_export.dart';

class PostListItemModel {
  PostListItemModel(
      {this.postInOne,
      this.postInTwo,
      this.greenwich,
      this.interfaceOne,
      this.text,
      this.id}) {
    postInOne = postInOne ?? Rx("postInOne");
    postInTwo = postInTwo ?? Rx("postInTwo");
    greenwich = greenwich ?? Rx("greenwich");
    text = text ?? Rx("text");
    interfaceOne = interfaceOne ?? Rx("interfaceOne");
    id = id ?? Rx("id");
  }

  Rx<String>? postInOne;
  Rx<String>? postInTwo;
  Rx<String>? greenwich;
  Rx<String>? text;
  Rx<String>? interfaceOne;
  Rx<String>? id;
}
