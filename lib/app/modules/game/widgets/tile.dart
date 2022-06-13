import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../config/helpers/tile_responsive_helper.dart';
import '../../../data/model/piece_model.dart';
import '../../../data/model/square_model.dart';
import '../game_controller.dart';

class Tile extends StatefulWidget {
  const Tile({Key? key, required this.model}) : super(key: key);
  final Square model;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  final controller = Get.find<GameController>();
  late TileResponsiveHelper responsiveHelper;

  @override
  Widget build(BuildContext context) {
    responsiveHelper = TileResponsiveHelper(context);
    return SizedBox(
      width: responsiveHelper.getTileSize(),
      height: responsiveHelper.getTileSize(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _square(),
          _piece(),
          _dragBarrier(),
          _debugCoordinate(),
          _dragTarget(),
        ],
      ),
    );
  }

  Widget _square() {
    return Visibility(
      visible: !widget.model.canMove,
      replacement: Container(color: Colors.red),
      child: Image.asset(widget.model.squareImagePath, fit: BoxFit.fill),
    );
  }

  Widget _piece() {
    if (widget.model.piece != null) {
      return Draggable<Piece>(
        data: widget.model.piece,
        feedback:
            Image.asset(widget.model.piece!.getImagePath(), fit: BoxFit.fill),
        childWhenDragging: const SizedBox(),
        onDragStarted: () => controller.onDragPiece(widget.model.piece!),
        onDragEnd: (_) => controller.onDragPieceEnd(),
        child: Padding(
          padding: EdgeInsets.all(responsiveHelper.getTilePadding()),
          child: Image.asset(
            widget.model.piece!.getImagePath(),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget _debugCoordinate() {
    return Visibility(
      visible: AppConfig.debugMode,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          widget.model.coordinate.toString(),
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _dragTarget() {
    return DragTarget<Piece>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return const SizedBox();
      },
      onAccept: (Piece piece) => controller.movePieceTo(piece, widget.model),
    );
  }

  Widget _dragBarrier() {
    return Visibility(
      visible: widget.model.piece != null &&
          !controller.isPieceTurn(widget.model.piece!.color),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.transparent,
      ),
    );
  }

}
