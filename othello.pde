Field field;

void settings() {
  size(8*SIZE, 8*SIZE);
}

void setup() {
  // set board layout
  field = new Field();
  save("capture/othello-0.png");
}

boolean start = false;

void draw() {
  if (!start) {
    frameCount = 0;
    return;
  }
  //if (frameCount >= 30) exit();
  while (!field.tryPut(new Pos(int(random(0, 8)), int(random(0, 8))))) {
  }
  save("capture/othello" + frameCount + ".png");
  field.changeTurn();
}

void mouseReleased() {
  start = true;
}

//void mousePressed() {
//  Pos pos = new Pos(
//    mouseX / SIZE, 
//    mouseY / SIZE
//    );

//  if (!field.tryPut(pos)) {
//    println("You cannot put at " + pos);
//    return;
//  }

//  field.changeTurn();

//  // AI player who select position randomly
//  while (!field.tryPut(new Pos(int(random(0, 8)), int(random(0, 8))))) {
//  }
//  field.changeTurn();
//}