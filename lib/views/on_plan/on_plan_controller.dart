import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/post.model.dart';
import 'package:kiwis_flutter/models/task.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/requests/upload_realtime.request.dart';
import 'package:kiwis_flutter/services/geolocator.service.dart';
import 'package:kiwis_flutter/services/map.service.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/views/on_plan/widgets/camera.content.dart';
import 'package:kiwis_flutter/views/on_plan/widgets/contact.content.dart';
import 'package:kiwis_flutter/views/on_plan/widgets/schedule.content.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart'
    as vietMapFlg;
import 'package:camera/camera.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class OnPlanController extends BaseController {
  final PlanRequest _planRequest = PlanRequest();
  final UploadRealtimeRequest _uploadRealtimeRequest = UploadRealtimeRequest();

  late CameraController cameraController;

  final RxBool isCameraInitialized = false.obs;
  final Rx<DateTime> taskDate = Rx<DateTime>(DateTime.now());
  final RxList<TaskModel> tasks = RxList<TaskModel>([]);
  final RxBool isFlashOn = false.obs;
  final RxBool onPost = false.obs;
  final Rx<XFile> imageXFile = XFile('').obs;
  final TextEditingController captionTEC = TextEditingController();

  MyLocationTrackingMode myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;
  final mapService = MapService.to;
  final geoService = GeolocatorService.to;
  final Rxn<UserModel> currentUser = Rxn<UserModel>(null);
  final Rxn<PlanModel> currentPlan = Rxn<PlanModel>(null);
  final Rxn<TaskModel> currentTask = Rxn<TaskModel>(null);
  final RxList<Contact> listContacts = RxList<Contact>([]);
  String? argPlanId;
  final RxBool onTracking = false.obs;
  final RxInt currentTaskIndex = 0.obs;
  final RxBool isShowDialog = false.obs;

  @override
  void onInit() async {
    super.onInit();
    argPlanId = Get.arguments;
    await getPlan();
    await _fetchContacts();
    currentUser.value = await AuthServices.getCurrentUser();
    initCamera();
  }

  @override
  void onClose() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    captionTEC.dispose();
    super.onClose();
  }

  RxBool get isCreatedTask =>
      (currentPlan.value!.createdById == currentUser.value!.userId).obs;

  RxBool get isLastLocation =>
      (currentTaskIndex.value == currentPlan.value!.tasks!.length - 1).obs;

  RxBool get isLastTask =>
      (currentTaskIndex.value == currentPlan.value!.tasks!.length - 1).obs;

  Future<void> showSchedule(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) => ScheduleContent(),
    );
  }

  void showContact(BuildContext context) {
    Get.dialog(
      ContactContent(),
    );
  }

  Future<void> onTapTask(TaskModel task) async {
    currentTask.value = task;
    currentTaskIndex.value = currentPlan.value!.tasks!.indexOf(task);
    if (currentTask.value?.planLocation != null) {
      await drawLine();
    }
    print('onTapTask: ${currentTaskIndex.value}');
  }

  void getTasksByDate(DateTime date) {
    taskDate.value = date;
    var allTasks = currentPlan.value?.tasks ?? [];

    tasks.value = allTasks.where((task) {
      DateTime? startDate =
          task.startDate != null ? DateTime.tryParse(task.startDate!) : null;
      DateTime? endDate =
          task.endDate != null ? DateTime.tryParse(task.endDate!) : null;

      if (startDate == null || endDate == null) return false;

      DateTime startDay =
          DateTime(startDate.year, startDate.month, startDate.day);
      DateTime endDay = DateTime(endDate.year, endDate.month, endDate.day);
      DateTime targetDay = DateTime(date.year, date.month, date.day);

      return targetDay.isAtSameMomentAs(startDay) ||
          targetDay.isAtSameMomentAs(endDay) ||
          (targetDay.isAfter(startDay) && targetDay.isBefore(endDay));
    }).toList();
    tasks.refresh();
  }

  Future<void> getPlan() async {
    try {
      final plan = await _planRequest.findPlanById(argPlanId!);
      if (plan.allGood) {
        currentPlan.value = PlanModel.fromJson(plan.body);
        currentTask.value = currentPlan.value!.tasks![currentTaskIndex.value];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> nextLocation() async {
    if (currentTaskIndex.value < currentPlan.value!.tasks!.length - 1) {
      currentTaskIndex.value++;
      await drawLine();
    }
  }

  void openCamera() {
    Get.dialog(
      CameraContent(),
    );
  }

  Future<void> _fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);
      listContacts.value = contacts;
    }
  }
  // Future<void> finishLocation() async {
  //   final plan =
  //       await _planRequest.updatePlanById(argPlanId!, currentPlan.value!);
  //   if (plan.allGood) {
  //     currentPlan.value = PlanModel.fromJson(plan.body);
  //   }
  // }

  Future<void> drawLine() async {
    if (currentTask.value?.planLocation != null) {
      await mapService.drawTripPolyLine(
        vietMapFlg.LatLng(
          geoService.currentPosition.value!.latitude,
          geoService.currentPosition.value!.longitude,
        ),
        vietMapFlg.LatLng(
          currentTask.value!.planLocation!.latitude!,
          currentTask.value!.planLocation!.longitude!,
        ),
      );
    }
  }

  // Future<void> updatePlan() async {
  //   final plan =
  //       await _planRequest.updatePlanById(argPlanId!, currentPlan.value!);
  //   if (plan.allGood) {
  //     currentPlan.value = PlanModel.fromJson(plan.body);
  //   }
  // }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      await cameraController.initialize();
      isCameraInitialized.value = true;
    }
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    cameraController.setFlashMode(
      isFlashOn.value ? FlashMode.torch : FlashMode.off,
    );
  }

  void toggleRotate() async {
    final cameras = await availableCameras();
    final newCamera =
        cameraController.description == cameras[0] ? cameras[1] : cameras[0];

    await cameraController.dispose();
    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
    );
    await cameraController.initialize();
  }

  Future<void> takePicture() async {
    if (!isCameraInitialized.value) return;

    final image = await cameraController.takePicture();
    imageXFile.value = image;
    onPost.value = true;
  }

  void closeOnPost() {
    onPost.value = false;
    imageXFile.value = XFile('');
    captionTEC.clear();
  }

  Future<void> handlePost(BuildContext context) async {
    try {
      if (imageXFile.value.path.isNotEmpty) {
        final response = await _uploadRealtimeRequest.uploadRealtimeRequest(
          file: imageXFile.value,
          caption: captionTEC.text,
        );
        if (response.allGood) {
          Get.snackbar("Success", "Post created successfully");
          captionTEC.clear();
          onPost.value = false;

          final PostModel post = PostModel.fromJson(response.body);
          final homeController = Get.find<HomeController>();
          homeController.posts.value.insert(0, post);
          homeController.posts.refresh();

          ManagerSocket.sendPost(
            postId: post.realtimePostId!,
          );
        } else {
          Get.snackbar("Kiwis", response.message ?? "Something went wrong");
        }
      }
    } catch (err) {
      print(err);
      // Get.snackbar("Kiwis", err.toString());
    }
  }
}
