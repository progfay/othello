Field field;

void settings() {
  size(8*SIZE, 8*SIZE);
}

void setup() {
  // set board layout
  field = new Field();
}

void draw() {
  if (field.isGameEnd()) {
    return;
  }

  field.draw();

  if (!field.checkPutable()) {
    if (!field.isGameEnd()) {
      println("Oops, player" + (field.turn) + " had no choice but to pass!");
      println("Player" + (field.turn) + " was passed automatically...");
    }
    field.changeTurn();
    return;
  }

  // AI player who select position randomly
  field.tryPut(field.calcOptimalPos());
  field.changeTurn();
  
  save("othello-" + frameCount + ".jpg");
}
