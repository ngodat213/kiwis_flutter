import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/app/routes/app_pages.dart';
import 'package:kiwis_flutter/controllers/location_search.controller.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/enums/share_with.enum.dart';
import 'package:kiwis_flutter/models/address.model.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/models/cost.model.dart';
import 'package:kiwis_flutter/models/member.model.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/models/task.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/models/individual_shares.model.dart';
import 'package:kiwis_flutter/requests/cost.request.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/requests/task.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/services/socket.service.dart';
import 'package:kiwis_flutter/views/plan/widgets/add_expense.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/add_task.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/addlocation.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/choose_location.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_create.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_detail.content.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class PlanController extends BaseController with GetTickerProviderStateMixin {
  /// Request
  final ImagePicker _imagePicker = ImagePicker();
  final PlanRequest _planRequest = PlanRequest();
  final TaskRequest _taskRequest = TaskRequest();
  final CostRequest _costRequest = CostRequest();

  /// Controller
  late TabController tabController;
  late TabController detailTabController;
  final TextEditingController locationNameTEC = TextEditingController();
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController budgetTEC = TextEditingController();
  final TextEditingController estimatedCostTEC = TextEditingController();
  final TextEditingController estimatedTimeTEC = TextEditingController();
  final TextEditingController taskTitleTEC = TextEditingController();
  final TextEditingController taskDescriptionTEC = TextEditingController();
  final TextEditingController taskBudgetTEC = TextEditingController();

  final TextEditingController expenseTitleTEC = TextEditingController();
  final TextEditingController expenseDescriptionTEC = TextEditingController();
  final TextEditingController expenseBudgetTEC = TextEditingController();

  /// Variables
  Rx<DateTime> taskDate = Rx<DateTime>(DateTime.now());
  Rx<DateTime> taskStartTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> taskEndTime = Rx<DateTime>(DateTime.now());
  Rx<DateTime> startDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime?> focusedDay = Rx<DateTime?>(DateTime.now());
  Rxn<TaskModel?> currentTask = Rxn<TaskModel?>();
  Rx<PlanLocationModel?> planLocationChanged = Rxn<PlanLocationModel?>();
  Rxn<AddressModel?> currentLocation = Rxn<AddressModel?>();
  RxList<AddressModel> locations = <AddressModel>[].obs;
  RxList<MemberModel> selectedShareCosts = <MemberModel>[].obs;
  RxList<IndividualSharesModel> individualShares =
      <IndividualSharesModel>[].obs;
  RxList<MemberModel> userPlans = <MemberModel>[].obs;
  Rx<File?> imageFile = Rxn<File?>();
  RxInt currentStep = 0.obs;
  RxBool isEvenlyShared = true.obs;
  String? argGroupId;
  Rx<UserModel?> currentUser = Rxn<UserModel?>();
  List<Widget> steps = [TimeWidget(), DetailWidget(), EnjoyWidget()];

  @override
  void onInit() async {
    super.onInit();
    showLoading();
    argGroupId = Get.arguments;
    currentUser.value = await AuthServices.getCurrentUser();
    tabController = TabController(length: 2, vsync: this);
    detailTabController = TabController(length: 3, vsync: this);
    hideLoading();
  }

  void showDialog(Widget child) {
    Get.dialog(child);
  }

  void toggleShareType(bool value) {
    isEvenlyShared.value = value;

    if (value) {
      individualShares.clear();
    }
  }

  Future<void> pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile.value = File(image.path);
    }
  }

  Future<void> showContentEditPlan(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanCreateContent(
        isEdit: true,
        plan: SocketService.currentPlan.value,
      ),
    );
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

  addressSelected(AddressModel address) async {
    currentLocation.value = address;
    if (address.coordinates != null) {
      LocationSearchController.to.selectLocation(address);
    }
  }

  void onPressedAddRomveFriend(MemberModel friend) {
    if (selectedShareCosts.contains(friend)) {
      selectedShareCosts.remove(friend);
    } else {
      selectedShareCosts.add(friend);
    }
    selectedShareCosts.refresh();
  }

  /// Show content
  Future<void> showContentPlanDetail(
      BuildContext context, PlanModel plan) async {
    SocketService.currentPlan.value = plan;
    SocketService.getTasksByDate(null);
    SocketService.getCostSharingByDate(null);
    getUserPlans();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanDetailContent(),
    );
  }

  void showContentChooseLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => ChooseLocationContent(),
    );
  }

  void showContentAddTask(BuildContext context, {TaskModel? task}) {
    currentTask.value = task;
    taskTitleTEC.text = task?.title ?? "";
    taskDescriptionTEC.text = task?.description ?? "";
    taskBudgetTEC.text = task != null ? task.totalCost.toString() : "";
    taskStartTime.value = SocketService.currentPlan.value.startDate!;
    taskEndTime.value = taskStartTime.value;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddTaskContent(task: task),
    );
  }

  void showContentAddExpense(BuildContext context, {TaskModel? task}) {
    currentTask.value = task;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddExpenseContent(),
    );
  }

  void showContentAddLocation(BuildContext context) {
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

  void showContentCreatePlan(BuildContext context, {bool isEdit = false}) {
    if (isEdit) {
      currentStep.value = 0;
      startDay.value = SocketService.currentPlan.value.startDate!;
      endDay.value = SocketService.currentPlan.value.endDate!;
      titleTEC.text = SocketService.currentPlan.value.name!;
      descriptionTEC.text = SocketService.currentPlan.value.description!;
      budgetTEC.text = SocketService.currentPlan.value.totalCost.toString();
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => PlanCreateContent(
        isEdit: isEdit,
        plan: SocketService.currentPlan.value,
      ),
    );
  }

  /// Handle
  // Future<void> handleInitPlans() async {
  //   plans.value.clear();
  //   try {
  //     final ApiResponse response;
  //     if (argGroupId != null) {
  //       response = await _planRequest.getPlanByGroupId(argGroupId!);
  //     } else {
  //       response = await _planRequest.getPlanRequest();
  //     }
  //     if (response.allGood) {
  //       for (var e in response.body) {
  //         plans.value.add(PlanModel.fromJson(e));
  //         plans.refresh();
  //       }
  //     }
  //     print(plans.length);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void getUserPlans() {
    try {
      if (SocketService.currentPlan.value.groupId != null) {
        SocketService.currentPlan.value.group?.members?.forEach((member) {
          userPlans.add(member);
        });
        userPlans.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleRefreshCurrentPlan() async {
    var response =
        await _planRequest.getPlanById(SocketService.currentPlan.value.planId!);
    if (response.allGood) {
      SocketService.currentPlan.value = PlanModel.fromJson(response.body);
      SocketService.currentPlan.refresh();
    }
  }

  Future<void> handleCreateExpense() async {
    try {
      if (expenseTitleTEC.text.isEmpty ||
          expenseBudgetTEC.text.isEmpty ||
          expenseDescriptionTEC.text.isEmpty) {
        Get.snackbar("Error", "Please fill all fields");
        return;
      }
      final amount = isEvenlyShared.value
          ? double.parse(expenseBudgetTEC.text) /
              (SocketService.currentPlan.value.group?.members?.length ?? 1)
          : double.parse(expenseBudgetTEC.text);
      final individualSharesList = isEvenlyShared.value
          ? SocketService.currentPlan.value.group?.members
              ?.map((e) => {
                    "userId": e.user!.userId,
                    "amount": amount,
                  })
              .toList()
          : individualShares
              .map((e) => {
                    "userId": e.userId,
                    "amount": e.amount!.toDouble(),
                  })
              .toList();
      var response = await _costRequest.createExpense(
        title: expenseTitleTEC.text,
        amount: expenseBudgetTEC.text,
        payerId: currentUser.value!.userId!,
        planId: SocketService.currentPlan.value.planId!,
        note: expenseDescriptionTEC.text,
        sharedWith: isEvenlyShared.value
            ? CostSharingSharedWith.GROUP.name
            : CostSharingSharedWith.INDIVIDUALS.name,
        individualShares: individualSharesList ?? [],
      );
      if (response.allGood) {
        Get.back();
        Get.snackbar("Success", "Expense created successfully");
        final cost = CostModel.fromJson(response.body);
        if (argGroupId != null ||
            SocketService.currentPlan.value.groupId != null) {
          SocketService.addExpense(
            expenseId: cost.costShareId!,
            groupId: argGroupId ?? SocketService.currentPlan.value.groupId!,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleCreateTask() async {
    try {
      if (taskTitleTEC.text.isNotEmpty) {
        var response = await _taskRequest.createTask(
          planId: SocketService.currentPlan.value.planId!,
          title: taskTitleTEC.text,
          description: taskDescriptionTEC.text,
          budget: taskBudgetTEC.text,
          startDate: taskStartTime.value,
          endDate: taskEndTime.value,
          locationName: currentLocation.value?.name,
          latitude: currentLocation.value?.coordinates?.latitude,
          longitude: currentLocation.value?.coordinates?.longitude,
          address: currentLocation.value?.address,
          estimatedCost: estimatedCostTEC.text.isEmpty
              ? 0
              : int.parse(estimatedCostTEC.text),
          estimatedTime: estimatedTimeTEC.text.isEmpty
              ? 0
              : int.parse(estimatedTimeTEC.text),
        );
        if (response.allGood) {
          final task = TaskModel.fromJson(response.body);
          taskTitleTEC.clear();
          taskDescriptionTEC.clear();
          taskBudgetTEC.clear();
          taskStartTime.value = SocketService.currentPlan.value.startDate!;
          taskEndTime.value = taskStartTime.value;
          if (argGroupId != null ||
              SocketService.currentPlan.value.groupId != null) {
            SocketService.addTask(
              taskId: task.taskId!,
              groupId: argGroupId ?? SocketService.currentPlan.value.groupId!,
            );
          } else {
            SocketService.taskByDay.insert(0, task);
            SocketService.taskByDay.refresh();
            SocketService.currentPlan.value.tasks?.add(task);
            SocketService.currentPlan.refresh();
          }
          Get.snackbar("Success", "Task created successfully");
        } else {
          Get.snackbar("Kiwis", response.message ?? "Something went wrong");
        }
      } else {
        Get.snackbar("Kiwis", "Please fill all fields");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleTaskDone(String taskId) async {
    var response = await _taskRequest.updateTaskIsDone(taskId: taskId);
    if (response.allGood) {
      TaskModel task = TaskModel.fromJson(response.body);
      SocketService.currentPlan.value.tasks
          ?.removeWhere((task) => task.taskId == taskId);
      SocketService.currentPlan.value.tasks?.add(task);
      SocketService.currentPlan.refresh();
      Get.back();
    }
  }

  Future<void> handeToOnPlan() async {
    if (SocketService.currentPlan.value.tasks!.isEmpty) {
      Get.snackbar("Note", "Please add tasks first");
      return;
    }
    if (SocketService.currentPlan.value.isStart!) {
      Get.toNamed(Routes.ON_PLAN,
          arguments: SocketService.currentPlan.value.planId);
    } else {
      var response = await _planRequest.updatePlanIsStart(
        SocketService.currentPlan.value.planId!,
      );
      if (response.allGood) {
        if (response.body == 'Plan already started') {
          Get.toNamed(Routes.ON_PLAN,
              arguments: SocketService.currentPlan.value.planId);
          SocketService.currentPlan.value.isStart = true;
        } else {
          PlanModel plan = PlanModel.fromJson(response.body);
          SocketService.currentPlan.value = plan;
          Get.toNamed(Routes.ON_PLAN,
              arguments: SocketService.currentPlan.value.planId);
        }
        SocketService.currentPlan.refresh();
      }
    }
  }

  Future<void> handleDeleteTask(String taskId) async {
    try {
      var response = await _taskRequest.deleteTask(taskId: taskId);
      if (response.allGood) {
        SocketService.currentPlan.value.tasks
            ?.removeWhere((task) => task.taskId == taskId);
        SocketService.currentPlan.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleCreatePlan({bool isEdit = false}) async {
    try {
      if (currentStep.value == 1) {
        if (titleTEC.text.isEmpty ||
            descriptionTEC.text.isEmpty ||
            budgetTEC.text.isEmpty) {
          Get.snackbar("Error", "Please fill all fields");
          return;
        }
        ApiResponse response;
        if (isEdit) {
          response = await _planRequest.updatePlanById(
            planId: SocketService.currentPlan.value.planId!,
            title: titleTEC.text,
            description: descriptionTEC.text,
            budget: budgetTEC.text,
            startDay: startDay.value,
            endDay: endDay.value,
            groupId: argGroupId,
            image: imageFile.value?.readAsBytesSync(),
          );
        } else {
          response = await _planRequest.createPlan(
            title: titleTEC.text,
            description: descriptionTEC.text,
            budget: budgetTEC.text,
            startDay: startDay.value,
            endDay: endDay.value,
            groupId: argGroupId,
            image: imageFile.value?.readAsBytesSync(),
          );
        }

        if (response.allGood) {
          titleTEC.clear();
          descriptionTEC.clear();
          budgetTEC.clear();
          startDay.value = DateTime.now();
          endDay.value = DateTime.now();
          if (isEdit) {
            SocketService.currentPlan.value.tasks?.clear();
          }
          final plan = PlanModel.fromJson(response.body);
          SocketService.plans.add(plan);
          SocketService.plans.refresh();
          if (argGroupId != null) {
            SocketService.addPlan(
              userId: currentUser.value!.userId!,
              groupId: argGroupId,
              planId: plan.planId!,
            );
          }
          Get.snackbar("Success", "Plan created successfully");
          currentStep.value++;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
