import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatRoomView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatRoomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
