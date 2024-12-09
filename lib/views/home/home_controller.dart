import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/models/post.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/requests/upload_realtime.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/home/widgets/menu_content.dart';
import 'package:kiwis_flutter/views/home/widgets/friend_content.dart';
import 'package:image/image.dart' as img;

class HomeController extends BaseController {
  /// Variables
  AuthRequest _authRequest = AuthRequest();
  UploadRealtimeRequest _uploadRealtimeRequest = UploadRealtimeRequest();
  UserRequest _userRequest = UserRequest();
  Rx<UserModel> user = UserModel().obs;

  // Home content variables
  final TextEditingController captionTEC = TextEditingController();
  final RxBool onPost = false.obs;
  final Rx<XFile> imageXFile = XFile("").obs;
  final RxList<dynamic> friends = RxList<dynamic>([]);
  final RxList<PostModel> posts = RxList<PostModel>([]);

  // Friend content variables
  final TextEditingController friendIdTEC = TextEditingController();

  /// Handle
  @override
  void onInit() async {
    super.onInit();
    showLoading();
    await initializeCamera();
    await getPosts();
    user.value = AuthServices.currentUser!;
    hideLoading();
  }

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }

  /// Home content

  Future<void> onPressedPost(BuildContext context) async {
    try {
      if (imageXFile.value.path.isNotEmpty) {
        final response = await _uploadRealtimeRequest.uploadRealtimeRequest(
          file: imageXFile.value,
          caption: captionTEC.text,
        );
        if (response.allGood) {
          captionTEC.clear();
          onPost.value = false;
        } else {
          AnimatedSnackBar.material(
            response.error!,
            type: AnimatedSnackBarType.warning,
          ).show(context);
        }
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        err.toString(),
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  Future<void> getPosts() async {
    final response = await _uploadRealtimeRequest.getRealtimeRequest();
    if (response.allGood) {
      for (var e in response.body) {
        this.posts.value.add(PostModel.fromJson(e));
      }
    }
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

  void closeOnPost() {
    onPost.value = false;
    imageXFile.value = XFile("");
    captionTEC.clear();
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

  Future<void> takePicture() async {
    if (!isCameraInitialized.value) return null;

    try {
      // Chụp ảnh và lưu vào file
      final XFile originalImage = await cameraController.takePicture();
      final File originalFile = File(originalImage.path);

      // Đọc ảnh gốc
      final img.Image? image = img.decodeImage(originalFile.readAsBytesSync());
      if (image == null) {
        print("Không thể đọc ảnh.");
        return;
      }

      // Lật ảnh theo chiều ngang
      final img.Image flippedImage = img.flipHorizontal(image);

      // Transform kích thước ảnh (ví dụ: 200x200)
      final img.Image resizedImage = img.copyResize(
        flippedImage,
        width: 200,
        height: 200,
      );

      // Ghi ảnh đã resize ra file mới (hoặc ghi đè file gốc)
      final String resizedPath =
          originalFile.path.replaceFirst('.jpg', '_resized.jpg');
      final File resizedFile = File(resizedPath)
        ..writeAsBytesSync(img.encodeJpg(resizedImage));

      // Cập nhật giá trị imageXFile
      imageXFile.value = XFile(resizedFile.path);
      onPost.value = true;
    } catch (e) {
      print("Error taking picture: $e");
      return null;
    }
  }

  // Menu content

  void notificationOnPressed() {
    Get.toNamed(Routes.NOTIFICATION_CENTER);
  }

  void detailPostOnPressed() {
    Get.toNamed(Routes.DETAIL_POST);
  }

  void onPressedChangeLanguage() {
    Get.toNamed(Routes.CHANGE_LANGUAGE);
  }

  Future<void> onPressedLogout(BuildContext context) async {
    try {
      await _authRequest.revokeFirebaseTokenRequest();
      await _clearLocalStorage();
      Get.offAndToNamed(Routes.SIGN_IN);
    } catch (err) {
      print(err);
      Get.offAndToNamed(Routes.SIGN_IN);
    }
  }

  Future<void> _clearLocalStorage() async {
    await LocalStorageService.prefs?.clear();
    await AuthServices.setAuthBearerToken("");
    await AuthServices.setAuthFirebaseToken("");
    await AuthServices.firstTimeOnApp();
    await AuthServices.isAuthenticated(force: false);
  }

  /// Friend content

  void onPressedFriend(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FriendContent(),
    );
  }

  Future<void> getAllFriendsRequest() async {
    try {
      final response = await _userRequest.getAllFriendsRequest();
      if (response.allGood) {
        friends.value = response.data;
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> onPressedAddFriend(BuildContext context) async {
    try {
      final response = await _userRequest.addFriendRequest(friendIdTEC.text);
      if (response.allGood) {
        friendIdTEC.clear();
        AnimatedSnackBar.material(
          'Add friend success'.tr,
          type: AnimatedSnackBarType.success,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          response.error!,
          type: AnimatedSnackBarType.warning,
        ).show(context);
      }
    } catch (err) {
      print(err);
      AnimatedSnackBar.material(
        'Add friend error'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    }
  }

  void onPressedMyPlan() {
    Get.toNamed(Routes.PLAN);
  }
}
