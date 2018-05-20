class Player {
  int turn;

  Player(int _t) {
    this.turn = _t;
  }

  void play(Field field) {
    if (!field.checkPutable()) {
      if (!field.isGameEnd()) {
        println("Oops, player" + (this.turn) + " had no choice but to pass!");
        println("Player" + (this.turn) + " was passed automatically...");
      }
      field.changeTurn();
      return;
    }

    field.tryPut(field.calcOptimalPos());
    field.changeTurn();
  }
}
