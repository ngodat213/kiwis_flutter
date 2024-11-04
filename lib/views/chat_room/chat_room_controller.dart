import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/chat_room/chat_room_view.dart';

class ChatRoomController extends BaseController {
  void showModalCalenderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CalenderView(),
    );
  }

  void showModalSettingChatRoomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SettingChatRoom(),
    );
  }
}
