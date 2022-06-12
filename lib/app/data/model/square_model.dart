import 'coordinate_model.dart';
import 'piece_model.dart';

class Square{

  Square(this.squareImagePath, this.coordinate);

  bool canMove = false;
  final String squareImagePath;
  final Coordinate coordinate;
  Piece? piece;

}