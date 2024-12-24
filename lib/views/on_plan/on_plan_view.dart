import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/services/geolocator.service.dart';
import 'package:kiwis_flutter/services/map.service.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart' as vietMapGl;
import 'package:velocity_x/velocity_x.dart';

import 'on_plan_controller.dart';

class OnPlanView extends GetView<OnPlanController> {
  OnPlanView({super.key});
  @override
  Widget build(BuildContext context) {
    final mapService = MapService.to;
    final homeController = Get.find<HomeController>();
    final geolocatorService = GeolocatorService.to;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return Container(
                height: Get.height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppbarLeadingIconbutton(
                      imagePath: ImageConstant.imgArrowLeftOnprimary,
                      onTap: () => Get.back(),
                    ),
                    SizedBox(width: 23),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "My route"
                            .text
                            .thin
                            .textStyle(theme.textTheme.titleMedium)
                            .make(),
                        "${controller.currentTask.value?.title ?? ""}"
                            .text
                            .bold
                            .textStyle(theme.textTheme.titleLarge)
                            .make(),
                        SizedBox(height: 10),
                        Text(
                          "100m",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ).expand(),
                    Spacer(),
                    AppbarLeadingIconbutton(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.h),
                      ),
                      wiget: Icon(Icons.sos, color: Colors.white),
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
              );
            }),
            Container(
              height: Get.height * 0.85,
              padding: EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    // Map View
                    Obx(() {
                      final vietMapController = mapService.mapController.value;
                      return vietMapGl.VietmapGL(
                        styleString: mapService.styleUrl,
                        initialCameraPosition: mapService.defaultLocation,
                        myLocationEnabled: true,
                        myLocationTrackingMode:
                            controller.myLocationTrackingMode,
                        myLocationRenderMode:
                            vietMapGl.MyLocationRenderMode.COMPASS,
                        onMapCreated:
                            (vietMapGl.VietmapController vmController) async {
                          mapService.mapController.value = vmController;
                          await mapService.moveToCurrentLocation();
                          mapService.startTrackingUserLocation();
                        },
                        onMapClick: (point, latLng) {
                          mapService.isUserPinned.value = false;
                        },
                      );
                    }),

                    // Confirm Button
                    Positioned(
                      bottom: Get.height * 0.03,
                      left: 20,
                      right: 20,
                      child: Obx(() {
                        final hasLocation =
                            mapService.selectedLocation.value != null;
                        return GlossyContainer(
                          width: Get.width,
                          height: Get.height * 0.3,
                          borderRadius: BorderRadius.circular(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Visibility(
                                visible: controller.currentTask.value != null,
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircularProgressIndicator(
                                        value: 0.2,
                                        color: Colors.green,
                                        backgroundColor: Colors.grey,
                                      ),
                                      title: (controller
                                                  .currentTask.value!.title ??
                                              "")
                                          .text
                                          .black
                                          .textStyle(
                                              theme.textTheme.titleMedium)
                                          .make(),
                                      subtitle: (controller.currentTask.value!
                                                  .description ??
                                              "")
                                          .text
                                          .black
                                          .textStyle(theme.textTheme.bodySmall)
                                          .make(),
                                    ).paddingSymmetric(horizontal: 20),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            AppbarLeadingIconbutton(
                                              imagePath: ImageConstant.svgImage,
                                              onTap: () =>
                                                  controller.openCamera(),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Photo"),
                                                "0 photos"
                                                    .text
                                                    .textStyle(theme
                                                        .textTheme.bodySmall)
                                                    .make(),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            AppbarLeadingIconbutton(
                                              wiget: Icon(Icons.speed,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Speed"),
                                                "${geolocatorService.speed?.toStringAsFixed(2) ?? 0} km/h"
                                                    .text
                                                    .textStyle(theme
                                                        .textTheme.bodySmall)
                                                    .make(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 20),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  AppbarLeadingIconbutton(
                                    imagePath: ImageConstant.svgCalander,
                                    onTap: () =>
                                        controller.showSchedule(context),
                                  ),
                                  Visibility(
                                    visible: controller.isCreatedTask.value,
                                    child: CustomElevatedButton(
                                      width: Get.width * 0.5,
                                      buttonStyle: CustomButtonStyles.fillGreen,
                                      onPressed: () {
                                        if (controller.isLastLocation.value) {
                                          Get.back();
                                        } else {
                                          controller.nextLocation();
                                        }
                                      },
                                      text: "Finish".tr,
                                      buttonTextStyle:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ).marginOnly(left: 8).expand(),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 20).expand(),
                            ],
                          ),
                        );
                      }),
                    ),

                    // Current Location Button
                    Positioned(
                      top: 12,
                      left: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.my_location, color: Colors.blue),
                          onPressed: () {
                            mapService.clearMarkers();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
