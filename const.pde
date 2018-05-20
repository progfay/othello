final int SIZE            = 100;
final int STONE_SIZE      = (int)(SIZE*0.7);
final int GAME_TRIAL_NUM  = 100;
final int LEARN_TRIAL_NUM = 100;

final Length [] UNIT_DIRECTION = {
  new Length(-1, -1), 
  new Length(-1, +0), 
  new Length(-1, +1), 
  new Length(+0, -1), 
  new Length(+0, +1), 
  new Length(+1, -1), 
  new Length(+1, +0), 
  new Length(+1, +1)
};

final int [][] EVALUATE_VALUE = {
  {+8, -2, +3, +3, +3, +3, -2, +8}, 
  {-2, +1, +2, +2, +2, +2, +1, -2}, 
  {+3, +2, +1, +1, +1, +1, +2, -3}, 
  {+3, +2, +1, +1, +1, +1, +2, -3}, 
  {+3, +2, +1, +1, +1, +1, +2, -3}, 
  {+3, +2, +1, +1, +1, +1, +2, -3}, 
  {-2, +1, +2, +2, +2, +2, +1, -2}, 
  {+8, -2, +3, +3, +3, +3, -2, +8}
};
