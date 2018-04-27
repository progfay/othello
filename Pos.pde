class Pos {
  int x, y;

  Pos(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  }

  Pos move(Length len) {
    return new Pos(
      this.x - len.dx, 
      this.y - len.dy
      );
  }

  @Override
    public String toString() {
    return "(" + this.x + ", " + this.y + ")";
  }
}