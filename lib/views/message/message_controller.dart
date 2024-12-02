import 'package:kiwis_flutter/core/base/base.controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/manager/manager.socket.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/requests/group.request.dart';

class MessageController extends BaseController {
  final GroupRequest _groupRequest = GroupRequest();

  // Variables
  List<GroupModel> groupList = [];

  @override
  void onInit() {
    super.onInit();
    getGroupList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getGroupList() async {
    var response = await _groupRequest.getGroupRequest();
    if (response.allGood) {
      for (var e in response.body) {
        this.groupList.add(GroupModel.fromJson(e));
      }
    }
  }

  void onPressedChanel(String idChannel) {
    Get.toNamed(Routes.CHAT_ROOM, arguments: idChannel);
  }
}
