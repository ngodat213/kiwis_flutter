import 'package:flutter/widgets.dart';
import 'package:kiwis_flutter/views/home/home_view.dart';
import 'package:kiwis_flutter/views/message/message_view.dart';

class MainScreenModel {
  final List<Widget> screens = [
    HomeScreen(),
    MessageScreen(),
  ];
}
