public class Cell{
  final static float BLOCK_SIZE = 100;
  final static float BLOCK_SCALEW = BLOCK_SIZE/128;
  final static float BLOCK_SCALEH = BLOCK_SIZE/128;
  final static float CHEST_SIZE = BLOCK_SIZE/3;
  final static float CHEST_SCALEW = CHEST_SIZE/62;
  final static float CHEST_SCALEH = CHEST_SIZE/55;
  boolean visable;
  boolean ladder;
  Sprite block;
  int this_col;
  int this_row;
  int block_num;
  int counter = 0; 

  
  public Cell(int blocknum, int col, int row, PImage img){
    this_col = col;
    this_row= row;
    block_num = blocknum;
    if(blocknum == 0){
      visable = false;
      ladder = false;
    }
    else if(blocknum == 12){ //creates ladders
      block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
      block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
      block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
      visable = false;
      ladder = true;
    }
    else if( blocknum == 4){ //creates stone blocks
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 5, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
    else if( blocknum == 10){ //creates water blocks
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 4, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
    else if( blocknum == 11){
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 4, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
    else { //creates empty blocks
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
     ladder = false;
    }
  }
  public void display(){
    if (visable || ladder){
      block.display();
      if(block_num == 10 ||block_num == 11){
        block.update();
      }
    }
    else{
      //rect( this_col * BLOCK_SIZE,  this_row * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
   // rect(BLOCK_SIZE + this_col * BLOCK_SIZE, BLOCK_SIZE + this_row * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
  }}
}
