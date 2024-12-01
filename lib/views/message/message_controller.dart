import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';

class MessageController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    ManagerSocket.socket.clearListeners();
    super.onClose();
  }

  void onPressedChanel(int idChannel) {
    ManagerSocket.initSocket(idChannel: idChannel);
    Get.toNamed(Routes.CHAT_ROOM, arguments: idChannel);
  }
}
