import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Play chess!", style: TextStyle(fontSize: 22.0)),
            const SizedBox(height: 10.0),
            MaterialButton(
              onPressed: controller.goTo2PlayersGame,
              color: Colors.black54,
              child: const Text("2 Players", style: TextStyle(fontSize: 16.0, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
