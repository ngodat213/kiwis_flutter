import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietmap_gl_platform_interface/vietmap_gl_platform_interface.dart'
    as vietmap;
import '../services/map.service.dart';
import '../models/address.model.dart';

class LocationSearchController extends GetxController {
  static LocationSearchController get to => Get.find();
  final MapService _mapService = MapService.to;

  // Observable variables
  final searchResults = <AddressModel>[].obs;
  final isSearching = false.obs;
  final currentQuery = ''.obs;

  // Debouncer để tránh gọi API quá nhiều
  final _debouncer = Debouncer(milliseconds: 500);

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    currentQuery.value = query;
    _debouncer.run(() => _performSearch(query));
  }

  Future<void> _performSearch(String query) async {
    try {
      isSearching.value = true;

      String myLatLng = "";
      final currentLocation = _mapService.selectedLocation.value;
      if (currentLocation != null) {
        myLatLng = "${currentLocation.latitude},${currentLocation.longitude}";
      }

      final apiKey = _mapService.apiKey;
      final url = 'https://maps.vietmap.vn/api/autocomplete/v3';

      final response = await _mapService.dio.get(
        url,
        queryParameters: {
          'apikey': apiKey,
          'text': query,
          'circle_center': myLatLng,
          'size': 10,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data;

        // Dùng Future.wait để đợi tất cả tọa độ được lấy trước khi cập nhật searchResults
        final updatedResults = await Future.wait(results.map((result) async {
          final address = AddressModel.fromMap(result);

          // Lấy tọa độ nếu cần
          if (address.id != null) {
            final coordinates = await getCoordinates(address.id!);
            if (coordinates != null) {
              address.coordinates = coordinates;
            }
          }

          return address;
        }));

        searchResults.value = updatedResults;
      }
    } catch (e) {
      print('Lỗi khi tìm kiếm địa điểm: $e');
      searchResults.clear();
      Get.snackbar(
        'Lỗi',
        'Không thể tìm kiếm địa điểm',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    } finally {
      isSearching.value = false;
    }
  }

  // Thêm phương thức để lấy tọa độ từ ref_id
  Future<vietmap.LatLng?> getCoordinates(String refId) async {
    try {
      final response = await _mapService.dio.get(
        'https://maps.vietmap.vn/api/place/v3',
        queryParameters: {
          'apikey': _mapService.apiKey,
          'refid': refId,
        },
      );

      if (response.statusCode == 200 &&
          response.data['lat'] != null &&
          response.data['lng'] != null) {
        // Cập nhật để lấy lat và lng từ JSON
        return vietmap.LatLng(
          response.data['lat'].toDouble(),
          response.data['lng'].toDouble(),
        );
      }
    } catch (e) {
      print('Lỗi khi lấy tọa độ: $e');
    }
    return null;
  }

  void selectLocation(AddressModel address) async {
    try {
      if (address.coordinates != null) {
        // Di chuyển map đến vị trí được chọn
        await _mapService.animateToLocation(address.coordinates!);

        // Thêm marker
        await _mapService.clearMarkers();
        await _mapService.addMarker(address.coordinates!);

        // Cập nhật vị trí được chọn
        _mapService.selectedLocation.value = address.coordinates;

        // Xóa kết quả tìm kiếm
        searchResults.clear();
        currentQuery.value = '';

        Get.snackbar(
          'Thành công',
          'Đã chọn địa điểm',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể lấy tọa độ địa điểm',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
        );
      }
    } catch (e) {
      print('Lỗi khi chọn địa điểm: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể chọn địa điểm',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
      );
    }
  }
}

// Utility class để debounce search requests
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
