import 'board_model.dart';
import 'coordinate_model.dart';
import 'piece_model.dart';

class King extends Piece {
  King(super.actualCoordinate, super.type, super.color, {bool? firstMove}) {
    super.range = 1;
    super.firstMove = firstMove ?? true;
  }

  @override
  List<Coordinate> getPossibleMoves(Board board) {
    return [
      ...getPossibleFrontSquares(board),
      ...getPossibleBackSquares(board),
      ...getPossibleDiagonalFrontSquares(board),
      ...getPossibleDiagonalBackSquares(board),
      ...getPossibleSidesSquares(board),
    ];
  }

  @override
  List<Coordinate> getPossibleAttacks(Board board) {
    return getPossibleMoves(board);
  }

  @override
  King copy(){
    return King(actualCoordinate.copy(), type, color, firstMove: firstMove);
  }

}
