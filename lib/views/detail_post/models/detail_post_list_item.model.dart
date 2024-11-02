import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/views/detail_post/models/detail_post.model.dart';

class DetailPostModel {
  Rx<List<DetailPostListItemModel>> detailpostlistItemList =
      Rx<List<DetailPostListItemModel>>([
    DetailPostListItemModel(),
    DetailPostListItemModel(),
    DetailPostListItemModel(),
    DetailPostListItemModel(),
  ]);
}
