import 'package:flutter/material.dart';

/// Class to help with [Tile] responsive
class TileResponsiveHelper {
  /// Create a class who provide the final size of [Tile] width using the actual
  /// screen size provided by MediaQuery.of(context).size
  TileResponsiveHelper(this.context, {this.percentWidth = .95});

  BuildContext context;
  double percentWidth;
  final int _qtTile = 8;

  getTileSize() {
    double finalWidth = _getScreenWidth() * percentWidth;
    if (finalWidth > _getScreenHeight() - 150) {
      finalWidth = _getScreenHeight() * .80;
      double multiplier = .95;
      while(finalWidth > _getScreenWidth()){
        finalWidth *= multiplier;
        multiplier -= .5;
      }
    }
    return finalWidth / _qtTile;
  }

  getTilePadding(){
    return getTileSize() * 0.1;
  }

  _getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  _getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }
}
