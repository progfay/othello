Field field;
Player[] players;

void settings() {
  size(8*SIZE, 8*SIZE);
}

void setup() {
  // set board layout
  field = new Field();
  players = new Player[2];
  players[0] = new Player(field.BLACK);
  players[1] = new Player(field.WHITE);
}

void draw() {
  if (field.isGameEnd()) {
    println("\nFinished!\n" + field);
    return;
  }

  field.draw();
  
  players[field.turn].play(field);

  save("capture/othello-" + frameCount + ".jpg");
}
