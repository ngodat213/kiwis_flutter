import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenController extends GetxController {
  Timer? _timer;

  void monitorToken() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("Không có người dùng đăng nhập.");
      return;
    }

    final idTokenResult = await user.getIdTokenResult();
    final expiryTime = idTokenResult.expirationTime;
    final currentTime = DateTime.now();

    if (expiryTime != null) {
      final durationUntilExpiry = expiryTime.difference(currentTime);
      final refreshDuration = durationUntilExpiry - Duration(minutes: 5);

      if (refreshDuration.isNegative) {
        await _refreshToken();
      } else {
        _timer = Timer(refreshDuration, () async {
          await _refreshToken();
        });
      }
    }
  }

  Future<void> _refreshToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.getIdToken(true);
      print("Token đã được làm mới.");
    }
  }

  void stopMonitoring() {
    _timer?.cancel();
    _timer = null;
    print("Đã dừng theo dõi token.");
  }

  @override
  void onClose() {
    stopMonitoring();
    super.onClose();
  }
}
