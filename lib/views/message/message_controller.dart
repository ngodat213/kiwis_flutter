import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/friendship.model.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/group.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/message/widgets/calander_content.dart';
import 'package:kiwis_flutter/views/message/widgets/chat_room.content.dart';
import 'package:kiwis_flutter/views/message/widgets/create_group.content.dart';
import 'package:kiwis_flutter/views/message/widgets/group_name_content.dart';
import 'package:kiwis_flutter/views/message/widgets/members.content.dart';
import 'package:kiwis_flutter/views/message/widgets/setting_chat_room_content.dart';
import 'package:kiwis_flutter/views/message/widgets/sharemap.content.dart';
import 'package:kiwis_flutter/views/plan/plan_view.dart';
import 'package:kiwis_flutter/views/plan/widgets/plan_create.content.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MessageController extends BaseController {
  /// Message content
  final GroupRequest _groupRequest = GroupRequest();
  final ImagePicker _imagePicker = ImagePicker();
  // Controller create group content
  final TextEditingController createGroupNameTEC = TextEditingController();
  RxList<FriendshipModel> selectedFriends = <FriendshipModel>[].obs;
  // Controller chat room content
  final ItemScrollController scrollController = ItemScrollController();
  final TextEditingController messageTEC = TextEditingController();
  final TextEditingController editGroupNameTEC = TextEditingController();

  // Variables
  RxInt currentGroupIndex = 0.obs;
  RxBool isOnchangeAvatar = false.obs;
  Rx<UserModel> user = UserModel().obs;
  Rx<File> editGroupAvatar = File('').obs;
  RxList<GroupModel> groups = <GroupModel>[].obs;
  Rx<MessageModel> currentMessage = MessageModel().obs;

  @override
  void onInit() async {
    super.onInit();
    user.value = await AuthServices.getCurrentUser(force: true) ?? UserModel();
    initGroups();
    listenerGroup();
  }

  @override
  void onClose() {
    super.onClose();
  }

  GroupModel get currentGroup => groups.value[currentGroupIndex.value];

  /// Message methods
  void onPressedChanel(BuildContext context, int index) {
    currentGroupIndex.value = index;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ChatRoomContent(),
    );
  }

  Future<void> initGroups() async {
    groups.value.clear();
    final response = await _groupRequest.getGroupRequest();
    if (response.allGood) {
      for (var e in response.body) {
        groups.value.add(GroupModel.fromJson(e));
      }
    }
  }

  void listenerGroup() {
    ManagerSocket.socket?.on(AppAPI.socketReceiveGroupMessage, (data) {
      print('Received group message: $data');
      final message = MessageModel.fromJson(data);
      final group = groups.value[currentGroupIndex.value];
      group.messages?.add(message);
      groups.refresh();
    });
  }

  /// Create group methods
  void onPressedRemoveFriend(FriendshipModel user) {
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
        groupId: groups.value[currentGroupIndex.value].groupId!,
      );
      if (response.allGood) {
        groups.value.removeAt(currentGroupIndex.value);
        groups.refresh();
        Get.offAllNamed(Routes.MAIN);
        Get.snackbar("Leave group", "Leave group successfully");
      }
    } catch (err) {
      Get.snackbar("Leave group", err.toString());
    }
  }

  Future<void> handleBlockUser() async {
    try {
      final response = await _groupRequest.blockUserRequest(
        userId:
            groups.value[currentGroupIndex.value].members!.first.user!.userId!,
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
        groupId: groups.value[currentGroupIndex.value].groupId!,
        name: editGroupNameTEC.text,
        file: editGroupAvatar.value.readAsBytesSync(),
      );

      if (response.allGood) {
        final GroupModel group = GroupModel.fromJson(response.body);
        isOnchangeAvatar.value = false;
        editGroupAvatar.value = File('');
        editGroupNameTEC.clear();
        // Update group
        groups.value[currentGroupIndex.value].name = group.name;
        groups.value[currentGroupIndex.value].avatar = group.avatar;
        groups.refresh();

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
      ManagerSocket.sendMessage(
        senderId: user.value.userId!,
        groupId: groups.value[currentGroupIndex.value].groupId!,
        messageText: messageTEC.text,
      );
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
      arguments: groups.value[currentGroupIndex.value].groupId!,
    );
  }

  String getGroupName() {
    final group = groups.value[currentGroupIndex.value];
    return group.name ?? group.members!.first.user!.fullName;
  }

  String getAvatarGroup() {
    final group = groups.value[currentGroupIndex.value];
    if (group.avatar != null) {
      return group.avatar!.imageUrl!;
    } else if (isGroupChat()) {
      return AppValues.defaultAvatar;
    }
    return group.members!.first.user!.avatar?.imageUrl ??
        AppValues.defaultAvatar;
  }

  bool isGroupChat() {
    final group = groups.value[currentGroupIndex.value];
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

  void addMember(FriendshipModel user) {
    selectedFriends.add(user);
  }
}
