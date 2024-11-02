import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/detail_post/detail_post_controller.dart';
import 'package:kiwis_flutter/views/detail_post/widgets/detail_post_content.dart';

class DetailPostScreen extends BaseView<DetailPostController> {
  DetailPostScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return DetailPostContent(
      detailPostModelObj: controller.detailPostModelObj,
    );
  }
}
