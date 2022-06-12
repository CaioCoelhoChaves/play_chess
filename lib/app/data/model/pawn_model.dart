import '../enum/piece_enums.dart';
import 'board_model.dart';
import 'coordinate_model.dart';
import 'piece_model.dart';

class Pawn extends Piece {
  Pawn(super.actualCoordinate, super.type, super.color){
    super.allowedMovements = [
      MovementEnum.TOP_LEFT, MovementEnum.TOP, MovementEnum.TOP_RIGHT
    ];
    super.range = 1;
  }

  @override
  List<Coordinate> getPossibleMoves(Board board) {
    return [
      ...getPossibleTopRightAttacks(board),
      ...getPossibleTopLeftAttacks(board),
      ...getPossibleTopAttacks(board)
    ];
  }

  @override
  List<Coordinate> getPossibleAttacks(Board board){
    return [
      ...getPossibleTopRightAttacks(board),
      ...getPossibleTopLeftAttacks(board)
    ];
  }

}
