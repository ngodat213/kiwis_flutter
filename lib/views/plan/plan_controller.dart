import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/controllers/location_search.controller.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app.theme_helper.dart';
import 'package:kiwis_flutter/models/address.model.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/models/task.model.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/requests/task.request.dart';
import 'package:kiwis_flutter/views/plan/widgets/add_task.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/addlocation.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/choose_location.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_create.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_detail.content.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class PlanController extends BaseController {
  /// Request
  final ImagePicker _imagePicker = ImagePicker();
  final PlanRequest _planRequest = PlanRequest();
  final TaskRequest _taskRequest = TaskRequest();

  /// Controller
  final TextEditingController locationNameTEC = TextEditingController();
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController budgetTEC = TextEditingController();
  final TextEditingController estimatedCostTEC = TextEditingController();
  final TextEditingController estimatedTimeTEC = TextEditingController();
  final TextEditingController taskTitleTEC = TextEditingController();
  final TextEditingController taskDescriptionTEC = TextEditingController();
  final TextEditingController taskBudgetTEC = TextEditingController();

  /// Variables
  Rx<DateTime> taskDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> taskStartTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> taskEndTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> startDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime?> focusedDay = Rx<DateTime?>(DateTime.now());
  Rx<PlanModel?> currentPlan = Rxn<PlanModel?>();
  Rx<PlanLocationModel?> planLocationChanged = Rxn<PlanLocationModel?>();
  Rxn<AddressModel?> currentLocation = Rxn<AddressModel?>();
  RxList<PlanModel> plans = <PlanModel>[].obs;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<AddressModel> locations = <AddressModel>[].obs;
  Rx<File?> imageFile = Rxn<File?>();
  RxInt currentStep = 0.obs;
  String? argGroupId;
  List<Widget> steps = [TimeWidget(), DetailWidget(), EnjoyWidget()];

  @override
  void onInit() {
    super.onInit();
    argGroupId = Get.arguments;
    initPlans();
  }

  /// Add task content
  Future<void> createTask() async {
    try {
      if (taskTitleTEC.text.isNotEmpty) {
        var response = await _taskRequest.createTask(
          planId: currentPlan.value!.planId!,
          title: taskTitleTEC.text,
          description: taskDescriptionTEC.text,
          budget: taskBudgetTEC.text,
          startDate: taskDate.value,
          endDate: taskEndTime.value,
          locationName: currentLocation.value?.name,
          latitude: currentLocation.value?.coordinates?.latitude,
          longitude: currentLocation.value?.coordinates?.longitude,
          address: currentLocation.value?.address,
          estimatedCost: int.parse(estimatedCostTEC.text),
          estimatedTime: int.parse(estimatedTimeTEC.text),
        );
        if (response.allGood) {
          final task = TaskModel.fromJson(response.body);
          currentPlan.value?.tasks?.add(task);
          currentPlan.refresh();

          Get.snackbar("Success", "Task created successfully");
        } else {
          Get.snackbar("Kiwis", response.message ?? "Something went wrong");
        }
      } else {
        Get.snackbar("Kiwis", "Please fill all fields");
      }
    } catch (e) {
      print(e);
    } finally {
      taskTitleTEC.clear();
      taskDescriptionTEC.clear();
      taskBudgetTEC.clear();
      taskDate.value = DateTime.now();
      taskEndTime.value = DateTime.now();
    }
  }

  void getTasksByDate(DateTime date) {
    taskDate.value = date;
    var allTasks = currentPlan.value?.tasks ?? [];

    // Lọc các task có ngày bao gồm ngày được chỉ định
    tasks.value = allTasks.where((task) {
      // Chuyển đổi startDate và endDate từ String sang DateTime
      DateTime? startDate =
          task.startDate != null ? DateTime.tryParse(task.startDate!) : null;
      DateTime? endDate =
          task.endDate != null ? DateTime.tryParse(task.endDate!) : null;

      // Nếu không thể chuyển đổi hoặc thiếu thông tin, bỏ qua task này
      if (startDate == null || endDate == null) return false;

      // Lấy phần ngày, bỏ qua thời gian
      DateTime startDay =
          DateTime(startDate.year, startDate.month, startDate.day);
      DateTime endDay = DateTime(endDate.year, endDate.month, endDate.day);
      DateTime targetDay = DateTime(date.year, date.month, date.day);

      // Kiểm tra nếu targetDay nằm trong khoảng từ startDay đến endDay
      return targetDay.isAtSameMomentAs(startDay) ||
          targetDay.isAtSameMomentAs(endDay) ||
          (targetDay.isAfter(startDay) && targetDay.isBefore(endDay));
    }).toList();
    tasks.refresh();
  }

  Future<void> onPressedDeleteTask(BuildContext context, String taskId) async {
    try {
      var response = await _taskRequest.deleteTask(taskId: taskId);
      if (response.allGood) {
        tasks.removeWhere((task) => task.taskId == taskId);
        tasks.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  /// Chat room methods
  Future<void> pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile.value = File(image.path);
    }
  }

  Future<void> onTapEditPlan(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanCreateContent(
        isEdit: true,
        plan: currentPlan.value!,
      ),
    );
  }

  Future<void> editPlan(BuildContext context) async {
    try {
      var response = await _planRequest.updatePlanById(
        currentPlan.value!.planId!,
        PlanModel(
          name: titleTEC.text,
          totalCost: int.parse(budgetTEC.text),
          startDate: startDay.value,
          endDate: endDay.value,
        ),
      );
      if (response.allGood) {
        titleTEC.clear();
        descriptionTEC.clear();
        budgetTEC.clear();
        startDay.value = DateTime.now();
        endDay.value = DateTime.now();

        plans[plans.indexWhere((p) => p.planId == currentPlan.value!.planId)] =
            PlanModel.fromJson(response.body);
        plans.refresh();
        Get.back();
        Get.snackbar("Success", "Plan updated successfully");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> changeCurrentLocation() async {
    if (currentLocation.value?.name == null ||
        currentLocation.value?.coordinates == null ||
        estimatedCostTEC.text.isEmpty ||
        estimatedTimeTEC.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    final PlanLocationModel location = PlanLocationModel(
      name: currentLocation.value!.name,
      latitude: currentLocation.value!.coordinates!.latitude,
      longitude: currentLocation.value!.coordinates!.longitude,
      address: currentLocation.value!.address ?? "",
      estimatedCost: int.parse(estimatedCostTEC.text),
      estimatedTime: int.parse(estimatedTimeTEC.text),
    );

    planLocationChanged.value = location;
    Get.back();
    Get.back();
  }

  void onPressChooseLocation(BuildContext context) {
    if (currentLocation.value == null) {
      Get.snackbar("Error", "Please select a location first");
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddLocationContent(),
      ),
    );
  }

  addressSelected(AddressModel address) async {
    currentLocation.value = address;
    if (address.coordinates != null) {
      LocationSearchController.to.selectLocation(address);
    }
  }

  // Lưu vị trí được chọn
  var selectedPosition = Rxn<LatLng>(LatLng(0.00, 0.00));

  void saveSelectedLocation() {
    if (selectedPosition.value != null) {
      // Xử lý logic lưu vị trí
      print("Saved location: ${selectedPosition.value}");
    } else {
      print("No location selected");
    }
  }

  void createLocationPlan(BuildContext context) {
    if (selectedPosition.value != null) {
      // Gửi dữ liệu vị trí đến server hoặc xử lý tiếp
      print("Creating plan with location: ${selectedPosition.value}");
    } else {
      Get.snackbar("Error", "Please select a location first");
    }
  }

  // --------------------------- PLAN ------------------------------
  Future<void> initPlans() async {
    try {
      final ApiResponse response;
      if (argGroupId != null) {
        response = await _planRequest.getPlanByGroupId(argGroupId!);
      } else {
        response = await _planRequest.getPlanRequest();
      }
      if (response.allGood) {
        for (var e in response.body) {
          plans.add(PlanModel.fromJson(e));
        }
      }
      print(plans.length);
    } catch (e) {
      print(e);
    }
  }

  Future<void> toOnPlan() async {
    Get.toNamed(Routes.ON_PLAN, arguments: currentPlan.value!.planId);
  }

  /// Plan cotent
  Future<void> onPressedPlanDetail(BuildContext context, PlanModel plan) async {
    currentPlan.value = plan;
    getTasksByDate(currentPlan.value!.startDate!);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanDetailContent(),
    );
  }

  void onPressedChooseLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => ChooseLocationContent(),
    );
  }

  void onPressedAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddTaskContent(),
    );
  }

  Future<void> createPlan() async {
    try {
      if (currentStep.value == 1) {
        if (titleTEC.text.isEmpty ||
            descriptionTEC.text.isEmpty ||
            budgetTEC.text.isEmpty) {
          Get.snackbar("Error", "Please fill all fields");
          return;
        }
        var response = await _planRequest.createPlan(
          title: titleTEC.text,
          description: descriptionTEC.text,
          budget: budgetTEC.text,
          startDay: startDay.value,
          endDay: endDay.value,
          groupId: argGroupId,
          image: imageFile.value?.readAsBytesSync(),
        );

        if (response.allGood) {
          titleTEC.clear();
          descriptionTEC.clear();
          budgetTEC.clear();
          startDay.value = DateTime.now();
          endDay.value = DateTime.now();
          plans.add(PlanModel.fromJson(response.body));
          Get.snackbar("Success", "Plan created successfully");
          currentStep.value++;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void onTapCreatePlan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanCreateContent(),
    );
  }
}
