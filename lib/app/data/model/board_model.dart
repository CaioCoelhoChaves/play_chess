import '../../config/constants/app_constants.dart';
import '../enum/piece_enums.dart';
import 'coordinate_model.dart';
import 'king_model.dart';
import 'pawn_model.dart';
import 'piece_model.dart';
import 'square_model.dart';

class Board {
  Board(this._blackPieces, this._whitePieces) {
    _squares = _getInitialBoard();
  }

  Board.copy(
    this._squares,
    this._whitePieces,
    this._blackPieces,
    this.enPassant,
  );

  late List<List<Square>> _squares;
  final List<Coordinate> _testingMoveSquares = [];
  final List<Piece> _whitePieces;
  final List<Piece> _blackPieces;
  Coordinate? enPassant;

  /// Receiving a [Coordinate] return a square
  Square getSquare(Coordinate coordinate, {bool ref = false}) {
    if(!ref) {
      return _squares[coordinate.x][coordinate.y].copy();
    }
    return _squares[coordinate.x][coordinate.y];
  }

  List<Coordinate> getWhiteAttackingCoordinates() {
    List<Coordinate> attacking = [];
    for (var element in _whitePieces) {
      attacking.addAll(element.getPossibleAttacks(this));
    }
    return attacking;
  }

  List<Coordinate> getBlackAttackingCoordinates() {
    List<Coordinate> attacking = [];
    for (var element in _blackPieces) {
      attacking.addAll(element.getPossibleAttacks(this));
    }
    return attacking;
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
      _squares[coordinates[i].x][coordinates[i].y].canMove = true;
      _testingMoveSquares.add(coordinates[i]);
    }
  }

  unmarkTestedMovesSquares() {
    for (int i = 0; i < _testingMoveSquares.length; i++) {
      _squares[_testingMoveSquares[i].x][_testingMoveSquares[i].y].canMove =
          false;
    }
    _testingMoveSquares.clear();
  }

  void _putInitialPieceInGame(Coordinate coordinate, PieceType pieceType,
      PieceColor color, List<List<Square>> squares) {
    Piece piece;
    switch (pieceType) {
      case PieceType.PAWN:
        piece = Pawn(coordinate, pieceType, color);
        break;
      case PieceType.KING:
        piece = King(coordinate, pieceType, color);
        break;
      default:
        piece = Pawn(coordinate, pieceType, color);
    }
    squares[coordinate.x][coordinate.y].piece = piece;
    if(color == PieceColor.BLACK){
      _blackPieces.add(squares[coordinate.x][coordinate.y].piece!);
      return;
    }
    _whitePieces.add(squares[coordinate.x][coordinate.y].piece!);
  }

  void _putPiece(Piece piece, Coordinate target) {
    Piece? targetPiece = getSquare(target).piece;
    if (targetPiece != null) {
      _killPiece(targetPiece);
    }
    _squares[target.x][target.y].piece = piece;
  }

  void movePiece(Piece piece, Coordinate target) {
    if (enPassant != null && target.isEqualAs(enPassant!)) {
      if (piece.color == PieceColor.BLACK) {
        _killPiece(getSquare(target.sumCoordinate(-1, 0)).piece!);
      } else {
        _killPiece(getSquare(target.sumCoordinate(1, 0)).piece!);
      }
    }
    _removePiece(piece);
    _createEnPassant(piece, target);
    piece.onMove(target);
    _putPiece(piece, target);
  }

  void _removePiece(Piece piece) {
    _squares[piece.actualCoordinate.x][piece.actualCoordinate.y].piece = null;
  }

  void _killPiece(Piece piece) {
    if (piece.color == PieceColor.BLACK) {
      _blackPieces.remove(piece);
    } else {
      _whitePieces.remove(piece);
    }
    _removePiece(piece);
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
        squares[x].add(Square(false, imagePath, Coordinate(x, y), null));
        squareColor = squareColor == "white" ? "black" : "white";
      }
    }
    return squares;
  }

  void _putInitialPieces(List<List<Square>> squares) {
    _putPawns(squares);
    _putKings(squares);
  }

  void _putPawns(List<List<Square>> squares) {
    const PieceType pieceType = PieceType.PAWN;
    for (int y = 0; y <= 0; y++) {
      _putInitialPieceInGame(
          Coordinate(1, y), pieceType, PieceColor.BLACK, squares);
      _putInitialPieceInGame(
          Coordinate(6, y), pieceType, PieceColor.WHITE, squares);
    }
  }

  void _putKings(List<List<Square>> squares) {
    const PieceType pieceType = PieceType.KING;
    _putInitialPieceInGame(
        Coordinate(0, 4), pieceType, PieceColor.BLACK, squares);
    _putInitialPieceInGame(
        Coordinate(7, 4), pieceType, PieceColor.WHITE, squares);
  }

  bool _createEnPassant(Piece piece, Coordinate target) {
    if (piece.enableEnPassant(target)) {
      enPassant = piece.color == PieceColor.BLACK
          ? piece.actualCoordinate.sumCoordinate(1, 0)
          : piece.actualCoordinate.sumCoordinate(-1, 0);
      return true;
    }
    enPassant = null;
    return false;
  }

  int getQtWhites() => _whitePieces.length;
  int getQtBlacks() => _blackPieces.length;

  bool isWhiteKingInCheck() {
    King whiteKing = _whitePieces
        .firstWhere((element) => element.type == PieceType.KING) as King;
    for (var element in getBlackAttackingCoordinates()) {
      if (element.isEqualAs(whiteKing.actualCoordinate)) {
        return true;
      }
    }
    return false;
  }

  bool isBlackKingInCheck() {
    King blackKing = _blackPieces
        .firstWhere((element) => element.type == PieceType.KING) as King;
    for (var element in getWhiteAttackingCoordinates()) {
      if (element.isEqualAs(blackKing.actualCoordinate)) {
        return true;
      }
    }
    return false;
  }

  Board copy() {
    List<List<Square>> copiedSquares = [];
    for (int x = 0; x <= 7; x++) {
      copiedSquares.add([]);
      for (int y = 0; y <= 7; y++) {
        copiedSquares[x].add(_squares[x][y].copy());
      }
    }
    List<Piece> whites = [];
    for (var element in _whitePieces) {
      whites.add(element.copy());
    }
    List<Piece> blacks = [];
    for (var element in _blackPieces) {
      blacks.add(element.copy());
    }
    return Board.copy(copiedSquares, whites, blacks, enPassant?.copy());
  }
}
