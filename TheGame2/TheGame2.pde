// Global variables
final static float WALK_SPEED = 6;
final static float JUMP_SPEED = 14.4;
final static float GRAVITY = 0.5;
PImage menu;
String state ="game";


final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 50;

float viewX = 0;
float viewY = height;
int mapHeight;
int mapWidth;
int[] xZone = new int[2];
int[] yZone = new int[2];

public PGraphics blockGraphics;
PImage mapimg;

Sprite player;
Sprite reward;
PImage[] blocks = new PImage[8];
ArrayList<Cell> cells;
boolean treasure = false;
Cell[][] Mapcells = new Cell[23][21];

void setup(){
  fullScreen(P2D);
  imageMode(CENTER);
  String[] CSVrows = loadStrings("data/blocks/blockMap.csv");
  mapHeight = CSVrows.length;
  mapWidth = split(CSVrows[0], ";").length;
  print("Height: ", mapHeight, " ==> Width: ", mapWidth);
  cells = new ArrayList<Cell>();
  Mapcells = new Cell[mapWidth][mapHeight];
  blocks[0] = loadImage("data/blocks/tileDirt.png");
  blocks[1] = loadImage("data/blocks/tileGrass.png");
  blocks[2] = loadImage("data/blocks/tileSand.png");
  blocks[3] = loadImage("data/blocks/tileSnow.png");
  blocks[4] = loadImage("data/blocks/tileStone.png");
  blocks[5] = loadImage("data/blocks/tileWood.png");
  blocks[6] = loadImage("data/blocks/box_treasure.png");
  blocks[7] = loadImage("data/treasures/runeBlack_slab_002.png");
  createMap(CSVrows);
  player = new Player( 500, 500);
}
 
void draw(){
 int playercol = int(player.center_x/Cell.BLOCK_SIZE);
 int playerrow = int(player.center_y/Cell.BLOCK_SIZE);
  if(playercol > 0 && playercol < 13){
   xZone[0] = playercol-1;
   xZone[1] = playercol+10;
  }
  if(playerrow > 0 && playerrow < 11){
   yZone[0] = playerrow-1;
   yZone[1] = playerrow+10;
  }
    for (int i = xZone[0]; i<xZone[1]; i++){
      for (int j = yZone[0]; j<yZone[1]; j++){
        //print("  i = ", i, "        j = ",j);
       // cells.get(i).display();
        Mapcells[i][j].display();
      }
    }
  
  player.display();
  player.update();
  blockCollisions(player, Mapcells);
  //scroll();
}

void scroll(){
 float rightBoundary = viewX + width - RIGHT_MARGIN;
 if(player.getRight() > rightBoundary){
   viewX += player.getRight() - rightBoundary;
 }
 
 float leftBoundary = viewX + LEFT_MARGIN;
 if(player.getLeft() < leftBoundary){
   viewX -= leftBoundary - player.getLeft();
 }
 
 float bottomBoundary = viewY + height - VERTICAL_MARGIN;
 if(player.getBottom() > bottomBoundary){
   viewY += player.getBottom() - bottomBoundary;
 }
 
 float topBoundary = viewY + VERTICAL_MARGIN;
 if(player.getTop() < topBoundary){
   viewY -= topBoundary - player.getTop();
 }
 translate(-viewX, -viewY);
}


//Checking for collisions and setting the correct SPEED in both x&y directions
public void blockCollisions(Sprite player, Cell[][] blocks){
   player.change_y += GRAVITY;
   player.center_y += player.change_y;
   player.center_x += player.change_x;
   ArrayList<Sprite> collisionList = new ArrayList<Sprite>(); // make an array instead and sort according to the needs later!!
   for(int i = int(player.getLeft()/Cell.BLOCK_SIZE); i < int(player.getRight()/Cell.BLOCK_SIZE) + 2; i++){
     for(int j = int(player.getTop()/Cell.BLOCK_SIZE); j < int(player.getBottom()/Cell.BLOCK_SIZE) + 2; j++){
       if(blocks[i][j].visable){
         collisionList.add(blocks[i][j].block);
       }
     }
   }
   //print("   <<collisionList: ", collisionList.size(), "  end of it!!!");
   if(collisionList.size() > 0){
    Sprite collision = collisionList.get(0);
    if(player.change_y > 0){
      player.setBottom(collision.getTop());
      player.isOnBlock = true;
    }
    else if(player.change_y < 0){
     player.setTop(collision.getBottom()); 
    }
    player.change_y = 0;
   
     if(player.change_x < 0){
       player.setLeft(collision.getRight());
     }
     else if(player.change_x > 0){
       player.setRight(collision.getLeft());
     }
   }
} // End of blockCollisions()

//boolean for checking collisions between player and blocks
boolean checkCollision(Sprite player, Sprite block){
  boolean noXOverlap = player.getRight() <= block.getLeft() || player.getLeft() >= block.getRight();
  boolean noYOverlap = player.getBottom() <= block.getTop() || player.getTop() >= block.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

//Checking collisions between player and blocks
public ArrayList<Sprite> checkCollisions(Sprite player, ArrayList<Sprite> blockList){
  ArrayList<Sprite> collisionList = new ArrayList<Sprite>();
  for(Sprite block: blockList){
    if(checkCollision(player, block))
      collisionList.add(block);
  }
  return collisionList;
}

void keyPressed(){
  if(keyCode == RIGHT){
    player.change_x = WALK_SPEED;
  }
  else if(keyCode == LEFT){
    player.change_x = -WALK_SPEED;
  }
  else if(keyCode == UP && player.change_y==0){
    player.change_y = -JUMP_SPEED;
    player.isOnBlock = false;
  }
  else if(key == 'a' && player.treasure){
    treasure = true;
    player.treasure = false;
    print("a pressed. ");
  }
  else if(keyCode == ENTER){
    state = "game";
  }
   else if(keyCode == 80){
    state = "menu";
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    player.change_x = 0;
  }
  else if(keyCode == LEFT){
    player.change_x = 0;
  }
}

//Creating the game map from csv file
void createMap(String[] blockrows){
  //print("HEEEERE:        ", blocks[1]);
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ";");
   //print("Col length is" ,columns.length);
   for(int col = 0; col < columns.length; col++){
     Cell cell = new Cell(int(columns[col]), col, row, blocks[int(columns[col])]);
     cells.add(cell);
     Mapcells[col][row] = cell;
    } 
  }
}//End of createMapFrame()
