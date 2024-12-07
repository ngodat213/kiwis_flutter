import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';

class CalenderContent extends StatelessWidget {
  const CalenderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "Calender".tr,
        actions: [
          AppbarTrailingIconbutton(
            imagePath: ImageConstant.svgCalander,
            margin: EdgeInsets.only(right: 8.h),
          ),
          AppbarTrailingIconbutton(
            imagePath: ImageConstant.svgMore,
            margin: EdgeInsets.only(right: 8.h),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
