public class Cell{
  final static public float BLOCK_SIZE = 100;
  final static float BLOCK_SCALEW = BLOCK_SIZE/128;
  final static float BLOCK_SCALEH = BLOCK_SIZE/146;
  final static float CHEST_SIZE = BLOCK_SIZE/3;
  final static float CHEST_SCALEW = CHEST_SIZE/62;
  final static float CHEST_SCALEH = CHEST_SIZE/55;
  boolean visable;
  Sprite block;
  int this_col;
  int this_row;

  
  public Cell(int blocknum, int col, int row, PImage img){
    this_col = col;
    this_row= row;
    if(blocknum == 0){
     
      visable = false;
    }
    else {
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
  }
  public void display(){
    if (visable){
    block.display();
    }
    else{
      rect( this_col * BLOCK_SIZE,  this_row * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
   // rect(BLOCK_SIZE + this_col * BLOCK_SIZE, BLOCK_SIZE + this_row * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
  }}
}
