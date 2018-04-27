class Field {
  final int NONE  = 0;
  final int BLACK = 1;
  final int WHITE = 2;

  private int [][] cell;
  private int      turn;

  public Field() {
    background(#208208);
    stroke(#A0A0A0);
    for (int i = 1; i < 8; i++) {
      line(i*SIZE, 0, i*SIZE, height);
      line(0, i*SIZE, width, i*SIZE);
    }

    // init unit array
    cell = new int[8][8];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        cell[i][j] = NONE;
      }
    }

    // set first white unit
    this.put(3, 3, WHITE);
    this.put(4, 4, WHITE);

    // set first put unit
    this.put(3, 4, BLACK);
    this.put(4, 3, BLACK);

    // set first play for black
    turn = BLACK;
  }

  public boolean tryPut(Pos pos) {
    if (this.get(pos) != NONE) return false;
    int opponent = (this.turn == BLACK ? WHITE : BLACK);
    boolean success = false;
    for (int i = 0; i < 8; i++) {
      Pos around = pos.move(UNIT_DIRECTION[i]);
      if (this.get(around) == opponent) {
        boolean reversed = tryReverse(around, UNIT_DIRECTION[i]);
        if (reversed) success = true;
      }
    }
    if (success) this.put(pos);
    return success;
  }

  private boolean tryReverse(Pos pos, Length distance) {
    Pos checkPos = pos.move(distance);
    int opponent = (this.turn == BLACK ? WHITE : BLACK);
    if (this.get(checkPos) == this.turn) {
      this.put(pos);
      return true;
    } else if (this.get(checkPos) == opponent) {
      boolean canReverse = tryReverse(checkPos, distance);
      if (canReverse) this.put(pos);
      return canReverse;
    } else {
      return false;
    }
  }

  private void put(int x, int y, int unitColor) {
    this.cell[x][y] = unitColor;
    fill(unitColor == BLACK ? #080808 : #FDFDFD);
    stroke(#888888);
    ellipse((x+0.5)*SIZE, (y+0.5)*SIZE, STONE_SIZE, STONE_SIZE);
  }

  private void put(Pos pos) {
    this.put(pos.x, pos.y, this.turn);
  }

  public void changeTurn() {
    this.turn = (this.turn == BLACK ? WHITE : BLACK);
  }

  int get(int x, int y) {
    return (x >= 0 && x < 8 && y >= 0 && y < 8 ? this.cell[x][y] : NONE);
  }

  int get(Pos pos) {
    return this.get(pos.x, pos.y);
  }
}