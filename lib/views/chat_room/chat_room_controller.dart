import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/calander_content.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/setting_chat_room_content.dart';

class ChatRoomController extends BaseController {
  // Arguments
  Rx<GroupModel> group = GroupModel().obs;
  // Variables
  Rx<UserModel> user = UserModel().obs;
  final TextEditingController messageTEC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    user.value = AuthServices.currentUser!;
    group.value = Get.arguments;
    listenMessage();
  }

  void sendMessage() {
    ManagerSocket.sendMessage(
      user.value.userId!,
      group.value.groupId!,
      messageTEC.text,
    );
    messageTEC.clear();
  }

  void listenMessage() {
    ManagerSocket.socket?.on(AppAPI.socketReceiveGroupMessage, (data) {
      print('Received group message: $data');
      final message = MessageModel.fromJson(data);
      group.value.messages?.add(message);
      group.refresh();
    });
  }

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
