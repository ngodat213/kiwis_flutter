import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/requests/group.request.dart';

class MessageController extends BaseController {
  final GroupRequest _groupRequest = GroupRequest();

  // Variables
  RxList<GroupModel> groups = <GroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
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

  void onPressedChanel(GroupModel group) {
    Get.toNamed(Routes.CHAT_ROOM, arguments: group);
  }
}
