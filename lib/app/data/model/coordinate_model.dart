class Coordinate{

  Coordinate(this.x, this.y);

  final int x;
  final int y;

  Coordinate sumCoordinate(int sumX, int sumY){
    return Coordinate(x + sumX, y + sumY);
  }

  bool isEqualAs(Coordinate other){
    if(x == other.x && y == other.y) return true;
    return false;
  }

  @override
  String toString() {
    return '(x: $x, y: $y)';
  }

  Coordinate copy(){
    return Coordinate(x, y);
  }

}