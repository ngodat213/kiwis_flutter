// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/widgets/widgets.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});
  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(12, 11, 64, 0.8), // rgba(12,11,64,1) at 0%
                  Color.fromRGBO(0, 0, 0, 1), // rgba(0,0,0,1) at 16%
                  Color.fromRGBO(0, 0, 0, 1), // rgba(0,0,0,1) at 86%
                  Color.fromRGBO(9, 23, 9, 1), // rgba(9,23,9,1) at 94%
                  Color.fromRGBO(15, 55, 13, 1), // rgba(15,55,13,1) at 100%
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  // 0.06,
                  0.16,
                  0.86,
                  0.94,
                  1.0
                ], // Tỷ lệ tương ứng của màu
              ),
            ),
          ),
          // GlassContainer.clearGlass(),
          // Column(
          //   children: [
          //     ImagePost(),
          //   ],
          // ),
        ],
      ).wh(Get.width, Get.height),
    );
  }
}

class ImagePost extends StatelessWidget {
  const ImagePost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContainerImage(
          width: Get.width - 32,
          height: Get.width - 32,
          borderRadius: BorderRadius.circular(18),
          fit: BoxFit.cover,
          imageUrl: 'https://wallpapercave.com/wp/wp12184623.jpg',
        ),
        HStack(
          [
            ContainerImage(
              width: Get.width * 0.11,
              height: Get.width * 0.11,
              borderRadius: BorderRadius.circular(10),
              fit: BoxFit.cover,
              imageUrl: 'https://wallpapercave.com/wp/wp12184623.jpg',
            ).marginOnly(right: 8),
            VStack(
              [
                'Hydra Coder'.text.make(),
                'ratatata'.text.make(),
              ],
            ),
            Spacer(),
            Icon(Icons.more_vert)
          ],
        ).marginAll(16),
        Positioned(
          bottom: 16,
          child: Center(
            child: GlassContainer.clearGlass(
              width: Get.width - 64,
              height: Get.height * 0.06,
              borderRadius: BorderRadius.circular(32),
              child: HStack([
                IconAction(
                  icon: Icon(Icons.favorite_border_rounded),
                  text: '1k',
                ),
                Spacer(),
                IconAction(
                  icon: Icon(Icons.message_outlined),
                  text: '1k',
                ),
                Spacer(),
                IconAction(
                  icon: Icon(Icons.send_outlined),
                  text: '',
                ),
                IconAction(
                  icon: Icon(Icons.bookmark_outline_rounded),
                  text: '',
                ),
              ]).paddingSymmetric(horizontal: 24),
            ).marginSymmetric(horizontal: 16),
          ),
        )
      ],
    ).wh(Get.width - 32, Get.width - 32).centered();
  }
}

class IconAction extends StatelessWidget {
  const IconAction({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        icon,
        text.text.make(),
      ],
    ).marginOnly(right: 8);
  }
}
