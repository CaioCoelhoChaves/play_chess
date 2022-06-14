import 'package:play_chess/app/data/enum/piece_enums.dart';

import 'board_model.dart';
import 'coordinate_model.dart';
import 'piece_model.dart';

class Pawn extends Piece {
  Pawn(super.actualCoordinate, super.type, super.color) {
    super.range = 2;
    initialCoordinate = actualCoordinate;
  }

  late final Coordinate initialCoordinate;

  @override
  void onMove(Coordinate target){
    super.onMove(target);
    range = 1;
  }

  @override
  List<Coordinate> getPossibleMoves(Board board) {
    final possibleMoves = <Coordinate>[];
    final frontSquares = getPossibleFrontSquares(board);
    final diagonalFrontSquares = getPossibleDiagonalFrontSquares(board);
    for (var element in frontSquares) {
      if (board.getSquare(element).piece == null) {
        possibleMoves.add(element);
      }
    }
    for (var element in diagonalFrontSquares) {
      if (board.getSquare(element).piece != null ||
          (board.enPassant != null && board.enPassant!.isEqualAs(element))) {
        if (element.y == actualCoordinate.y + 1 ||
            element.y == actualCoordinate.y - 1) {
          possibleMoves.add(element);
        }
      }
    }
    return possibleMoves;
  }

  /// Call this method before move the piece
  @override
  bool enableEnPassant(Coordinate target) {
    var enPassantCoordinate = color == PieceColor.BLACK
        ? initialCoordinate.sumCoordinate(2, 0)
        : initialCoordinate.sumCoordinate(-2, 0);
    if (firstMove && target.isEqualAs(enPassantCoordinate)) {
      return true;
    }
    return false;
  }

  @override
  List<Coordinate> getPossibleAttacks(Board board) {
    return getPossibleDiagonalFrontSquares(board);
  }
}
