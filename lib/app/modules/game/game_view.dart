import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_chess/app/modules/game/widgets/tile.dart';

import '../../data/model/coordinate_model.dart';
import 'game_controller.dart';

class GameView extends GetView<GameController> {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play chess"),
      ),
      body: Column(
        children: [
          for (int x = 0; x < 8; x++) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int y = 0; y < 8; y++) ...[
                  Obx(
                    () => Tile(
                      model: controller.board.value.getSquare(
                        Coordinate(x, y),
                      ),
                    ),
                  )
                ]
              ],
            )
          ],
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Qt.Whites: ${controller.board.value.getQtWhites()}"),
                  Text("Qt.Blacks: ${controller.board.value.getQtBlacks()}")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
