import 'dart:async';

import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
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
      body: Stack(
        children: [
          // Map View
          Obx(() {
            final vietMapController = mapService.mapController.value;
            // if (vietMapController == null) {
            //   print("vietMapController is null");
            //   return Center(child: CircularProgressIndicator());
            // }
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

          // Search Bar và Results
          Positioned(
            top: 40,
            left: 60,
            right: 16,
            child: Column(
              children: [
                // Search Bar
                Container(
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm địa điểm...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length >= 3) {
                        LocationSearchController.to.searchLocation(value);
                      } else {
                        LocationSearchController.to.searchResults.clear();
                      }
                    },
                  ),
                ),

                // Search Results
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

          // Confirm Button
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
                      child: controller.currentLocation.value!.name
                          .toString()
                          .text
                          .black
                          .textStyle(theme.textTheme.titleMedium)
                          .make(),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: controller.currentLocation.value != null,
                      child: controller.currentLocation.value!.address
                          .toString()
                          .text
                          .black
                          .center
                          .textStyle(theme.textTheme.bodySmall)
                          .make(),
                    ),
                    SizedBox(height: 20),
                    CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillGreen,
                      onPressed: hasLocation
                          ? () {
                              // Trả về vị trí đã chọn
                              Get.back(
                                  result: mapService.selectedLocation.value);
                            }
                          : null,
                      text: "Choose location".tr,
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

  // Thêm hàm helper để load image từ asset
  Future<Uint8List> _loadImageFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    return data.buffer.asUint8List();
  }
}
