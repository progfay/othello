class Field {
  final int NONE  = -1;
  final int BLACK = 0;
  final int WHITE = 1;

  private int [][] cell;
  private int      turn;

  private boolean isGameEndFlag  = false;
  private boolean isPlayerPassed = false;

  public Field() {
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

  public void draw() {
    background(#208208);
    stroke(#A0A0A0);
    for (int i = 1; i < 8; i++) {
      line(i*SIZE, 0, i*SIZE, height);
      line(0, i*SIZE, width, i*SIZE);
    }

    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        int unitColor = this.get(i, j);
        if (unitColor == NONE) continue;
        fill(unitColor == BLACK ? #080808 : #FDFDFD);
        stroke(#888888);
        ellipse((i+0.5)*SIZE, (j+0.5)*SIZE, STONE_SIZE, STONE_SIZE);
      }
    }
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

  boolean onBoard(int x, int y) {
    return x >= 0 && x < 8 && y >= 0 && y < 8;
  }

  boolean onBoard(Pos pos) {
    return this.onBoard(pos.x, pos.y);
  }

  public int getTurn() {
    return this.turn;
  }

  public boolean isGameEnd() {
    return this.isGameEndFlag;
  }

  public int winner() {
    int countBlack = 0;
    int countWhite = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (this.cell[i][j] == BLACK) {
          countBlack++;
        } else if (this.cell[i][j] == WHITE) {
          countWhite++;
        }
      }
    }
    if (countBlack > countWhite) return this.BLACK;
    else if (countBlack < countWhite) return this.WHITE;
    else return this.NONE;
  }

  @Override
    String toString() {
    int countBlack = 0;
    int countWhite = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (this.cell[i][j] == BLACK) {
          countBlack++;
        } else if (this.cell[i][j] == WHITE) {
          countWhite++;
        }
      }
    }
    return "Black : " + countBlack + "\nWhite : " + countWhite;
  }
}
