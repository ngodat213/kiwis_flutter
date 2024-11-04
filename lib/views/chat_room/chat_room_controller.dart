import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/calander_content.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/setting_chat_room_content.dart';

class ChatRoomController extends BaseController {
  void showModalCalenderSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CalenderContent(),
    );
  }

  void showModalSettingChatRoomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SettingChatRoomContent(),
    );
  }
}
