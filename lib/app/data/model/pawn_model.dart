import 'board_model.dart';
import 'coordinate_model.dart';
import 'piece_model.dart';

class Pawn extends Piece {
  Pawn(super.actualCoordinate, super.type, super.color) {
    super.range = 1;
  }

  @override
  List<Coordinate> getPossibleMoves(Board board) {
    final possibleMoves = <Coordinate>[];
    final frontSquares = getPossibleFrontSquares(board);
    final diagonalFrontSquares = getPossibleDiagonalFrontSquares(board);
    if (frontSquares.isNotEmpty &&
        board.getSquare(frontSquares.first).piece == null) {
      possibleMoves.add(frontSquares.first);
    }
    if (diagonalFrontSquares.isNotEmpty) {
      for(int i = 0; i < diagonalFrontSquares.length; i++){
        if(board.getSquare(diagonalFrontSquares[i]).piece != null){
          possibleMoves.add(diagonalFrontSquares[i]);
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
