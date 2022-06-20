import 'coordinate_model.dart';
import 'piece_model.dart';

class Square{

  Square(this.canMove, this.squareImagePath, this.coordinate, this.piece);

  bool canMove = false;
  final String squareImagePath;
  final Coordinate coordinate;
  Piece? piece;

  Square copy(){
    return Square(canMove, squareImagePath, coordinate.copy(), piece?.copy());
  }

  @override
  String toString() {
    return 'Square{canMove: $canMove, squareImagePath: $squareImagePath, coordinate: $coordinate, piece: $piece}';
  }
}