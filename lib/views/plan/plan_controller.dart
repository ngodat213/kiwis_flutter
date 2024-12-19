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
import 'package:kiwis_flutter/requests/plan.request.dart';
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

  /// Controller
  final TextEditingController locationNameTEC = TextEditingController();
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController budgetTEC = TextEditingController();
  //
  final TextEditingController estimatedCostTEC = TextEditingController();
  final TextEditingController estimatedTimeTEC = TextEditingController();

  /// Variables
  Rx<DateTime> startDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime> endDay = Rx<DateTime>(DateTime.now());
  Rx<DateTime?> focusedDay = Rx<DateTime?>(DateTime.now());
  Rx<PlanModel?> currentPlan = Rxn<PlanModel?>();
  Rxn<AddressModel?> currentLocation = Rxn<AddressModel?>();
  RxList<PlanModel> plans = <PlanModel>[].obs;
  RxList<AddressModel> locations = <AddressModel>[].obs;
  Rx<File?> imageFile = Rxn<File?>();
  RxInt currentStep = 0.obs;
  String? argGroupId;
  List<Widget> steps = [TimeWidget(), DetailWidget(), ScheduleWidget()];

  @override
  void onInit() {
    super.onInit();
    argGroupId = Get.arguments;
    initPlans();
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
        Get.snackbar("Success", "Plan updated successfully",
            colorText: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }

  // --------------------------- MAP ------------------------------
  void onTapSwapLocation(int index) {
    if (index < (currentPlan.value?.planLocations?.length ?? 0) - 1) {
      var temp = currentPlan.value!.planLocations![index];
      currentPlan.value!.planLocations![index] =
          currentPlan.value!.planLocations![index + 1];
      currentPlan.value!.planLocations![index + 1] = temp;
      currentPlan.refresh();
    }
  }

  void removeLocation(int index) {
    Get.defaultDialog(
      backgroundColor: appTheme.gray50,
      title: "Remove location",
      middleText: "Are you sure you want to remove this location?",
      titleStyle: theme.textTheme.titleLarge,
      middleTextStyle: theme.textTheme.bodyLarge!.copyWith(
        color: Colors.white,
      ),
      onConfirm: () {
        currentPlan.value!.planLocations!.removeAt(index);
        currentPlan.refresh();
        Get.back();
      },
    );
  }

  Future<void> updateAllPlanLocation() async {
    try {
      if (currentPlan.value != null) {
        var response = await _planRequest.updateAllPlanLocation(
          currentPlan.value!.planId!,
          currentPlan.value!.planLocations!,
        );
        if (response.allGood) {
          currentPlan.refresh();
          Get.snackbar("Success", "Plan locations updated successfully",
              colorText: Colors.white);
        }
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

    if (currentPlan.value != null) {
      var response = await _planRequest.addPlanLocation(
        currentPlan.value!.planId!,
        location,
      );
      if (response.allGood) {
        final planLocation = PlanLocationModel.fromJson(response.body);
        estimatedCostTEC.clear();
        estimatedTimeTEC.clear();
        currentLocation.value = null;
        locationNameTEC.clear();
        currentPlan.value?.planLocations?.add(planLocation);
        currentPlan.refresh();
        Get.back();
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to add location");
      }
    }
  }

  void onPressChooseLocation(BuildContext context) {
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
      Get.snackbar("Error", "Please select a location first",
          colorText: Colors.white);
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

  Future<void> createPlan(BuildContext context) async {
    try {
      if (titleTEC.text.isEmpty ||
          descriptionTEC.text.isEmpty ||
          budgetTEC.text.isEmpty) {
        Get.snackbar("Error", "Please fill all fields",
            colorText: Colors.white);
        return;
      }
      var response = await _planRequest.createPlan(
        title: titleTEC.text,
        description: descriptionTEC.text,
        budget: budgetTEC.text,
        startDay: startDay.value,
        endDay: endDay.value,
        groupId: argGroupId,
      );

      if (response.allGood) {
        titleTEC.clear();
        descriptionTEC.clear();
        budgetTEC.clear();
        startDay.value = DateTime.now();
        endDay.value = DateTime.now();
        plans.add(PlanModel.fromJson(response.body));
        Get.back();
        Get.snackbar("Success", "Plan created successfully",
            colorText: Colors.white);
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
