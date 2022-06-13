import 'board_model.dart';
import 'coordinate_model.dart';
import 'piece_model.dart';

class Pawn extends Piece {
  Pawn(super.actualCoordinate, super.type, super.color) {
    super.range = 1;
    initialCoordinate = actualCoordinate;
  }

  late Coordinate initialCoordinate;

  @override
  List<Coordinate> getPossibleMoves(Board board) {
    if (!initialCoordinate.isEqualAs(actualCoordinate)) range = 1;
    final possibleMoves = <Coordinate>[];
    final frontSquares = getPossibleFrontSquares(board);
    final diagonalFrontSquares = getPossibleDiagonalFrontSquares(board);
    for (var element in frontSquares) {
      if (board.getSquare(element).piece == null) {
        possibleMoves.add(element);
      }
    }
    for (var element in diagonalFrontSquares) {
      if (board.getSquare(element).piece != null) {
        if (element.y == actualCoordinate.y + 1 ||
            element.y == actualCoordinate.y - 1) {
          possibleMoves.add(element);
        }
      }
    }
    return possibleMoves;
  }

  @override
  List<Coordinate> getPossibleAttacks(Board board) {
    return getPossibleDiagonalFrontSquares(board);
  }
}
