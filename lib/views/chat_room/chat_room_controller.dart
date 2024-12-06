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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatRoomController extends BaseController {
  // Controller
  late ItemScrollController scrollController;
  final TextEditingController messageTEC = TextEditingController();
  // Arguments
  Rx<GroupModel> group = GroupModel().obs;
  // Variables
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = AuthServices.currentUser!;
    group.value = Get.arguments;
    scrollController = ItemScrollController();
    listenMessage();
    // _scrollToBottom();
  }

  void _scrollToBottom() {
    if (group.value.messages!.isNotEmpty) {
      scrollController.scrollTo(
        index: group.value.messages!.length - 1,
        duration: Duration(milliseconds: 300),
      );
    }
  }

  void sendMessage() {
    ManagerSocket.sendMessage(
      user.value.userId!,
      group.value.groupId!,
      messageTEC.text,
    );
    messageTEC.clear();
  }

  String getGroupName() {
    return group.value.name ?? group.value.members!.first.user!.fullName;
  }

  String getAvatarGroup() {
    return group.value.avatar?.imageUrl ??
        group.value.members!.first.user!.avatar?.imageUrl ??
        AppValues.defaultAvatar;
  }

  bool isGroupChat() {
    return group.value.isGroupChat();
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
