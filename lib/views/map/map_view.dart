import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import '../controllers/map_controller.dart';

class MapView extends BaseView<MapController> {
  MapView({super.key});
  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MapView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
