final int SIZE = 50;
final int STONE_SIZE = (int)(SIZE*0.7);
final int NONE = 0;
final int BLACK = 1;
final int WHITE = 2;

int[][] field;
boolean black_turn = true;
 
void setup(){
  size(400, 400);//8*SIZE,8*SIZE);
  field = new int[8][8];
  for(int i=0; i<8; ++i){
    for(int j=0; j<8; ++j){
        field[i][j] = NONE;
    }
  }
}
 
void draw(){
  
  background(0,128,0);
  
  // lines
  stroke(0);
  for(int i=1; i<8; ++i){
    line(i*SIZE,0,i*SIZE,height);
    line(0, i*SIZE, width, i*SIZE);
  }
 
 
  // draw stones
  noStroke();
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      
      if(field[i][j]==BLACK){
        fill(0);  //color black
        ellipse((i*2+1)*SIZE/2,(j*2+1)*SIZE/2, STONE_SIZE, STONE_SIZE);
      }else if(field[i][j]==WHITE){
        fill(255); // color white
        ellipse((i*2+1)*SIZE/2,(j*2+1)*SIZE/2, STONE_SIZE, STONE_SIZE);
        
      }
    }
  }
  
  
}
 
void mousePressed(){
  int x = mouseX/SIZE;
  int y = mouseY/SIZE;
 
  if(field[x][y]==NONE){
    if(black_turn){
       field[x][y] = BLACK;
    }else{
      field[x][y] = WHITE;
    }
  }
  
  black_turn = !black_turn;
}
 