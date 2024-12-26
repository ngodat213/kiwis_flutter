import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/friend_data.model.dart';
import 'package:kiwis_flutter/models/friendship.model.dart';
import 'package:kiwis_flutter/models/post.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/auth.request.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/requests/upload_realtime.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/home/widgets/account.content.dart';
import 'package:kiwis_flutter/views/home/widgets/change_name.content.dart';
import 'package:kiwis_flutter/views/home/widgets/change_password.content.dart';
import 'package:kiwis_flutter/views/home/widgets/delete_account.content.dart';
import 'package:kiwis_flutter/views/home/widgets/menu_content.dart';
import 'package:kiwis_flutter/views/home/widgets/friend_content.dart';
import 'package:image/image.dart' as img;
import 'package:kiwis_flutter/views/message/message_controller.dart';

class HomeController extends BaseController with GetTickerProviderStateMixin {
  /// Variables
  final ImagePicker _imagePicker = ImagePicker();
  final AuthRequest _authRequest = AuthRequest();
  final UserRequest _userRequest = UserRequest();
  final UploadRealtimeRequest _uploadRealtimeRequest = UploadRealtimeRequest();

  // Home content variables
  late CameraController cameraController;
  late TabController tabController;
  final ConfettiController confettiController = ConfettiController();
  final TextEditingController commentTEC = TextEditingController();
  final TextEditingController captionTEC = TextEditingController();
  final TextEditingController firstNameTEC = TextEditingController();
  final TextEditingController lastNameTEC = TextEditingController();
  final TextEditingController currentPasswordTEC = TextEditingController();
  final TextEditingController newPasswordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();
  final TextEditingController phoneNumberTEC = TextEditingController();

  final Rx<UserModel> user = UserModel().obs;
  final RxBool isFlashOn = false.obs;
  final RxBool isRotate = false.obs;
  final RxBool onPost = false.obs;
  final RxBool isDeleteAccount = false.obs;
  final RxBool isOnchangeAvatar = false.obs;
  final RxBool isCameraInitialized = false.obs;
  final RxInt selectedCameraIndex = 0.obs;
  final Rx<XFile> imageXFile = XFile("").obs;
  final Rx<File> avatar = File('').obs;
  final RxList<dynamic> friends = RxList<dynamic>([]);
  final RxList<FriendshipModel> friendsPending = RxList<FriendshipModel>([]);
  final RxList<PostModel> posts = RxList<PostModel>([]);
  List<CameraDescription> cameras = [];
  List<String> emojis = ['😊', '😂', '❤️', '😍', '🤔', '🔥'];

  /// Handle
  @override
  void onInit() async {
    super.onInit();
    showLoading();
    _listenPost();
    _listenAddFriend();
    _listenAcceptFriend();
    user.value = await AuthServices.getCurrentUser(force: true) ?? UserModel();
    await initializeCamera();
    await getPosts();
    await getAllFriendPending();
    tabController = TabController(length: 2, vsync: this);
    hideLoading();
  }

  @override
  void onClose() {
    commentTEC.dispose();
    captionTEC.dispose();
    firstNameTEC.dispose();
    lastNameTEC.dispose();
    currentPasswordTEC.dispose();
    newPasswordTEC.dispose();
    confirmPasswordTEC.dispose();
    phoneNumberTEC.dispose();
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    super.onClose();
  }

