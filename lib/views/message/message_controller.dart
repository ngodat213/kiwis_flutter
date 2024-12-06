import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/user.models.dart';
import 'package:kiwis_flutter/requests/group.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:kiwis_flutter/views/message/widgets/create_group.content.dart';

class MessageController extends BaseController {
  final GroupRequest _groupRequest = GroupRequest();

  // Variables
  Rx<UserModel> user = UserModel().obs;
  RxList<GroupModel> groups = <GroupModel>[].obs;

  // Create group content
  final TextEditingController groupNameTEC = TextEditingController();
  RxList<String> selectedFriends = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    user.value = AuthServices.currentUser!;
    initGroups();
  }

  Future<void> initGroups() async {
    final response = await _groupRequest.getGroupRequest();
    if (response.allGood) {
      for (var e in response.body) {
        groups.value.add(GroupModel.fromJson(e));
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onPressedCreateGroup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CreateGroupContent(),
    );
  }

  void onPressedChanel(GroupModel group) {
    Get.toNamed(Routes.CHAT_ROOM, arguments: group);
  }
}
