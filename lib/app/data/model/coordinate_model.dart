class Coordinate{

  Coordinate(this.x, this.y);

  final int x;
  final int y;

  Coordinate sumCoordinate(int sumX, int sumY){
    return Coordinate(x + sumX, y + sumY);
  }

  @override
  String toString() {
    return '(x: $x, y: $y)';
  }
}