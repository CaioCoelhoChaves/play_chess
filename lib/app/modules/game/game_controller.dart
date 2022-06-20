import 'package:get/get.dart';
import 'package:play_chess/app/data/enum/piece_enums.dart';
import '../../data/model/board_model.dart';
import '../../data/model/coordinate_model.dart';
import '../../data/model/piece_model.dart';
import '../../data/model/square_model.dart';

class GameController extends GetxController {
  final Rx<Board> board = Rx(Board([],[]));

  PieceColor turn = PieceColor.WHITE;
  movePieceTo(Piece movedPiece, Square target) {
    if (movedPiece.canMove(board.value, target)) {
      if (_isLegalMove(movedPiece, target)) {
        board.value.movePiece(movedPiece, target.coordinate);
        _changeTurn();
      }else{
        print("Ilegal");
      }
    }
  }

  onDragPiece(Piece piece) {
    List<Coordinate> coordinates = piece.getPossibleMoves(board.value);
    board.update((val) {
      board.value.markTestedMovesSquares(coordinates);
    });
  }

  onDragPieceEnd() {
    board.update((val) {
      board.value.unmarkTestedMovesSquares();
    });
  }

  _changeTurn() =>
      turn = turn == PieceColor.WHITE ? PieceColor.BLACK : PieceColor.WHITE;

  bool _isLegalMove(Piece piece, Square target) {
    Board testBoard = board.value.copy();
    Piece movedPiece = testBoard.getSquare(piece.actualCoordinate).piece!;
    testBoard.movePiece(movedPiece, target.coordinate.copy());
    bool legal = turn == PieceColor.BLACK
        ? !testBoard.isBlackKingInCheck()
        : !testBoard.isWhiteKingInCheck();
    return legal;
  }

  bool isPieceTurn(PieceColor color) {
    return turn == color ? true : false;
  }
}
