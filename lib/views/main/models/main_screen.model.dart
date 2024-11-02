import 'package:flutter/widgets.dart';
import 'package:kiwis_flutter/views/home/home_view.dart';
import 'package:kiwis_flutter/views/menu/menu_view.dart';

class MainScreenModel {
  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    MenuScreen()
  ];
}
