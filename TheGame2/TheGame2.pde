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
float mapHeight;
float mapWidth;
int[] xZone = new int[2];
int[] yZone = new int[2];

public PGraphics blockGraphics;
PImage mapimg;

Sprite player;
Sprite reward;
PImage[] blocks = new PImage[8];
ArrayList<Cell> cells;
boolean treasure = false;
Cell[][] Mapcells;

void setup(){
  fullScreen(P2D);
  imageMode(CENTER);
  String[] CSVrows = loadStrings("data/blocks/blockMap.csv");
  cells = new ArrayList<Cell>();
  Mapcells = new Cell[split(CSVrows[0], ";").length][CSVrows.length];
  blocks[0] = loadImage("data/blocks/tileDirt.png");
  blocks[1] = loadImage("data/blocks/tileGrass.png");
  blocks[2] = loadImage("data/blocks/tileSand.png");
  blocks[3] = loadImage("data/blocks/tileSnow.png");
  blocks[4] = loadImage("data/blocks/tileStone.png");
  blocks[5] = loadImage("data/blocks/tileWood.png");
  blocks[6] = loadImage("data/blocks/box_treasure.png");
  blocks[7] = loadImage("data/treasures/runeBlack_slab_002.png");
  createMap(CSVrows);
  player = new Player(500, 500);
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
  //movement(player);
  collisions(player, Mapcells);
}

public void movement(Sprite player){
  player.center_x += player.change_x;
  player.center_y += player.change_y;
}

public void collisions(Sprite player, Cell[][] mapBlocks){
  //player.change_y += GRAVITY;
  player.center_y += player.change_y;
  ArrayList<Cell> collisionList = checkColl(player, mapBlocks);
  //print("  << size: ", collisionList.size());
  if(player.change_y > 0){
    if(collisionList.get(5).visable){
      player.setBottom(collisionList.get(5).block.getTop());
    }
    /*
    for(int i = 2; i < collisionList.size(); i += 3){
      if(collisionList.get(i).visable && player.getRight() >= collisionList.get(i).block.getLeft() || collisionList.get(i).visable && player.getLeft() <= collisionList.get(i).block.getRight()){
        //print("  >> getTop():  ", collisionList.get(i).block.getTop());
        player.setBottom(collisionList.get(i).block.getTop());
      }
    }*/
  }
  if(player.change_y < 0){
     if(collisionList.get(3).visable){
       player.setTop(collisionList.get(3).block.getBottom());
     }
  }
  player.center_x += player.change_x;
  if(player.change_x > 0){
    if(collisionList.get(7).visable){
       player.setRight(collisionList.get(7).block.getLeft());
     }
  }
  if(player.change_x < 0){
    if(collisionList.get(1).visable){
       player.setLeft(collisionList.get(1).block.getRight());
     }
  }
}

public ArrayList<Cell> checkColl(Sprite player, Cell[][] blockList){
   int playercol = int(player.center_x/Cell.BLOCK_SIZE);
   int playerrow = int(player.center_y/Cell.BLOCK_SIZE);
   ArrayList<Cell> collisionList = new ArrayList<Cell>(); // make an array instead and sort according to the needs later!!
   if(playercol > 1 && playercol <20){
       if(playerrow >1 && playerrow < 22){
   for(int i = int(player.center_x/Cell.BLOCK_SIZE) - 1; i < int(player.center_x/Cell.BLOCK_SIZE) + 2; i++){
     for(int j = int(player.center_y/Cell.BLOCK_SIZE) - 1; j < int(player.center_y/Cell.BLOCK_SIZE) + 2; j++){
       //if(blockList[i][j].visable){ //This .visable replaces the checkCollision function
         collisionList.add(blockList[i][j]);
       //}
       }
      }
     }
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
  else if(keyCode == UP){
    player.change_y = -WALK_SPEED;
  }
  else if(keyCode == DOWN){
    player.change_y = WALK_SPEED;
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    player.change_x = 0;
  }
  else if(keyCode == LEFT){
    player.change_x = 0;
  }
  else if(keyCode == UP){
    player.change_y = 0;
  }
  else if(keyCode == DOWN){
    player.change_y = 0;
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
