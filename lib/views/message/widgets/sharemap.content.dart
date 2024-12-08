import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/map.service.dart';

class ShareMapContent extends StatelessWidget {
  final mapService = MapService.to;
  final authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map View
          Obx(() => VietmapGL(
                styleString: mapService.styleUrl,
                initialCameraPosition: mapService.defaultLocation,
                onMapCreated: (VietmapController controller) {
                  mapService.mapController.value = controller;
                  mapService.moveToCurrentLocation();
                },
                onMapClick: (point, coordinates) {
                  mapService.selectedLocation.value = coordinates;
                  mapService.clearMarkers();
                  mapService.addMarker(coordinates);
                },
              )),

          // Shared Locations List
          Positioned(
            top: 50,
            right: 10,
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: mapService.getSharedLocations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Đã xảy ra lỗi'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text('User: ${data['userId']}'),
                        subtitle: Text(data['description'] ?? ''),
                        onTap: () {
                          mapService.animateToLocation(
                            LatLng(data['latitude'], data['longitude']),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),

          // Share Location Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                if (mapService.selectedLocation.value != null) {
                  final description = await Get.dialog<String>(
                    AlertDialog(
                      title: Text('Thêm mô tả'),
                      content: TextField(
                        decoration: InputDecoration(
                          hintText: 'Nhập mô tả vị trí của bạn',
                        ),
                        onSubmitted: (value) => Get.back(result: value),
                      ),
                    ),
                  );

                  if (description != null) {
                    await mapService.shareLocation(
                      userId: AuthServices.currentUser!.userId!,
                      location: mapService.selectedLocation.value!,
                      description: description,
                    );
                    Get.snackbar(
                      'Thành công',
                      'Đã chia sẻ vị trí của bạn',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }
              },
              child: Icon(Icons.share_location),
            ),
          ),
        ],
      ),
    );
  }
}