  Future<void> _handleCurrentUser() async {
    try {
      final apiResponse = await _userRequest.getCurrentUser();

      if (apiResponse.allGood) {
        await AuthServices.saveUser(apiResponse.body);
        user.value =
            await AuthServices.getCurrentUser(force: true) ?? UserModel();
      } else {
        throw Exception(apiResponse.error);
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  void _listenAddFriend() {
    ManagerSocket.socket?.on(AppAPI.socketReceiveFriendRequest, (data) {
      final FriendshipModel friendship = FriendshipModel.fromJson(data);
      friendsPending.value.insert(0, friendship);
      friendsPending.refresh();
    });
  }

  void _listenAcceptFriend() {
    ManagerSocket.socket?.on(AppAPI.socketAcceptFriendRequest, (data) {
      final messageController = Get.find<MessageController>();
      messageController.initGroups();
      friendsPending.value.clear();
      friendsPending.refresh();
      _handleCurrentUser();
    });
  }

  /// Home content
  void _listenPost() {
    ManagerSocket.socket?.on(AppAPI.socketReceivePost, (data) {
      final PostModel post = PostModel.fromJson(data);
      posts.value.insert(0, post);
      posts.refresh();
    });
  }

  Future<void> handlePost(BuildContext context) async {
    try {
      if (imageXFile.value.path.isNotEmpty) {
        final response = await _uploadRealtimeRequest.uploadRealtimeRequest(
          file: imageXFile.value,
          caption: captionTEC.text,
        );
        if (response.allGood) {
          captionTEC.clear();
          onPost.value = false;

          final PostModel post = PostModel.fromJson(response.body);
          posts.value.insert(0, post);
          posts.refresh();

          ManagerSocket.sendPost(
            postId: post.realtimePostId!,
          );
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
    posts.value.clear();
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

  void onPressedAccount(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AccountContent(),
    );
  }

  /// Camera

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras available.");
        return;
      }

      cameraController = CameraController(
        cameras[selectedCameraIndex.value],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      isCameraInitialized.value = false;
      print("Error initializing camera: $e");
    }
  }

  void closeOnPost() async {
    onPost.value = false;
    isFlashOn.value = false;
    await cameraController.setFlashMode(
      FlashMode.off,
    );
    imageXFile.value = XFile("");
    captionTEC.clear();
  }

  void toggleFlash() async {
    isFlashOn.value = !isFlashOn.value;
  }

  Future<void> toggleRotate() async {
    try {
      isRotate.value = !isRotate.value;
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

  Future<void> sendComment(String postId) async {
    if (commentTEC.text.isNotEmpty) {
      ManagerSocket.sendComment(
        senderId: user.value.userId!,
        postId: postId,
        messageText: commentTEC.text,
      );
      commentTEC.clear();
    }
  }

  Future<void> sendEmoji(BuildContext context, String emoji) async {
    Confetti.launch(
      context,
      options: ConfettiOptions(particleCount: 20),
      particleBuilder: (index) => Emoji(emoji: emoji),
    );
  }

  Future<void> takePicture() async {
    if (!isCameraInitialized.value) return;

    try {
      // Bật flash trước khi chụp

      if (isFlashOn.value) {
        await cameraController.setFlashMode(FlashMode.torch);
      }

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
      img.Image? flippedImage;
      if (isRotate.value) {
        flippedImage = img.flipHorizontal(image);
      }

      // Transform kích thước ảnh (ví dụ: 200x200)
      final img.Image resizedImage = img.copyResize(
        flippedImage ?? image,
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

      // Tắt flash sau khi chụp
      await cameraController.setFlashMode(FlashMode.off);
    } catch (e) {
      print("Error taking picture: $e");
      return;
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
      Get.offAndToNamed(Routes.SIGN_IN);
    } catch (err) {
      print(err);
    } finally {
      await _authRequest.logoutRequest();
      await _clearLocalStorage();
      Get.delete<HomeController>();
    }
  }

  Future<void> _clearLocalStorage() async {
    await AuthServices.setAuthBearerToken("");
    await AuthServices.setAuthFirebaseToken("");
    await AuthServices.logout();
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

  Future<void> getAllFriendPending() async {
    friendsPending.value.clear();
    try {
      final response = await _userRequest.getAllFriendPending();
      if (response.allGood) {
        for (var e in response.body) {
          friendsPending.value.add(FriendshipModel.fromJson(e));
        }
      }
      friendsPending.refresh();
    } catch (err) {
      print(err);
    }
  }

  Future<void> acceptFriend(String friendshipId) async {
    try {
      final response = await _userRequest.acceptFriendRequest(friendshipId);
      if (response.allGood) {
        friendsPending.value.removeWhere((e) => e.friendshipId == friendshipId);
        friendsPending.refresh();
        final messageController = Get.find<MessageController>();
        messageController.initGroups();
        ManagerSocket.acceptFriend(
          userId: user.value.userId!,
          receiverId: friendshipId,
        );
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> onPressedAddFriend(BuildContext context) async {
    try {
      final response = await _userRequest.addFriendRequest(phoneNumberTEC.text);
      if (response.allGood) {
        phoneNumberTEC.clear();
        ManagerSocket.sendAddFriend(
          userId: user.value.userId!,
          friendShipId: response.body['friendshipId'],
        );
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

  // Account setting content
  void handleDisplayName(BuildContext context) async {
    if (firstNameTEC.text.isEmpty || firstNameTEC.text == '') {
      AnimatedSnackBar.material(
        'First name cannot be empty'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    } else {
      final response = await _userRequest.updateDisplayName(
        firstNameTEC.text,
        lastNameTEC.text,
      );
      if (response.allGood) {
        user.value.firstName = firstNameTEC.text;
        user.value.lastName = lastNameTEC.text;
        await AuthServices.saveUser(user.value.toJson());

        firstNameTEC.clear();
        lastNameTEC.clear();
        Get.back();

        Get.snackbar(
          'Success'.tr,
          'Change name success'.tr,
          colorText: appTheme.gray50,
        );
      }
    }
  }

  Future<void> handlePassword(BuildContext context) async {
    if (currentPasswordTEC.text.isEmpty ||
        currentPasswordTEC.text == '' ||
        newPasswordTEC.text.isEmpty ||
        newPasswordTEC.text == '' ||
        confirmPasswordTEC.text.isEmpty ||
        confirmPasswordTEC.text == '') {
      AnimatedSnackBar.material(
        'Password cannot be empty'.tr,
        type: AnimatedSnackBarType.warning,
      ).show(context);
    } else {
      if (newPasswordTEC.text == currentPasswordTEC.text) {
        AnimatedSnackBar.material(
          'New password cannot be the same as the current password'.tr,
          type: AnimatedSnackBarType.warning,
        ).show(context);
      } else if (newPasswordTEC.text != confirmPasswordTEC.text) {
        AnimatedSnackBar.material(
          'New password and confirm password do not match'.tr,
          type: AnimatedSnackBarType.warning,
        ).show(context);
      } else {
        final response = await _authRequest.updatePasswordRequest(
          oldPassword: currentPasswordTEC.text,
          newPassword: newPasswordTEC.text,
          confirmPassword: confirmPasswordTEC.text,
        );
        if (response.allGood) {
          currentPasswordTEC.clear();
          newPasswordTEC.clear();
          confirmPasswordTEC.clear();
          Get.back();
          Get.snackbar(
            'Success'.tr,
            'Change password success'.tr,
            colorText: appTheme.gray50,
          );
        } else {
          Get.snackbar(
            'Error'.tr,
            response.error!,
            colorText: appTheme.gray50,
          );
        }
      }
    }
  }

  Future<void> handleDeleteAccount(BuildContext context) async {
    try {
      if (isDeleteAccount.value) {
        final response = await _authRequest.deleteAccountRequest();
        if (response.allGood) {
          await _authRequest.revokeFirebaseTokenRequest();
          await _clearLocalStorage();
          Get.offAndToNamed(Routes.SIGN_IN);
          Get.snackbar(
            'Success'.tr,
            'Delete account success'.tr,
          );
        }
      } else {
        AnimatedSnackBar.material(
          'You must agree to continue'.tr,
          type: AnimatedSnackBarType.warning,
        ).show(context);
      }
    } catch (err) {
      print(err);
      Get.toNamed(Routes.SIGN_IN);
    }
  }

  Future<void> handleChangeAvatar(BuildContext context) async {
    isOnchangeAvatar.value = false;
    try {
      if (avatar.value.path.isNotEmpty) {
        final response = await _userRequest.changeAvatarRequest(
          avatar.value.readAsBytesSync(),
        );
        if (response.allGood) {
          UserModel responseUser = UserModel.fromJson(response.body);
          user.value.avatar = responseUser.avatar;

          await AuthServices.saveUser(user.value.toJson());
          user.refresh();
          Get.snackbar(
            'Success'.tr,
            'Change avatar success'.tr,
          );
        } else {
          Get.snackbar(
            'Error'.tr,
            response.error!,
          );
        }
      }
    } catch (err) {
      print(err);
    }
  }

  /// Chat room methods
  Future<void> pickAvatar() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      avatar.value = File(image.path);
      isOnchangeAvatar.value = true;
    }
  }

  void onPressedDeleteAccountContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DeleteAccountContent(),
      ),
    );
  }

  void onPressedChangeNameContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ChangeNameContent(),
      ),
    );
  }

  void onPressedPasswordContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ChangePasswordContent(),
      ),
    );
  }

  void onPressedMyPlan() {
    Get.toNamed(Routes.PLAN);
  }
}
