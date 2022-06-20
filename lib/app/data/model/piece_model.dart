import '../../config/constants/app_constants.dart';
import '../enum/piece_enums.dart';
import 'board_model.dart';
import 'coordinate_model.dart';
import 'square_model.dart';

abstract class Piece {
  /// Create a Piece, don't forget to late initialize allowedMovements and range
  Piece(this.actualCoordinate, this.type, this.color);

  Coordinate actualCoordinate;
  PieceType type;
  late int range;
  final PieceColor color;
  bool firstMove = true;

  void onMove(Coordinate target){
    firstMove = false;
    actualCoordinate = target;
  }

  bool canMove(Board board, Square target) {
    List<Coordinate> piecePossibleMoves = getPossibleMoves(board);
    for (int i = 0; i < piecePossibleMoves.length; i++) {
      final coordinate = piecePossibleMoves[i];
      if(coordinate.isEqualAs(target.coordinate)){
        return true;
      }
    }
    return false;
  }

  List<Coordinate> getPossibleMoves(Board board) {
    throw UnimplementedError();
  }

  List<Coordinate> getPossibleAttacks(Board board) {
    throw UnimplementedError();
  }

  List<Coordinate> getPossibleFrontSquares(Board board) {
    if (color == PieceColor.WHITE) {
      return _getPossibleTopSquares(board);
    }
    return _getPossibleBottomSquares(board);
  }

  List<Coordinate> getPossibleBackSquares(Board board) {
    if (color == PieceColor.WHITE) {
      return _getPossibleBottomSquares(board);
    }
    return _getPossibleTopSquares(board);
  }

  List<Coordinate> getPossibleDiagonalFrontSquares(Board board) {
    if (color == PieceColor.WHITE) {
      return [
        ..._getPossibleTopRightSquares(board),
        ..._getPossibleTopLeftSquares(board),
      ];
    }
    return [
      ..._getPossibleBottomRightSquares(board),
      ..._getPossibleBottomLeftSquares(board),
    ];
  }

  List<Coordinate> getPossibleDiagonalBackSquares(Board board) {
    if (color == PieceColor.WHITE) {
      return [
        ..._getPossibleBottomRightSquares(board),
        ..._getPossibleBottomLeftSquares(board),
      ];
    }
    return [
      ..._getPossibleTopRightSquares(board),
      ..._getPossibleTopLeftSquares(board),
    ];
  }

  List<Coordinate> getPossibleSidesSquares(Board board) {
    return [
      ..._getPossibleRightSquares(board),
      ..._getPossibleLeftSquares(board)
    ];
  }

  List<Coordinate> _getPossibleTopRightSquares(Board board) {
    return _testAttack(board, preserveX: false, preserveY: false, lessX: true);
  }

  List<Coordinate> _getPossibleTopLeftSquares(Board board) {
    return _testAttack(board,
        preserveX: false, preserveY: false, lessX: true, lessY: true);
  }

  List<Coordinate> _getPossibleTopSquares(Board board) {
    return _testAttack(board, preserveX: false, lessX: true);
  }

  List<Coordinate> _getPossibleRightSquares(Board board) {
    return _testAttack(board, preserveY: false);
  }

  List<Coordinate> _getPossibleLeftSquares(Board board) {
    return _testAttack(board, preserveY: false, lessY: true);
  }

  List<Coordinate> _getPossibleBottomSquares(Board board) {
    return _testAttack(board, preserveX: false);
  }

  List<Coordinate> _getPossibleBottomRightSquares(Board board) {
    return _testAttack(board, preserveX: false, preserveY: false);
  }

  List<Coordinate> _getPossibleBottomLeftSquares(Board board) {
    return _testAttack(board, preserveX: false, preserveY: false, lessY: true);
  }

  List<Coordinate> _testAttack(Board board,
      {bool preserveX = true,
      bool preserveY = true,
      bool lessX = false,
      bool lessY = false}) {
    List<Coordinate> attackedCoordinates = [];
    int i = 0;
    while (i < range) {
      i++;
      var testedCoordinate = Coordinate(actualCoordinate.x, actualCoordinate.y);
      int xValue = preserveX ? 0 : i * (lessX ? -1 : 1);
      int yValue = preserveY ? 0 : i * (lessY ? -1 : 1);
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
      case PieceType.PAWN:
        imagePath += "/pawn_${_getImageColor()}";
        break;
      case PieceType.ROOK:
        imagePath += "/rook_${_getImageColor()}";
        break;
      case PieceType.KNIGHT:
        imagePath += "/knight_${_getImageColor()}";
        break;
      case PieceType.BISHOP:
        imagePath += "/bishop_${_getImageColor()}";
        break;
      case PieceType.QUEEN:
        imagePath += "/queen_${_getImageColor()}";
        break;
      case PieceType.KING:
        imagePath += "/king_${_getImageColor()}";
        break;
    }
    return "$imagePath.png";
  }

  String _getImageColor() {
    return color == PieceColor.BLACK ? "black" : "white";
  }

  bool enableEnPassant(Coordinate target){
    return false;
  }

  @override
  String toString() {
    return 'Piece{actualCoordinate: $actualCoordinate, type: $type, color: $color}';
  }

  Piece copy(){
    throw UnimplementedError();
  }

}
