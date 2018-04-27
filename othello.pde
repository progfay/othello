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
  while (!field.tryPut(new Pos(int(random(0, 8)), int(random(0, 8))))) {
  }
  field.changeTurn();
  
  save("othello-" + frameCount + ".jpg");
}

//void mousePressed() {
//  Pos pos = new Pos(
//    mouseX / SIZE, 
//    mouseY / SIZE
//    );

//  if (field.isGameEnd()) {
//    println("Finished! " + field);
//    noLoop();
//  }

//  if (!field.checkPutable()) {
//    println("Oops, player" + (field.turn) + " had no choice but to pass!");
//    println("Player" + (field.turn) + "was passed automatically...");
//    field.changeTurn();
//    return;
//  }


//  if (!field.tryPut(pos)) {
//    println("Player" + (field.turn) + " cannot put at " + pos);
//    return;
//  }

//  field.changeTurn();

//  // AI player who select position randomly
//  while (!field.tryPut(new Pos(int(random(0, 8)), int(random(0, 8))))) {
//  }
//  field.changeTurn();
//}