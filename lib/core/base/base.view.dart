import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/enums/page_state.enum.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  // final Logger logger = BuildConfig.instance.config.logger;
  final bool isNavigationBar = false;

  BaseView({super.key});

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return isNavigationBar
        ? body(context)
        : GestureDetector(
            child: Stack(
              children: [
                annotatedRegion(context),
                Obx(() => controller.errorMessage.isNotEmpty
                    ? showErrorSnackBar(controller.errorMessage)
                    : Container()),
                Container(),
              ],
            ),
          );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: statusBarColor(),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        color: Colors.white,
        child: pageScaffold(context),
      ),
    );
  }

  Widget pageScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: appBar(context),
        //sets ios status bar color
        backgroundColor: pageBackgroundColor(),
        key: globalKey,
        floatingActionButton: floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: pageContent(context),
        bottomNavigationBar: bottomNavigationBar(),
        drawer: drawer(),
      ),
    );
  }

  Widget pageContent(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.maxFinite,
        child: Container(
          height: Get.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2005,
                height: 280.h,
                width: 274.h,
                alignment: Alignment.topRight,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2006Green600516x342,
                height: 340.h,
                width: 240.h,
                alignment: Alignment.bottomLeft,
              ),
              SingleChildScrollView(
                child: controller.pageState == PageState.LOADING
                    ? Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: appTheme.green600,
                          size: 100,
                        ),
                      )
                    : body(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
  }

  Color pageBackgroundColor() {
    return appTheme.gray50;
  }

  Color statusBarColor() {
    return appTheme.gray50;
  }

  Widget? floatingActionButton(BuildContext context) {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }
}
