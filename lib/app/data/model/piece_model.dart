import '../../config/constants/app_constants.dart';
import '../enum/piece_enums.dart';
import 'board_model.dart';
import 'coordinate_model.dart';
import 'square_model.dart';

abstract class Piece {
  /// Create a Piece, don't forget to late initialize allowedMovements and range
  Piece(this.actualCoordinate, this.type, this.color);

  Coordinate actualCoordinate;
  PieceTypeEnum type;
  late List<MovementEnum> allowedMovements;
  late int range;
  final PieceColorEnum color;

  bool canMove(Board board, Square target) {
    throw UnimplementedError();
  }

  List<Coordinate> getPossibleMoves(Board board) {
    throw UnimplementedError();
  }

  List<Coordinate> getPossibleAttacks(Board board) {
    throw UnimplementedError();
  }

  List<Coordinate> getPossibleTopRightAttacks(Board board) {
    return _testAttack(board, false, false, xMultiplier: -1);
  }

  List<Coordinate> getPossibleTopLeftAttacks(Board board) {
    return _testAttack(board, false, false, yMultiplier: -1, xMultiplier: -1);
  }

  List<Coordinate> getPossibleTopAttacks(Board board) {
    return _testAttack(board, false, true, xMultiplier: -1);
  }

  List<Coordinate> _testAttack(
    Board board,
    bool preserveX,
    bool preserveY, {
    int xMultiplier = 1,
    int yMultiplier = 1,
  }) {
    List<Coordinate> attackedCoordinates = [];
    var testedCoordinate = Coordinate(actualCoordinate.x, actualCoordinate.y);
    int i = 0;
    while (i < range) {
      i++;
      int xValue = preserveX ? 0 : i * xMultiplier;
      int yValue = preserveY ? 0 : i * yMultiplier;
      testedCoordinate = testedCoordinate.sumCoordinate(xValue, yValue);
      if (board.coordinateExist(testedCoordinate)) {
        if (board.getSquare(testedCoordinate).piece == null ||
            board.getSquare(testedCoordinate).piece!.color != color) {
          attackedCoordinates.add(testedCoordinate);
          continue;
        }
      }
      break;
    }
    return attackedCoordinates;
  }

  String getImagePath() {
    String imagePath = AppConstants.defaultImagePath;
    switch (type) {
      case PieceTypeEnum.PAWN:
        imagePath += "/pawn_${_getImageColor()}";
        break;
      case PieceTypeEnum.ROOK:
        imagePath += "/rook_${_getImageColor()}";
        break;
      case PieceTypeEnum.KNIGHT:
        imagePath += "/knight_${_getImageColor()}";
        break;
      case PieceTypeEnum.BISHOP:
        imagePath += "/bishop_${_getImageColor()}";
        break;
      case PieceTypeEnum.QUEEN:
        imagePath += "/queen_${_getImageColor()}";
        break;
      case PieceTypeEnum.KING:
        imagePath += "/king_${_getImageColor()}";
        break;
    }
    return "$imagePath.png";
  }

  String _getImageColor() {
    return color == PieceColorEnum.BLACK ? "black" : "white";
  }

  @override
  String toString() {
    return 'Piece{actualCoordinate: $actualCoordinate, type: $type, color: $color}';
  }
}
