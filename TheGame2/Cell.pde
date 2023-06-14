public class Cell{
  //initiate the cell variables
  final  float BLOCK_SIZE = 100.0 * SizeScale;
  final  float BLOCK_SCALEW = BLOCK_SIZE/128.0;
  final  float BLOCK_SCALEH = BLOCK_SIZE/128.0;
  final  float CHEST_SIZE = BLOCK_SIZE/3;
  final  float CHEST_SCALEW = CHEST_SIZE/62;
  final  float CHEST_SCALEH = CHEST_SIZE/55;
  boolean visable;
  boolean ladder;
  Sprite block;
  int this_col;
  int this_row;
  int block_num;
  int counter = 0; 

  
  public Cell(int blocknum, int col, int row, PImage img){
    //constuct the cells according to the block type given by blocknum
    this_col = col;
    this_row= row;
    block_num = blocknum;
    if(blocknum == 0){//creates empty blocks
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
    else if( blocknum == 11){ //creates deep water blocks
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 4, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
    else { //creates standard blocks
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
  }}
}
