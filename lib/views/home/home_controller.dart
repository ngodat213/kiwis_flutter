import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/home/widgets/menu_content.dart';

class HomeController extends BaseController {
  /// Variables
  AuthRequest _authRequest = AuthRequest();

  /// Handle
  @override
  void onInit() async {
    super.onInit();
    showLoading();
    await initializeCamera();
    hideLoading();
  }

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }

  void notificationOnPressed() {
    Get.toNamed(Routes.NOTIFICATION_CENTER);
  }

  void detailPostOnPressed() {
    Get.toNamed(Routes.DETAIL_POST);
  }

  void onPressedChangeLanguage() {
    Get.toNamed(Routes.CHANGE_LANGUAGE);
  }

  Future<void> onPressedLogout() async {
    await LocalStorageService.prefs?.clear();
    Get.to(Routes.SIGN_IN);
  }

  void onPressedMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MenuContent(),
    );
  }

  /// Camera
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  RxBool isFlashOn = false.obs;
  RxInt selectedCameraIndex = 0.obs;
  List<CameraDescription> cameras = [];

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras available.");
        return;
      }

      cameraController = CameraController(
          cameras[selectedCameraIndex.value], ResolutionPreset.high);

      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      isCameraInitialized.value = false;
      print("Error initializing camera: $e");
    }
  }

  void toggleFlash() async {
    try {
      isFlashOn.value = !isFlashOn.value;
      await cameraController.setFlashMode(
        isFlashOn.value ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      print("Error toggling flash: $e");
      isFlashOn.value = !isFlashOn.value; // Revert flash state if toggle fails
    }
  }

  Future<void> toggleRotate() async {
    try {
      isCameraInitialized.value = false;
      selectedCameraIndex.value =
          (selectedCameraIndex.value + 1) % cameras.length;

      await cameraController.dispose();

      cameraController = CameraController(
        cameras[selectedCameraIndex.value],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      print("Error switching camera: $e");
      isCameraInitialized.value = false;
    }
  }

  Future<String?> takePicture() async {
    if (!isCameraInitialized.value) return null;

    try {
      final image = await cameraController.takePicture();
      return image.path;
    } catch (e) {
      print("Error taking picture: $e");
      return null;
    }
  }
}
