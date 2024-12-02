import 'package:socket_io_client/socket_io_client.dart' as IO;

class ManagerSocket {
  // Private constructor for singleton pattern
  ManagerSocket._();

  static final ManagerSocket instance = ManagerSocket._();

  // Socket instance
  IO.Socket? _socket;

  // Initialize the socket connection
  void initSocket({required String domain, String? userId}) {
    print("Initializing socket with userId: $userId");

    try {
      // Build the socket connection
      _socket = IO.io(
        domain,
        IO.OptionBuilder()
            .setPath('/socket.io')
            .setTransports(['websocket'])
            .setQuery({'userId': userId})
            .enableAutoConnect()
            .build(),
      );

      // Connect to the socket
      _socket?.connect();

      // Set up socket event listeners
      _socket?.on('connect', (_) {
        print('Connected to socket server');
      });

      _socket?.on('disconnect', (_) {
        print('Disconnected from socket server');
      });

      _socket?.on('receive_message', (data) {
        print('Received message: $data');
        // Handle incoming message logic here
      });

      _socket?.on('receive_group_message', (data) {
        print('Received group message: $data');
        // Handle incoming group message logic here
      });

      print('Socket initialized successfully');
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  // Send a message to a user
  void sendMessage(String senderId, String recipientId, String messageText) {
    _socket?.emit('send_message', {
      'senderId': senderId,
      'recipientId': recipientId,
      'messageText': messageText,
    });
    print('Message sent: $messageText');
  }

  // Send a message to a group
  void sendGroupMessage(String senderId, String groupId, String messageText) {
    _socket?.emit('send_group_message', {
      'senderId': senderId,
      'groupId': groupId,
      'messageText': messageText,
    });
    print('Group message sent: $messageText');
  }

  // Disconnect the socket
  void disconnect() {
    _socket?.disconnect();
    print('Socket disconnected');
  }
}
