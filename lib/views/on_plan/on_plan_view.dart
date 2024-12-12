import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/services/map.service.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart' as vietMapGl;
import 'package:velocity_x/velocity_x.dart';

import 'on_plan_controller.dart';

class OnPlanView extends GetView<OnPlanController> {
  OnPlanView({super.key});
  @override
  Widget build(BuildContext context) {
    final mapService = MapService.to;

    return Scaffold(
      body: Stack(
        children: [
          // Map View
          Obx(() {
            final vietMapController = mapService.mapController.value;

            return vietMapGl.VietmapGL(
              styleString: mapService.styleUrl,
              initialCameraPosition: mapService.defaultLocation,
              myLocationEnabled: true,
              myLocationTrackingMode: controller.myLocationTrackingMode,
              myLocationRenderMode: vietMapGl.MyLocationRenderMode.COMPASS,
              onMapCreated: (vietMapGl.VietmapController vmController) async {
                mapService.mapController.value = vmController;
                mapService.startTrackingUserLocation();
                await controller.drawLine();
              },
              onMapClick: (point, latLng) {
                mapService.isUserPinned.value = false;
              },
            );
          }),
          // Back Button
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(Icons.sos, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.3,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              child: IconButton(
                icon: Icon(Icons.camera, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          // Confirm Button
          Positioned(
            bottom: Get.height * 0.05,
            left: 20,
            right: 20,
            child: Obx(() {
              final hasLocation = mapService.selectedLocation.value != null;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: controller.currentLocation.value != null,
                      child: (controller.currentLocation.value.name ?? "")
                          .text
                          .black
                          .textStyle(theme.textTheme.titleMedium)
                          .make(),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: controller.currentLocation.value != null,
                      child: (controller.currentLocation.value.address ?? "")
                          .text
                          .black
                          .center
                          .textStyle(theme.textTheme.bodySmall)
                          .make(),
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillGreen,
                      onPressed: () {
                        if (controller.isLastLocation.value) {
                          Get.back();
                        } else {
                          controller.nextLocation();
                        }
                      },
                      text: "Finish".tr,
                    ),
                  ],
                ),
              );
            }),
          ),

          // Current Location Button
          Positioned(
            top: 100,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.my_location, color: Colors.blue),
                onPressed: () {
                  mapService.moveToCurrentLocation();
                },
              ),
            ),
          ),

          // Loading Indicator
          Obx(() {
            if (mapService.mapController.value == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
