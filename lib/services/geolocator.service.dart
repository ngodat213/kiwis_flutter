import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorService extends GetxService {
  static GeolocatorService get to => Get.find();

  // Lưu trữ vị trí hiện tại
  final Rx<Position?> currentPosition = Rx<Position?>(null);

  // Theo dõi vị trí realtime
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  Future<GeolocatorService> init() async {
    try {
      await _checkPermission();
      // Lấy vị trí hiện tại khi khởi tạo service
      await getCurrentPosition();
      return this;
    } catch (e) {
      print('Lỗi khởi tạo GeolocatorService: $e');
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkPermission();
  }

  @override
  void onClose() {
    _positionStreamSubscription?.cancel();
    super.onClose();
  }

  Stream<Position> get positionStream => Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5, // Cập nhật mỗi khi di chuyển 10 mét
        ),
      );

  // Kiểm tra và yêu cầu quyền truy cập vị trí
  Future<bool> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // Lấy vị trí hiện tại
  Future<Position?> getCurrentPosition() async {
    try {
      if (!await _checkPermission()) {
        throw 'Không có quyền truy cập vị trí';
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      return position;
    } catch (e) {
      print('Lỗi khi lấy v��� trí: $e');
      return null;
    }
  }

  // Theo dõi vị trí realtime
  Future<void> startLocationUpdates({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10, // Cập nhật khi di chuyển 10 mét
  }) async {
    if (!await _checkPermission()) {
      throw 'Không có quyền truy cập vị trí';
    }

    _positionStreamSubscription?.cancel();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (Position position) {
        currentPosition.value = position;
      },
      onError: (error) {
        print('Lỗi khi theo dõi vị trí: $error');
      },
    );
  }

  // Dừng theo dõi vị trí
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  // Tính khoảng cách giữa 2 điểm (theo mét)
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Kiểm tra xem GPS có bật không
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  // Mở cài đặt vị trí
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // Mở cài đặt ứng dụng
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
