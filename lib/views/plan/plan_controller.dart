import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/controllers/location_search.controller.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/models/address.model.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/views/plan/widgets/choose_location.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_create.content.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_detail.content.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class PlanController extends BaseController {
  /// Request
  final PlanRequest _planRequest = PlanRequest();

  /// Controller
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController budgetTEC = TextEditingController();

  Rx<DateTime?> startDay = Rx<DateTime?>(null);
  Rx<DateTime?> endDay = Rx<DateTime?>(null);
  Rx<DateTime?> focusedDay = Rx<DateTime?>(DateTime.now());

  /// Variables
  Rx<PlanModel?> currentPlan = Rxn<PlanModel?>();
  RxList<PlanModel> plans = <PlanModel>[].obs;
  Rx<AddressModel?> currentLocation = Rxn<AddressModel?>();
  RxList<AddressModel> locations = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initPlans();
  }

  // --------------------------- MAP ------------------------------
  void changeCurrentLocation(AddressModel location) {
    currentLocation.value = location;
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
      var response = await _planRequest.getPlanRequest();
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

  Future<void> createPlan(BuildContext context) async {
    try {
      if (startDay.value == null || endDay.value == null) {
        AnimatedSnackBar.material(
          "Please select date",
          type: AnimatedSnackBarType.warning,
        ).show(context);
        return;
      }

      if (titleTEC.text.isEmpty ||
          descriptionTEC.text.isEmpty ||
          budgetTEC.text.isEmpty) {
        AnimatedSnackBar.material(
          "Please fill all fields",
          type: AnimatedSnackBarType.warning,
        ).show(context);
        return;
      }
      var response = await _planRequest.createPlan(
        titleTEC.text,
        descriptionTEC.text,
        budgetTEC.text,
        startDay.value!,
        endDay.value!,
      );

      if (response.allGood) {
        titleTEC.clear();
        descriptionTEC.clear();
        budgetTEC.clear();
        startDay.value = null;
        endDay.value = null;
        plans.add(PlanModel.fromJson(response.body));
        Get.back();
        AnimatedSnackBar.material(
          "Plan created successfully",
          type: AnimatedSnackBarType.success,
        ).show(context);
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
