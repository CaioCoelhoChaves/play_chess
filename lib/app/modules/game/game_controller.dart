import 'package:get/get.dart';

import '../../data/model/board_model.dart';
import '../../data/model/coordinate_model.dart';
import '../../data/model/piece_model.dart';

class GameController extends GetxController {

  final Rx<Board> board = Rx(Board());

  onDragPiece(Piece piece){
    List<Coordinate> coordinates = piece.getPossibleMoves(board.value);
    board.update((val) {
      board.value.markTestedMovesSquares(coordinates);
    });
  }

  onDragPieceEnd(){
    board.update((val) {
      board.value.unmarkTestedMovesSquares();
    });
  }

}
