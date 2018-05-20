class Player {
  int     turn;
  float[] weight;

  Player(int _t, float[] _w) {
    this.turn   = _t;
    this.weight = _w;
  }

  void play(Field field) {
    if (!this.checkPutable(field)) {
      if (!field.isGameEnd()) {
        // println("Oops, player" + (this.turn) + " had no choice but to pass!");
        // println("Player" + (this.turn) + " was passed automatically...");
      }
      field.changeTurn();
      return;
    }

    field.tryPut(this.calcOptimalPos(field));
    field.changeTurn();
  }

  public Pos calcOptimalPos(Field field) {
    int optPosX = 0, optPosY = 0;
    int maxValue = -100;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        int liberationDeg = this.ableToPut(field, i, j);
        if (liberationDeg == -1) continue;
        int value = this.evaluatePos(i, j) - liberationDeg;
        if (maxValue > value) continue;
        if (maxValue == value && random(1) < 0.5) continue;
        optPosX = i;
        optPosY = j;
        maxValue = value;
      }
    }
    // print((this.turn == field.BLACK ? "WHITE" : "BLACK") + ": ");
    // print(new Pos(optPosX, optPosY).toString());
    // println(" => " + (maxValue > 0 ? "+" : "") + maxValue);
    return new Pos(optPosX, optPosY);
  }

  public boolean checkPutable(Field field) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (this.ableToPut(field, i, j) != -1) return true;
      }
    }
    if (field.isPlayerPassed) field.isGameEndFlag = true;
    field.isPlayerPassed = true;
    return false;
  }

  private int ableToPut(Field field, int x, int y) {
    boolean[][] open = new boolean[8][8];
    Pos pos = new Pos(x, y);
    if (field.get(pos) != field.NONE) return -1;
    int opponent = (this.turn == field.BLACK ? field.WHITE : field.BLACK);
    for (int i = 0; i < 8; i++) {
      Pos around = pos.move(UNIT_DIRECTION[i]);
      if (field.get(around) == opponent) {
        if (this.ableReverse(field, around, UNIT_DIRECTION[i], open)) return liberation(open);
      }
    }
    return -1;
  }

  private boolean ableReverse(Field field, Pos pos, Length distance, boolean[][] open) {
    Pos checkPos = pos.move(distance);
    int opponent = (this.turn == field.BLACK ? field.WHITE : field.BLACK);
    if (field.get(checkPos) == this.turn) {
      for (int i = 0; i < 8; i++) {
        Pos around = pos.move(UNIT_DIRECTION[i]);
        if (field.onBoard(around) && field.get(around) == field.NONE) open[around.x][around.y] = true;
      }
      return true;
    } else if (field.get(checkPos) == opponent) {
      for (int i = 0; i < 8; i++) {
        Pos around = pos.move(UNIT_DIRECTION[i]);
        if (field.onBoard(around) && field.get(around) == field.NONE) open[around.x][around.y] = true;
      }
      return this.ableReverse(field, checkPos, distance, open);
    } else {
      return false;
    }
  }

  private int liberation(boolean[][] open) {
    int num = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (open[i][j]) num++;
      }
    }
    return num;
  }

  private int evaluatePos(int x, int y) {
    return EVALUATE_VALUE[x][y];
  }
}
