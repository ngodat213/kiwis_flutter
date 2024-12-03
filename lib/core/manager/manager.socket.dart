import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ManagerSocket {
  // Private constructor for singleton pattern
  ManagerSocket._();

  // Socket instance
  static IO.Socket? socket;

  // Initialize the socket connection
  static void initSocket({required String domain, String? userId}) {
    print("Initializing socket with userId: $userId");

    try {
      // Build the socket connection
      socket = IO.io(
        domain,
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
      socket?.on(AppAPI.socketConnect, (_) {
        print('Connected to socket server');
      });

      socket?.on(AppAPI.socketDisconnect, (_) {
        print('Disconnected from socket server');
      });

      socket?.on(AppAPI.socketReceiveGroupMessage, (data) {
        print('Received group message: $data');
        // final message = MessageModel.fromJson(data);
        // final group = groups.firstWhere((e) => e.groupId == message.groupId);
        // group.messages?.add(message);
      });

      print('Socket initialized successfully');
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  // Send a message to a group
  static void sendMessage(String senderId, String groupId, String messageText) {
    socket?.emit(AppAPI.socketGroupMessage, {
      'senderId': senderId,
      'groupId': groupId,
      'messageText': messageText,
    });
    print('Group message sent: $messageText');
  }

  // Disconnect the socket
  static void disconnect() {
    socket?.disconnect();
    print('Socket disconnected');
  }
}
