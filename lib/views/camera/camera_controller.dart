import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';

class TakePictureController extends BaseController {
  late CameraController cameraController;
  var isCameraInitialized = false.obs;
  RxBool isFlashOn = false.obs;
  RxInt selectedCameraIndex = 0.obs;
  List<CameraDescription> cameras = [];

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

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

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }
}
