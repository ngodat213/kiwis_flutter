import 'dart:async';

import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart' as vietMapGl;
import 'package:flutter/material.dart';
import '../../../services/map.service.dart';
import '../../../controllers/location_search.controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/services.dart';

class ChooseLocationContent extends GetView<PlanController> {
  const ChooseLocationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = MapService.to;

    return Scaffold(
      appBar: baseAppBar(
        context: context,
        title: "".tr,
        onBack: () {
          controller.currentLocation.value = null;
          Get.back();
        },
        actions: [
          CustomTextFormField(
            width: Get.width * 0.7,
            hintText: 'Tìm kiếm địa điểm...',
            prefix: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            onChanged: (value) {
              if (value.length >= 3) {
                LocationSearchController.to.searchLocation(value);
              } else {
                LocationSearchController.to.searchResults.clear();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            final vietMapController = mapService.mapController.value;
            return vietMapGl.VietmapGL(
              styleString: mapService.styleUrl,
              initialCameraPosition: mapService.defaultLocation,
              myLocationEnabled: true,
              myLocationTrackingMode: vietMapGl.MyLocationTrackingMode.None,
              myLocationRenderMode: vietMapGl.MyLocationRenderMode.COMPASS,
              onMapCreated: (vietMapGl.VietmapController controller) async {
                mapService.mapController.value = controller;
                await mapService.moveToCurrentLocation();
              },
              onMapClick: (point, latLng) {
                mapService.selectedLocation.value = latLng;
                mapService.clearMarkers();
                mapService.addMarker(latLng);
              },
            );
          }),
          Positioned(
            top: 0,
            left: 60,
            right: 16,
            child: Column(
              children: [
                Obx(() {
                  final results = LocationSearchController.to.searchResults;
                  if (results.isEmpty) return SizedBox.shrink();

                  return Container(
                    margin: EdgeInsets.only(top: 8),
                    constraints: BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final address = results[index];
                        return ListTile(
                          onTap: () async {
                            await controller.addressSelected(address);
                          },
                          title: Text(
                            address.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            address.address ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
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
                      child: (controller.currentLocation.value?.name ?? "")
                          .text
                          .black
                          .textStyle(theme.textTheme.titleMedium)
                          .make(),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: controller.currentLocation.value != null,
                      child: (controller.currentLocation.value?.address ?? "")
                          .text
                          .black
                          .center
                          .textStyle(theme.textTheme.bodySmall)
                          .make(),
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonTextStyle: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                      buttonStyle: CustomButtonStyles.fillGreen,
                      onPressed: () =>
                          controller.showContentAddLocation(context),
                      text: "Choose location".tr,
                    ),
                  ],
                ),
              );
            }),
          ),
          Positioned(
            top: 40,
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
