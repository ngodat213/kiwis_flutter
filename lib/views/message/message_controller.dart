import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/friendship.model.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/group.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/services/socket.service.dart';
import 'package:kiwis_flutter/views/message/widgets/calander_content.dart';
import 'package:kiwis_flutter/views/message/widgets/chat_room.content.dart';
import 'package:kiwis_flutter/views/message/widgets/create_group.content.dart';
import 'package:kiwis_flutter/views/message/widgets/group_name_content.dart';
import 'package:kiwis_flutter/views/message/widgets/members.content.dart';
import 'package:kiwis_flutter/views/message/widgets/setting_chat_room_content.dart';
import 'package:kiwis_flutter/views/message/widgets/sharemap.content.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageController extends BaseController {
  /// Message content
  final GroupRequest _groupRequest = GroupRequest();
  final ImagePicker _imagePicker = ImagePicker();
  // Controller create group content
  final TextEditingController createGroupNameTEC = TextEditingController();
  RxList<FriendShipModel> selectedFriends = <FriendShipModel>[].obs;
  // Controller chat room content
  final ItemScrollController scrollController = ItemScrollController();
  final TextEditingController messageTEC = TextEditingController();
  final TextEditingController editGroupNameTEC = TextEditingController();

  // Variables
  RxBool isOnchangeAvatar = false.obs;
  Rx<UserModel> user = UserModel().obs;
  Rx<File> editGroupAvatar = File('').obs;
  Rx<MessageModel> currentMessage = MessageModel().obs;

  @override
  void onInit() async {
    super.onInit();
    user.value = await AuthServices.getCurrentUser(force: true) ?? UserModel();
  }

  @override
  void onClose() {
    super.onClose();
  }

  GroupModel get currentGroup => SocketService.currentGroup.value;

  /// Message methods
  void onPressedChanel(BuildContext context, String groupId, GroupModel group) {
    SocketService.currentGroup.value = group;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ChatRoomContent(),
    );
  }

  /// Create group methods
  void onPressedRemoveFriend(FriendShipModel user) {
    if (selectedFriends.contains(user)) {
      selectedFriends.remove(user);
    } else {
      selectedFriends.add(user);
    }
  }

  Future<void> handleCreateGroup(BuildContext context) async {
    try {
      if (selectedFriends.isEmpty || selectedFriends.length < 2) {
        AnimatedSnackBar.material(
          "Please select at least 2 friends",
          type: AnimatedSnackBarType.warning,
        ).show(context);
      } else {
        final members = selectedFriends.map((e) => e.user!.userId!).toList();
        members.add(user.value.userId!);

        final response = await _groupRequest.createGroupRequest(
          name: createGroupNameTEC.text,
          members: members,
        );
        if (response.allGood) {
          Get.back();
          SocketService.addGroup(groupId: response.body['groupId']);
          AnimatedSnackBar.material(
            "Group created successfully",
            type: AnimatedSnackBarType.success,
          ).show(context);
        }
      }
    } catch (err) {
      AnimatedSnackBar.material(
        err.toString(),
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  void onPressedCreateGroup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MenberSettingContent(
        title: "Create group",
        onTap: () => handleCreateGroup(context),
        isCreate: true,
      ),
    );
  }

  /// Chat room methods

  // Handle
  Future<void> pickAvatar() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      editGroupAvatar.value = File(image.path);
      isOnchangeAvatar.value = true;
    }
  }

  Future<void> handleLeaveGroup() async {
    try {
      final response = await _groupRequest.leaveGroupRequest(
        groupId: SocketService.currentGroup.value.groupId!,
      );
      if (response.allGood) {
        SocketService.groups.removeWhere(
          (e) => e.groupId == SocketService.currentGroup.value.groupId!,
        );
        SocketService.groups.refresh();
        Get.offAllNamed(Routes.MAIN);
        Get.snackbar("Leave group", "Leave group successfully");
      }
    } catch (err) {
      Get.snackbar("Leave group", err.toString());
    }
  }

  Future<void> handleBlockUser() async {
    try {
      final group = SocketService.currentGroup.value;
      final response = await _groupRequest.blockUserRequest(
        userId: group.members!.first.user!.userId!,
      );
      if (response.allGood) {
        Get.offAllNamed(Routes.MAIN);
        Get.snackbar("Block user", "Block user successfully");
      }
    } catch (err) {
      Get.snackbar("Block user", err.toString());
    }
  }

  Future<void> handleChangeGroupName(BuildContext context) async {
    try {
      final response = await _groupRequest.editGroupRequest(
        groupId: currentGroup.groupId!,
        name: editGroupNameTEC.text,
        file: editGroupAvatar.value.readAsBytesSync(),
      );

      if (response.allGood) {
        final GroupModel group = GroupModel.fromJson(response.body);
        isOnchangeAvatar.value = false;
        editGroupAvatar.value = File('');
        editGroupNameTEC.clear();
        // Update group
        currentGroup.name = group.name;
        currentGroup.avatar = group.avatar;
        SocketService.groups.refresh();

        Get.back();
        AnimatedSnackBar.material(
          "Group name changed successfully",
          type: AnimatedSnackBarType.success,
        ).show(context);
      } else {
        AnimatedSnackBar.material(
          response.error!,
          type: AnimatedSnackBarType.error,
        ).show(context);
      }
    } catch (err) {
      AnimatedSnackBar.material(
        err.toString(),
        type: AnimatedSnackBarType.error,
      ).show(context);
    }
  }

  void sendMessage() {
    if (messageTEC.text.isNotEmpty) {
      SocketService.sendMessage(messageText: messageTEC.text);
      messageTEC.clear();
    }
  }

  void onPressedShareLocation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShareMapContent(),
    );
  }

  void onPressedCreatePlan() {
    Get.toNamed(
      Routes.PLAN,
      arguments: SocketService.currentGroup.value.groupId!,
    );
  }

  String getGroupName() {
    final group = SocketService.currentGroup.value;
    return group.name ?? group.members!.first.user!.fullName;
  }

  String getAvatarGroup() {
    final group = SocketService.currentGroup.value;
    if (group.avatar != null) {
      return group.avatar!.imageUrl!;
    } else if (isGroupChat()) {
      return AppValues.defaultAvatar;
    }
    return group.members!.first.user!.avatar?.imageUrl ??
        AppValues.defaultAvatar;
  }

  bool isGroupChat() {
    final group = SocketService.currentGroup.value;
    return group.isGroupChat();
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

  /// Setting chat room methods
  void showModalGroupNameSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GroupNameContent(),
    );
  }

  void showModalMembersContent(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MembersContent(),
    );
  }

  void showModalMemberSettingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => MenberSettingContent(
        title: "Add member",
        onTap: () => handleCreateGroup(context),
        isCreate: false,
      ),
    );
  }

  void addMember(FriendShipModel user) {
    selectedFriends.add(user);
  }
}
