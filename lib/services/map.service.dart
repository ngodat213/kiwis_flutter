import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    as vietmap;
import '../services/geolocator.service.dart';
import 'package:dio/dio.dart';

class MapService extends GetxService {
  static MapService get to => Get.find();

  final _geolocatorService = GeolocatorService.to;
  final _firestore = FirebaseFirestore.instance;

  // Controller cho VietMap
  Rx<VietmapController?> mapController = Rx<VietmapController?>(null);

  // Vị trí được chọn trên bản đồ
  final Rx<vietmap.LatLng?> selectedLocation = Rx<vietmap.LatLng?>(null);

  // Danh sách điểm dừng cho điều hướng
  final RxList<vietmap.LatLng> waypoints = <vietmap.LatLng>[].obs;

  // API key của VietMap
  final String apiKey = 'aea372b8337c70c13c0e3b2dc1f0cfef47b6708fb2756444';

  // Style URL của VietMap
  final String styleUrl =
      'https://maps.vietmap.vn/api/maps/light/styles.json?apikey=aea372b8337c70c13c0e3b2dc1f0cfef47b6708fb2756444';

  // Khởi tạo vị trí camera mặc định (Hà Nội)
  final defaultLocation = const vietmap.CameraPosition(
    target: vietmap.LatLng(21.028511, 105.804817),
    zoom: 10,
  );

  // Thêm các thuộc tính mới
  final searchResults = <Map<String, dynamic>>[].obs;
  final isSearching = false.obs;
  final dio = Dio();

  @override
  Future<MapService> init() async {
    try {
      // Khởi tạo các giá trị ban đầu nếu cần
      await _initializeMapDefaults();
      return this;
    } catch (e) {
      print('Lỗi khởi tạo MapService: $e');
      rethrow;
    }
  }

  Future<void> _initializeMapDefaults() async {
    // Khởi tạo các giá trị mặc định
    selectedLocation.value = defaultLocation.target;
    waypoints.clear();

    // Kiểm tra quyền truy cập vị trí
    final position = await _geolocatorService.getCurrentPosition();
    if (position != null) {
      selectedLocation.value = vietmap.LatLng(
        position.latitude,
        position.longitude,
      );
    }
  }

  // Di chuyển camera đến vị trí
  Future<void> animateToLocation(vietmap.LatLng location) async {
    if (mapController.value != null) {
      await mapController.value!.animateCamera(
        CameraUpdate.newLatLng(location),
      );
    }
  }

  // Thêm marker vào map
  Future<void> addMarker(vietmap.LatLng location, {String? markerId}) async {
    if (mapController.value != null) {
      await mapController.value!.addSymbol(
        SymbolOptions(
          geometry: location,
          iconImage: markerId == 'current_location'
              ? "assets/images/my_location.png"
              : "assets/images/my_location.png",
          iconSize: 0.2,
        ),
      );
    }
  }

  // Xóa tất cả marker
  Future<void> clearMarkers() async {
    if (mapController.value != null) {
      await mapController.value!.clearSymbols();
    }
  }

  // Thêm điểm dừng cho điều hướng
  void addWaypoint(vietmap.LatLng location) {
    waypoints.add(location);
  }

  // Xóa điểm dừng
  void removeWaypoint(int index) {
    if (index >= 0 && index < waypoints.length) {
      waypoints.removeAt(index);
    }
  }

  // Xóa tất cả điểm dừng
  void clearWaypoints() {
    waypoints.clear();
  }

  // Vẽ đường đi giữa các điểm
  Future<void> drawRoute() async {
    if (mapController.value != null && waypoints.length >= 2) {
      // Tạo danh sách coordinates cho line
      List<vietmap.LatLng> coordinates = [...waypoints];

      await mapController.value!.addPolyline(
        PolylineOptions(
          geometry: coordinates,
          polylineColor: Colors.red,
          polylineWidth: 3.0,
        ),
      );
    }
  }

  // Share location lên Firestore
  Future<void> shareLocation({
    required String userId,
    required vietmap.LatLng location,
    String? description,
  }) async {
    try {
      await _firestore.collection('shared_locations').add({
        'userId': userId,
        'latitude': location.latitude,
        'longitude': location.longitude,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Lỗi khi share location: $e');
      rethrow;
    }
  }

  // Lấy shared locations từ Firestore
  Stream<QuerySnapshot> getSharedLocations() {
    return _firestore
        .collection('shared_locations')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Lấy vị trí hiện tại và cập nhật camera
  Future<void> moveToCurrentLocation() async {
    try {
      final position = await _geolocatorService.getCurrentPosition();
      if (position != null) {
        final location = vietmap.LatLng(
          position.latitude,
          position.longitude,
        );

        // Di chuyển camera đến vị trí hiện tại
        await animateToLocation(location);

        // Thêm marker với icon tùy chỉnh
        await mapController.value?.addSymbol(
          SymbolOptions(
            geometry: location,
            iconImage: "assets/images/my_location.png",
            iconSize: 0.2,
          ),
        );

        // Cập nhật selectedLocation
        selectedLocation.value = location;
      }
    } catch (e) {
      print('Lỗi khi di chuyển đến vị trí hiện tại: $e');
    }
  }

  // Phương thức tìm kiếm địa điểm
  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      final response = await dio.get(
        'https://maps.vietmap.vn/api/search/v3',
        queryParameters: {
          'apikey': apiKey,
          'text': query,
          'size': 10,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> features = response.data['features'];
        searchResults.value = features.map((feature) {
          final coordinates = feature['geometry']['coordinates'];
          return {
            'name': feature['properties']['name'],
            'address': feature['properties']['address'],
            'location': vietmap.LatLng(
              coordinates[1].toDouble(),
              coordinates[0].toDouble(),
            ),
          };
        }).toList();
      }
    } catch (e) {
      print('Lỗi khi tìm kiếm địa điểm: $e');
    } finally {
      isSearching.value = false;
    }
  }
}
