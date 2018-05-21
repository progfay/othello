Field field;
Player[] players;

//void settings() {
//  size(8*SIZE, 8*SIZE);
//}

void setup() {
  for (int i = 0; i < LEARN_TRIAL_NUM; i++) {
    int randomWinNum = 0;
    String[] param = loadStrings("weight.txt")[0].split(",");
    players = new Player[2];
    float[] weight0 = { float(param[0]), float(param[1]) };
    float[] weight1 = { float(param[0]), float(param[1]) + (SWING_WIDTH-random(SWING_WIDTH*2)) };

    for (int j = 0; j < GAME_TRIAL_NUM; j++) {
      field = new Field();
      players[0] = new Player(field.BLACK, j % 2 == 0 ? weight0 : weight1);
      players[1] = new Player(field.WHITE, j % 2 == 0 ? weight1 : weight0);
      while (!field.isGameEnd()) {
        players[field.turn].play(field);
      }
      if ((j+1) % 2 == field.winner()) randomWinNum++;
    }
    if (randomWinNum > ceil(GAME_TRIAL_NUM*0.5)) {
      String[] lines = {
        1.0 + "," + (weight1[1] / weight1[0])
      };
      saveStrings("weight.txt", lines);
      println(lines[0]);
    }
  }
  println("Finish!");
  exit();
}

//void draw() {
//  if (field.isGameEnd()) {
//    println("\nFinished!\n" + field);
//    noLoop();
//    return;
//  }

//  field.draw();

//  players[field.turn].play(field);

//  save("capture/othello-" + frameCount + ".jpg");
//}
