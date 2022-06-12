import '../../config/constants/app_constants.dart';
import '../enum/piece_enums.dart';
import 'coordinate_model.dart';
import 'pawn_model.dart';
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

  void markTestedMovesSquares(List<Coordinate> coordinates){
    for(int i = 0; i < coordinates.length; i++){
      squares[coordinates[i].x][coordinates[i].y].canMove = true;
      _testingMoveSquares.add(coordinates[i]);
    }
  }

  unmarkTestedMovesSquares(){
    for(int i = 0; i < _testingMoveSquares.length; i++){
      squares[_testingMoveSquares[i].x][_testingMoveSquares[i].y].canMove = false;
    }
    _testingMoveSquares.clear();
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
    /*_putRooks(squares);
    _putKnights(squares);
    _putBishops(squares);
    _putQueens(squares);
    _putKings(squares);*/
    _putPawns(squares);
  }

  /*void _putRooks(List<List<Square>> squares) {
    const PieceTypeEnum pieceType = PieceTypeEnum.ROOK;
    squares[0][0].piece =
        Piece(Coordinate(0, 0), pieceType, PieceColorEnum.BLACK);
    squares[0][7].piece =
        Piece(Coordinate(0, 7), pieceType, PieceColorEnum.BLACK);
    squares[7][0].piece =
        Piece(Coordinate(7, 0), pieceType, PieceColorEnum.WHITE);
    squares[7][7].piece =
        Piece(Coordinate(7, 7), pieceType, PieceColorEnum.WHITE);
  }

  void _putKnights(List<List<Square>> squares) {
    const PieceTypeEnum pieceType = PieceTypeEnum.KNIGHT;
    squares[0][1].piece =
        Piece(Coordinate(0, 1), pieceType, PieceColorEnum.BLACK);
    squares[0][6].piece =
        Piece(Coordinate(0, 6), pieceType, PieceColorEnum.BLACK);
    squares[7][1].piece =
        Piece(Coordinate(7, 1), pieceType, PieceColorEnum.WHITE);
    squares[7][6].piece =
        Piece(Coordinate(7, 6), pieceType, PieceColorEnum.WHITE);
  }

  void _putBishops(List<List<Square>> squares) {
    const PieceTypeEnum pieceTypeEnum = PieceTypeEnum.BISHOP;
    squares[0][2].piece =
        Piece(Coordinate(0, 2), pieceTypeEnum, PieceColorEnum.BLACK);
    squares[0][5].piece =
        Piece(Coordinate(0, 5), pieceTypeEnum, PieceColorEnum.BLACK);
    squares[7][2].piece =
        Piece(Coordinate(7, 2), pieceTypeEnum, PieceColorEnum.WHITE);
    squares[7][5].piece =
        Piece(Coordinate(7, 5), pieceTypeEnum, PieceColorEnum.WHITE);
  }

  void _putQueens(List<List<Square>> squares){
    const PieceTypeEnum pieceTypeEnum = PieceTypeEnum.QUEEN;
    squares[0][3].piece =
        Piece(Coordinate(0, 3), pieceTypeEnum, PieceColorEnum.BLACK);
    squares[7][3].piece =
        Piece(Coordinate(7, 3), pieceTypeEnum, PieceColorEnum.WHITE);
  }

  void _putKings(List<List<Square>> squares){
    const PieceTypeEnum pieceTypeEnum = PieceTypeEnum.KING;
    squares[0][4].piece =
        Piece(Coordinate(0, 4), pieceTypeEnum, PieceColorEnum.BLACK);
    squares[7][4].piece =
        Piece(Coordinate(7, 4), pieceTypeEnum, PieceColorEnum.WHITE);
  }*/

  void _putPawns(List<List<Square>> squares) {
    const PieceTypeEnum pieceTypeEnum = PieceTypeEnum.PAWN;
    squares[2][3].piece = Pawn(Coordinate(2, 3), pieceTypeEnum, PieceColorEnum.WHITE);
    for (int y = 0; y <= 7; y++) {
      squares[1][y].piece =
          Pawn(Coordinate(1, y), pieceTypeEnum, PieceColorEnum.BLACK);
      squares[6][y].piece =
          Pawn(Coordinate(6, y), pieceTypeEnum, PieceColorEnum.WHITE);
    }
  }

}
