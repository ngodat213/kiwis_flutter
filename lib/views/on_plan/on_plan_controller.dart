import 'package:get/get.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/services/geolocator.service.dart';
import 'package:kiwis_flutter/services/map.service.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart'
    as vietMapFlg;

class OnPlanController extends BaseController {
  final PlanRequest _planRequest = PlanRequest();

  MyLocationTrackingMode myLocationTrackingMode =
      MyLocationTrackingMode.Tracking;
  final mapService = MapService.to;
  final geoService = GeolocatorService.to;
  final Rxn<PlanModel> currentPlan = Rxn<PlanModel>(null);
  final RxList<PlanLocationModel> locations = RxList.empty();
  String? argPlanId;
  final RxBool onTracking = false.obs;
  final RxInt currentRouteIndex = 0.obs;
  final RxBool isShowDialog = false.obs;

  @override
  void onInit() async {
    super.onInit();
    argPlanId = Get.arguments;
    await getPlan();
    await drawLine();
  }

  Rx<PlanLocationModel> get currentLocation =>
      locations[currentRouteIndex.value].obs;

  RxBool get isLastLocation =>
      (currentRouteIndex.value == locations.length - 1).obs;

  Future<void> getPlan() async {
    try {
      final plan = await _planRequest.findPlanById(argPlanId!);
      if (plan.allGood) {
        currentPlan.value = PlanModel.fromJson(plan.body);
        locations.value = currentPlan.value!.planLocations ?? [];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> nextLocation() async {
    if (currentRouteIndex.value < locations.length - 1) {
      currentRouteIndex.value++;
      await drawLine();
    }
  }

  Future<void> finishLocation() async {
    final plan =
        await _planRequest.updatePlanById(argPlanId!, currentPlan.value!);
    if (plan.allGood) {
      currentPlan.value = PlanModel.fromJson(plan.body);
    }
  }

  Future<void> drawLine() async {
    await mapService.drawTripPolyLine(
      vietMapFlg.LatLng(
        geoService.currentPosition.value!.latitude,
        geoService.currentPosition.value!.longitude,
      ),
      vietMapFlg.LatLng(
        locations[currentRouteIndex.value].latitude!,
        locations[currentRouteIndex.value].longitude!,
      ),
    );
  }

  Future<void> updatePlan() async {
    final plan =
        await _planRequest.updatePlanById(argPlanId!, currentPlan.value!);
    if (plan.allGood) {
      currentPlan.value = PlanModel.fromJson(plan.body);
    }
  }
}
