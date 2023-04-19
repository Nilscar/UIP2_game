public class Cell{
  final static float BLOCK_SIZE = 100;
  final static float BLOCK_SCALEW = BLOCK_SIZE/128;
  final static float BLOCK_SCALEH = BLOCK_SIZE/146;
  final static float CHEST_SIZE = BLOCK_SIZE/3;
  final static float CHEST_SCALEW = CHEST_SIZE/62;
  final static float CHEST_SCALEH = CHEST_SIZE/55;
  boolean visable;
  Sprite block;

  
  public Cell(int blocknum, int col, int row, PImage img){
    print(blocknum,col,row,img);
    if(blocknum == 0||blocknum == 6){
      visable = false;
    }
    else {
      print("sending sprite");
     block = new Sprite(img, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     print(" sprite sent");
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     visable = true;
    }
  }
  public void display(){
    block.display();
  }
}
