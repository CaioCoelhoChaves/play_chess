import 'package:get/get.dart';

import '../../data/model/board_model.dart';
import '../../data/model/coordinate_model.dart';
import '../../data/model/piece_model.dart';
import '../../data/model/square_model.dart';

class GameController extends GetxController {

  final Rx<Board> board = Rx(Board());

  movePieceTo(Piece movedPiece, Square target){
    if(_isMovePossible(movedPiece, target.coordinate)){

    }
  }

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

  bool _isMovePossible(Piece piece, Coordinate target){
    List<Coordinate> piecePossibleMoves = piece.getPossibleMoves(board.value);
    for(int i = 0; i < piecePossibleMoves.length; i++){
      final coordinate = piecePossibleMoves[i];
      if(coordinate.x == target.x && coordinate.y == target.y){
        return true;
      }
    }
    return false;
  }

  _movePiece(Piece piece, Coordinate target){

  }

}
