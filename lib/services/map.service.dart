import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kiwis_flutter/core/utils/map.utils.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    as vietmap;
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart'
    as vietMapFlg;
import '../services/geolocator.service.dart';
import 'package:dio/dio.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart' as vietMapGl;
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    as vietMapInterface;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapService extends GetxService {
  static MapService get to => Get.find();

  final _geolocatorService = GeolocatorService.to;
  final _firestore = FirebaseFirestore.instance;

  Rx<VietmapController?> mapController = Rx<VietmapController?>(null);
  final Rx<vietmap.LatLng?> selectedLocation = Rx<vietmap.LatLng?>(null);
  final RxList<vietmap.LatLng> waypoints = <vietmap.LatLng>[].obs;
  final String apiKey = dotenv.env['VIETMAP_API_KEY']!;
  final String styleUrl =
      'https://maps.vietmap.vn/api/maps/light/styles.json?apikey=' +
          dotenv.env['VIETMAP_API_KEY']!;

  final searchResults = <Map<String, dynamic>>[].obs;
  final isSearching = false.obs;
  final dio = Dio();
  final RxBool isUserPinned = false.obs;
  final double maxDeviationDistance = 50.0;
  final double recalculateThreshold = 100.0;
  StreamSubscription<Position>? _locationSubscription;

  List<vietMapGl.LatLng> currentPolylinePoints = [];
  bool isRecalculating = false;
  double threshold = 10.0;
  LatLng? destinationPoint;
  Timer? _checkDistanceTimer;

  final defaultLocation = const vietmap.CameraPosition(
    target: vietmap.LatLng(0, 0),
    zoom: 5,
  );

  @override
  Future<MapService> init() async {
    try {
      // Khởi tạo các giá trị ban đầu nếu c���n
      vietMapFlg.Vietmap.getInstance(apiKey);
      await _initializeMapDefaults();
      return this;
    } catch (e) {
      print('Lỗi khởi tạo MapService: $e');
      rethrow;
    }
  }

  // Đảm bảo dọn dẹp khi service bị dispose
  @override
  void onClose() {
    _checkDistanceTimer?.cancel();
    super.onClose();
  }

  Future<void> _initializeMapDefaults() async {
    selectedLocation.value = defaultLocation.target;
    waypoints.clear();

    final position = await _geolocatorService.getCurrentPosition();
    if (position != null) {
      selectedLocation.value = vietmap.LatLng(
        position.latitude,
        position.longitude,
      );
    }
  }

  Future<void> animateToLocation(vietmap.LatLng location) async {
    if (mapController.value != null) {
      await mapController.value!.animateCamera(
        CameraUpdate.newLatLngZoom(location, 18),
      );
    }
  }

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

  Future<void> clearMarkers() async {
    if (mapController.value != null) {
      await mapController.value!.clearSymbols();
    }
  }

  Future<void> clearPolylines() async {
    if (mapController.value != null) {
      await mapController.value!.clearLines();
    }
  }

  Future<void> drawTripPolyLine(LatLng start, LatLng end) async {
    try {
      // Lưu điểm đích để sử dụng khi cần tính toán lại route
      destinationPoint = end;

      await clearPolylines();
      List<vietMapGl.LatLng> points = [];

      var routingResponse = await vietMapFlg.Vietmap.routing(
          vietMapFlg.VietMapRoutingParams(points: [
        vietMapFlg.LatLng(start.latitude, start.longitude),
        vietMapFlg.LatLng(end.latitude, end.longitude)
      ]));

      routingResponse.fold((failure) {
        print("Routing API Error: $failure");
      }, (success) {
        if (success.paths?.isNotEmpty == true &&
            success.paths![0].points?.isNotEmpty == true) {
          points = vietMapInterface.VietmapPolylineDecoder.decodePolyline(
              success.paths!.first.points!);
        }
      });

      List<vietMapFlg.LatLng> polylinePoints = points.map((e) {
        return vietMapFlg.LatLng(e.latitude * 10, e.longitude * 10);
      }).toList();

      if (polylinePoints.isNotEmpty) {
        await mapController.value!.addPolyline(
          vietMapInterface.PolylineOptions(
            geometry: polylinePoints,
            polylineColor: Colors.green,
            polylineWidth: 3.0,
            draggable: false,
          ),
        );

        // Lưu points và bắt đầu theo dõi
        currentPolylinePoints = polylinePoints;
        startTrackingPolyline();
      }

      mapController.value!.animateCamera(vietMapGl.CameraUpdate.newLatLngBounds(
        MapUtils.targetBounds(
          vietMapFlg.LatLng(start.latitude, start.longitude),
          vietMapFlg.LatLng(end.latitude, end.longitude),
        ),
        top: 160,
        left: 160,
        right: 160,
        bottom: 280,
      ));
      moveToCurrentLocation();
    } catch (e) {
      print("Error in drawTripPolyLine: $e");
    }
  }

  Future<void> shareLocation({
    required String userId,
    required vietmap.LatLng location,
    required String groupId,
    String? description,
  }) async {
    try {
      await _firestore.collection('shared_locations').add({
        'userId': userId,
        'groupId': groupId,
        'latitude': location.latitude,
        'longitude': location.longitude,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Lỗi khi chia sẻ vị trí: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getSharedLocations(String groupId) {
    return _firestore
        .collection('shared_locations')
        .where('groupId', isEqualTo: groupId)
        .snapshots();
  }

  Future<void> moveToCurrentLocation() async {
    try {
      final position = await _geolocatorService.getCurrentPosition();
      if (position != null) {
        final location = vietmap.LatLng(
          position.latitude,
          position.longitude,
        );

        isUserPinned.value = true;

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

  // Theo dõi vị trí realtime và cập nhật bản đồ
  Future<void> startTrackingUserLocation() async {
    try {
      // Hủy theo dõi cũ nếu có
      _locationSubscription?.cancel();

      // Lắng nghe vị trí từ GeolocatorService
      _locationSubscription = _geolocatorService.positionStream.listen(
        (Position position) {
          final currentLocation =
              vietmap.LatLng(position.latitude, position.longitude);

          if (isUserPinned.value) {
            animateToLocation(currentLocation);
          }
          // Cập nhật marker
          updateUserLocationMarker(currentLocation);
        },
        onError: (error) {
          print('Lỗi khi theo dõi vị trí: $error');
        },
      );
    } catch (e) {
      print('Lỗi khi bắt đầu theo dõi vị trí: $e');
    }
  }

  // Dừng theo dõi vị trí
  void stopTrackingUserLocation() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  // Cập nhật marker tại vị trí hiện tại
  Future<void> updateUserLocationMarker(vietmap.LatLng location) async {
    if (mapController.value != null) {
      await mapController.value!.clearSymbols();
      await mapController.value!.addSymbol(
        SymbolOptions(
          geometry: location,
          iconImage: "assets/images/my_location.png",
          iconSize: 0.2,
        ),
      );
    }
  }

  // Thêm phương thức để bắt đầu theo dõi polyline
  void startTrackingPolyline() {
    // Hủy timer cũ nếu có
    _checkDistanceTimer?.cancel();

    // Tạo timer mới để kiểm tra định kỳ
    _checkDistanceTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (currentPolylinePoints.isEmpty) {
        timer.cancel();
        return;
      }

      final currentPosition = await _geolocatorService.getCurrentPosition();
      if (currentPosition != null) {
        await _updatePolylineBasedOnLocation(vietMapGl.LatLng(
            currentPosition.latitude, currentPosition.longitude));
      }
    });
  }

  // Phương thức để cập nhật polyline dựa trên vị trí hiện tại
  Future<void> _updatePolylineBasedOnLocation(
      vietMapGl.LatLng currentLocation) async {
    if (currentPolylinePoints.isEmpty || isRecalculating) return;

    // Kiểm tra xem người dùng có đi chệch khỏi route không
    bool isOnRoute = false;
    double minDistanceToRoute = double.infinity;

    // Kiểm tra khoảng cách đến đoạn đường gần nhất
    for (int i = 0; i < currentPolylinePoints.length - 1; i++) {
      var point1 = currentPolylinePoints[i];
      var point2 = currentPolylinePoints[i + 1];

      double distance = _distanceToLine(
        currentLocation,
        point1,
        point2,
      );

      minDistanceToRoute = min(minDistanceToRoute, distance);
    }

    isOnRoute = minDistanceToRoute <= maxDeviationDistance;

    if (!isOnRoute) {
      print("Người dùng đi chệch hướng: $minDistanceToRoute mét");

      // Nếu đi chệch quá xa, tính toán lại route
      if (minDistanceToRoute > recalculateThreshold &&
          destinationPoint != null) {
        isRecalculating = true;

        // Thông báo cho người dùng
        Get.snackbar(
          'Đang tính toán lại lộ trình',
          'Bạn đã đi chệch khỏi đường được đề xuất',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );

        // Vẽ lại route từ vị trí hiện tại đến điểm đích
        await drawTripPolyLine(
          LatLng(currentLocation.latitude, currentLocation.longitude),
          destinationPoint!,
        );

        isRecalculating = false;
        return;
      }
    }

    // Xử lý cập nhật polyline bình thường
    List<vietMapGl.LatLng> remainingPoints = [];
    bool needsUpdate = false;

    for (var point in currentPolylinePoints) {
      double distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        point.latitude,
        point.longitude,
      );

      if (distance > threshold) {
        remainingPoints.add(point);
      } else {
        needsUpdate = true;
      }
    }

    if (needsUpdate && remainingPoints.length < currentPolylinePoints.length) {
      await clearPolylines();
      if (remainingPoints.isNotEmpty) {
        await mapController.value?.addPolyline(
          vietMapInterface.PolylineOptions(
            geometry: remainingPoints,
            polylineColor: Colors.green,
            polylineWidth: 3.0,
            draggable: false,
          ),
        );
        currentPolylinePoints = remainingPoints;
      }
    }
  }

  // Thêm helper method để tính khoảng cách từ điểm đến đoạn thẳng
  double _distanceToLine(vietMapGl.LatLng point, vietMapGl.LatLng lineStart,
      vietMapGl.LatLng lineEnd) {
    double x = point.latitude;
    double y = point.longitude;
    double x1 = lineStart.latitude;
    double y1 = lineStart.longitude;
    double x2 = lineEnd.latitude;
    double y2 = lineEnd.longitude;

    double A = x - x1;
    double B = y - y1;
    double C = x2 - x1;
    double D = y2 - y1;

    double dot = A * C + B * D;
    double lenSq = C * C + D * D;
    double param = dot / lenSq;

    double xx, yy;

    if (param < 0) {
      xx = x1;
      yy = y1;
    } else if (param > 1) {
      xx = x2;
      yy = y2;
    } else {
      xx = x1 + param * C;
      yy = y1 + param * D;
    }

    return Geolocator.distanceBetween(x, y, xx, yy);
  }
}
