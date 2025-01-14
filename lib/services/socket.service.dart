import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/models/cost.model.dart';
import 'package:kiwis_flutter/models/friendship.model.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/post.model.dart';
import 'package:kiwis_flutter/models/task.model.dart';
import 'package:kiwis_flutter/requests/group.request.dart';
import 'package:kiwis_flutter/requests/plan.request.dart';
import 'package:kiwis_flutter/requests/upload_realtime.request.dart';
import 'package:kiwis_flutter/requests/user.request.dart';
import 'package:kiwis_flutter/services/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  final GroupRequest _groupRequest = GroupRequest();
  final UserRequest _userRequest = UserRequest();
  final PlanRequest _planRequest = PlanRequest();
  final UploadRealtimeRequest _postRequest = UploadRealtimeRequest();
  //
  static RxList<FriendShipModel> friends = <FriendShipModel>[].obs;
  static RxList<GroupModel> groups = <GroupModel>[].obs;
  static RxList<PlanModel> plans = <PlanModel>[].obs;
  static RxList<PostModel> posts = <PostModel>[].obs;
  static RxList<CostModel> planCostsByDay = <CostModel>[].obs;

  // Current
  static Rx<GroupModel> currentGroup = GroupModel().obs;
  static Rx<PlanModel> currentPlan = PlanModel().obs;
  static RxList<TaskModel> taskByDay = <TaskModel>[].obs;
  static Rxn<TaskModel> taskChange = Rxn<TaskModel>();
  static Rx<DateTime> taskDate = Rx<DateTime>(DateTime.now());

  // Socket instance
  // Socket instance
  static IO.Socket? socket;

  Future<SocketService> init({String? userId}) async {
    initSocket(userId: userId);
    await _handleInitGroup();
    await _handleInitPost();
    await _handleInitFriend();
    await _handleInitPlans();
    return this;
  }

  // Initialize the socket connection
  void initSocket({String? userId}) {
    print("Initializing socket with userId: $userId");

    try {
      // Build the socket connection
      socket = IO.io(
        AppAPI.domainSocket,
        IO.OptionBuilder()
            .setPath('/socket.io')
            .setTransports(['websocket'])
            .setQuery({'userId': userId})
            .enableAutoConnect()
            .build(),
      );

      // Connect to the socket
      socket?.connect();

      // Register
      socket?.emit(AppAPI.socketRegister, {
        'userId': userId!,
      });

      // Set up socket event listeners
      socket?.on(AppAPI.socketReceiveFriendRequest, (data) {
        final FriendShipModel friendship = FriendShipModel.fromJson(data);
        friends.removeWhere((e) => e.friendshipId == friendship.friendshipId);
        friends.insert(0, friendship);
        friends.refresh();
      });

      socket?.on(AppAPI.socketAcceptFriendRequest, (data) {
        _handleInitGroup();
        final FriendShipModel friendship = FriendShipModel.fromJson(data);
        friends.removeWhere((e) => e.friendshipId == friendship.friendshipId);
        friends.insert(0, friendship);
        friends.refresh();
      });

      socket?.on(AppAPI.socketReceivePost, (data) {
        final PostModel post = PostModel.fromJson(data);
        posts.insert(0, post);
        posts.refresh();
      });

      /// Group
      socket?.on(AppAPI.socketRefreshGroup, (data) async {
        _handleInitGroup();
      });

      socket?.on(AppAPI.socketReceiveGroupMessage, (data) {
        final message = MessageModel.fromJson(data);
        final group = groups.firstWhere((e) => e.groupId == message.groupId);
        group.messages?.add(message);
        groups.removeWhere((e) => e.groupId == message.groupId);
        groups.insert(0, group);
        groups.refresh();
        currentGroup.refresh();
      });

      /// Plan
      socket?.on(AppAPI.socketAddPlan, (data) {
        final plan = PlanModel.fromJson(data);
        plans.insert(0, plan);
        plans.refresh();
      });

      socket?.on(AppAPI.socketAddRefreshPlan, (data) async {
        final plan = PlanModel.fromJson(data);
        plans.removeWhere((e) => e.planId == plan.planId);
        plans.insert(0, plan);
        plans.refresh();
      });

      /// Task
      socket?.on(AppAPI.socketAddTask, (data) {
        final task = TaskModel.fromJson(data);
        if (task.taskId != null && task.planId == currentPlan.value.planId) {
          taskByDay.insert(0, task);
          taskByDay.refresh();
          currentPlan.value.tasks?.add(task);
          currentPlan.refresh();
          getTasksByDate(taskDate.value);
        }
      });

      /// Cost
      socket?.on(AppAPI.socketAddCost, (data) {
        final cost = CostModel.fromJson(data);
        if (cost.planId == currentPlan.value.planId) {
          currentPlan.value.planCosts?.add(cost);
          currentPlan.refresh();
          getCostSharingByDate(taskDate.value);
        }
      });

      print('Socket initialized successfully');
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  static void onChangeTask(TaskModel task) {
    if (taskChange.value == task) {
      taskChange.value = null;
    } else {
      taskChange.value = task;
    }
  }

  static void getCostSharingByDate(DateTime? date) {
    SocketService.planCostsByDay.value = [];
    taskDate.value = date ?? currentPlan.value.startDate!;
    date = date ?? currentPlan.value.startDate!;

    var allCost = currentPlan.value.planCosts ?? [];

    SocketService.planCostsByDay.value = allCost.where((cost) {
      DateTime? createdAt =
          cost.createdAt != null ? DateTime.tryParse(cost.createdAt!) : null;
      if (createdAt == null) return false;
      if (createdAt.isBefore(currentPlan.value.startDate!)) {
        return true;
      }

      return createdAt.year == date!.year &&
          createdAt.month == date.month &&
          createdAt.day == date.day;
    }).toList();
    SocketService.planCostsByDay.refresh();
  }

  /// Handle

  Future<void> _handleInitGroup() async {
    final response = await _groupRequest.getGroupRequest();
    if (response.allGood) {
      groups.clear();
      for (var e in response.body) {
        groups.add(GroupModel.fromJson(e));
      }
      groups.refresh();
    }
  }

  Future<void> _handleInitPost() async {
    final response = await _postRequest.getRealtimeRequest();
    if (response.allGood) {
      posts.clear();
      for (var e in response.body) {
        posts.add(PostModel.fromJson(e));
      }
      posts.refresh();
    }
  }

  Future<void> _handleInitFriend() async {
    final response = await _userRequest.getAllFriendsRequest();
    if (response.allGood) {
      friends.clear();
      for (var e in response.body) {
        friends.add(FriendShipModel.fromJson(e));
      }
      friends.refresh();
    }
  }

  Future<void> _handleInitPlans() async {
    final ApiResponse response = await _planRequest.getPlanRequest();
    if (response.allGood) {
      for (var e in response.body) {
        plans.add(PlanModel.fromJson(e));
        plans.refresh();
      }
    }
    print(plans.length);
  }

  static void getTasksByDate(DateTime? date) {
    taskDate.value = date ?? currentPlan.value.startDate!;
    date = date ?? currentPlan.value.startDate!;
    var allTasks = currentPlan.value.tasks ?? [];

    taskByDay.value = allTasks.where((task) {
      DateTime? startDate =
          task.startDate != null ? DateTime.tryParse(task.startDate!) : null;
      DateTime? endDate =
          task.endDate != null ? DateTime.tryParse(task.endDate!) : null;

      if (startDate == null || endDate == null) return false;

      DateTime startDay =
          DateTime(startDate.year, startDate.month, startDate.day);
      DateTime endDay = DateTime(endDate.year, endDate.month, endDate.day);
      DateTime targetDay = DateTime(date!.year, date.month, date.day);

      return targetDay.isAtSameMomentAs(startDay) ||
          targetDay.isAtSameMomentAs(endDay) ||
          (targetDay.isAfter(startDay) && targetDay.isBefore(endDay));
    }).toList();
    taskByDay.refresh();
  }

  /// Emit
  static void addTask({
    required String taskId,
    required String groupId,
  }) {
    socket?.emit(AppAPI.socketAddTask, {
      'taskId': taskId,
      'groupId': groupId,
    });
  }

  static void addExpense({
    required String expenseId,
    required String groupId,
  }) {
    socket?.emit(AppAPI.socketAddCost, {
      'expenseId': expenseId,
      'groupId': groupId,
    });
  }

  static void sendPost({
    required String postId,
  }) {
    socket?.emit(AppAPI.socketSendPost, {
      'postId': postId,
    });
  }

  static void sendComment({
    required String senderId,
    required String postId,
    required String messageText,
  }) {
    socket?.emit(AppAPI.socketSendComment, {
      'senderId': senderId,
      'postId': postId,
      'messageText': messageText,
    });
  }

  static void sendAddFriend({
    required String userId,
    required String friendShipId,
  }) {
    socket?.emit(AppAPI.socketAddFriend, {
      'userId': userId,
      'friendShipId': friendShipId,
    });
  }

  static void acceptFriend({
    required String userId,
    required String receiverId,
  }) {
    socket?.emit(AppAPI.socketAcceptFriend, {
      'userId': userId,
      'receiverId': receiverId,
    });
  }

  static void addPlan({
    required String? userId,
    required String? groupId,
    required String planId,
  }) {
    socket?.emit(AppAPI.socketAddPlan, {
      'userId': userId,
      'planId': planId,
      'groupId': groupId,
    });
  }

  static void addCost({
    required String? planId,
    required String? groupId,
  }) {
    socket?.emit(AppAPI.socketAddCost, {
      'planId': planId,
      'groupId': groupId,
    });
  }

  static void addRefreshPlan({
    required String? planId,
    required String? groupId,
  }) {
    socket?.emit(AppAPI.socketAddTask, {
      'planId': planId,
      'groupId': groupId,
    });
  }

  static void addGroup({
    required String groupId,
  }) {
    socket?.emit(AppAPI.socketRefreshGroup, {
      'groupId': groupId,
    });
  }

  // Send a message to a group
  static void sendMessage({
    required String messageText,
    String? postId,
  }) {
    final String senderId = AuthServices.currentUser!.userId!;
    socket?.emit(AppAPI.socketGroupMessage, {
      'senderId': senderId,
      'groupId': currentGroup.value.groupId!,
      'messageText': messageText,
      'postId': postId,
    });
    print('Group message sent: $messageText');
  }

  // Disconnect the socket
  static void disconnect() {
    socket?.disconnect();
  }
}
