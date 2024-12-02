import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/explore_location_main/models/post_list_item.model.dart';

class ExploreLocationMainModel {
  Rx<List<PostListItemModel>> postListItemModels = Rx<List<PostListItemModel>>([
    PostListItemModel(),
    PostListItemModel(),
    PostListItemModel(),
    PostListItemModel(),
  ]);
}
