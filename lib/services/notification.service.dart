import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  late FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  @override
  Future<NotificationService> init() async {
    try {
      await _initializeNotifications();
      await _initializeFirebaseMessaging();

      return this;
    } catch (e) {
      print('Lỗi khởi tạo NotificationService: $e');
      rethrow;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeNotifications();
    await _initializeFirebaseMessaging();
  }

  Future<void> _initializeNotifications() async {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); // Thay bằng icon của bạn
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  Future<void> _initializeFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    print('FirebaseMessagingToken: $token');
    // Yêu cầu quyền
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Lắng nghe thông báo
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedNotification);
  }

  // Xử lý khi nhận thông báo foreground
  Future<void> _handleForegroundNotification(RemoteMessage message) async {
    String title = message.notification?.title ?? "Không có tiêu đề";
    String body = message.notification?.body ?? "Không có nội dung";

    // Hiển thị thông báo cục bộ
    await _showLocalNotification(title, body);
  }

  // Hiển thị thông báo
  Future<void> _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel', // ID của kênh
      'Thông báo quan trọng', // Tên kênh
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // ID thông báo
      title,
      body,
      platformDetails,
    );
  }

  // Xử lý khi người dùng nhấn vào thông báo
  void _onSelectNotification(NotificationResponse response) {
    print('Người dùng nhấn vào thông báo: ${response.payload}');
    // Thêm logic điều hướng nếu cần
  }

  // Xử lý khi thông báo được mở từ background hoặc terminated
  void _handleOpenedNotification(RemoteMessage message) {
    print('Thông báo được mở: ${message.notification?.title}');
    // Thêm logic điều hướng nếu cần
  }
}
