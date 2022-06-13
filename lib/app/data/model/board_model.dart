import '../../config/constants/app_constants.dart';
import '../enum/piece_enums.dart';
import 'coordinate_model.dart';
import 'pawn_model.dart';
import 'piece_model.dart';
import 'square_model.dart';

class Board {
  Board() {
    squares = _getInitialBoard();
  }

  late List<List<Square>> squares;
  //final List<Coordinate> _attackedSquares = [];
  final List<Coordinate> _testingMoveSquares = [];

  /// Receiving a [Coordinate] return a square
  Square getSquare(Coordinate coordinate) {
    return squares[coordinate.x][coordinate.y];
  }

  bool coordinateExist(Coordinate coordinate) {
    if (coordinate.x >= 0 &&
        coordinate.x <= 7 &&
        coordinate.y >= 0 &&
        coordinate.y <= 7) return true;
    return false;
  }

  void markTestedMovesSquares(List<Coordinate> coordinates) {
    for (int i = 0; i < coordinates.length; i++) {
      squares[coordinates[i].x][coordinates[i].y].canMove = true;
      _testingMoveSquares.add(coordinates[i]);
    }
  }

  unmarkTestedMovesSquares() {
    for (int i = 0; i < _testingMoveSquares.length; i++) {
      squares[_testingMoveSquares[i].x][_testingMoveSquares[i].y].canMove =
          false;
    }
    _testingMoveSquares.clear();
  }

  void _putInitialPiece(Coordinate coordinate, PieceType pieceType, PieceColor color,
      List<List<Square>> squares) {
    Piece piece;
    switch (pieceType) {
      case PieceType.PAWN:
        piece = Pawn(coordinate, pieceType, color);
        break;
      default:
        piece = Pawn(coordinate, pieceType, color);
    }
    squares[coordinate.x][coordinate.y].piece = piece;
  }

  void _putPiece(Piece piece, Coordinate target){
    squares[target.x][target.y].piece = piece;
  }

  void _removePiece(Piece piece){
    squares[piece.actualCoordinate.x][piece.actualCoordinate.y].piece = null;
  }

  void movePiece(Piece piece, Coordinate target){
    _removePiece(piece);
    piece.actualCoordinate = target;
    _putPiece(piece, target);
  }

  /// Return initial
  List<List<Square>> _getInitialBoard() {
    List<List<Square>> initialSquares = _getInitialSquares();
    _putInitialPieces(initialSquares);
    return initialSquares;
  }

  List<List<Square>> _getInitialSquares() {
    List<List<Square>> squares = [];
    String squareColor = "white";
    for (int x = 0; x <= 7; x++) {
      squares.add([]);
      squareColor = x % 2 == 0 ? "white" : "black";
      for (int y = 0; y <= 7; y++) {
        String imagePath =
            "${AppConstants.defaultSquarePath}/square_$squareColor.png";
        squares[x].add(Square(imagePath, Coordinate(x, y)));
        squareColor = squareColor == "white" ? "black" : "white";
      }
    }
    return squares;
  }

  void _putInitialPieces(List<List<Square>> squares) {
    _putPawns(squares);
  }

  void _putPawns(List<List<Square>> squares) {
    const PieceType pieceType = PieceType.PAWN;
    for (int y = 0; y <= 7; y++) {
      _putInitialPiece(Coordinate(1, y), pieceType, PieceColor.BLACK, squares);
      _putInitialPiece(Coordinate(6, y), pieceType, PieceColor.WHITE, squares);
    }
  }

}

