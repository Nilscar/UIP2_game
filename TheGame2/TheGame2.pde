// Global variables
final static float WALK_SPEED = 6;
final static float JUMP_SPEED = 14.4;
final static float GRAVITY = 0.5;
PImage menu;
String state ="game";


final static float RIGHT_MARGIN = 500;
final static float LEFT_MARGIN = 500;
final static float VERTICAL_MARGIN = 500;
boolean updated = false;
int blocktype; 
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
  String[] CSVrows = loadStrings("data/blocks/blockMapPelle.csv");
  cells = new ArrayList<Cell>();
  Mapcells = new Cell[split(CSVrows[0], ";").length][CSVrows.length];
  blocks[0] = loadImage("data/blocks/tileDirt.png");
  blocks[1] = loadImage("data/blocks/tileGrass.png");
  blocks[2] = loadImage("data/blocks/tileSand.png");
  blocks[3] = loadImage("data/blocks/tileSnow.png");
  blocks[4] = loadImage("data/blocks/tileseq_stone.png");
  blocks[5] = loadImage("data/blocks/tileWood.png");
  blocks[6] = loadImage("data/blocks/box_treasure.png");
  blocks[7] = loadImage("data/treasures/runeBlack_slab_002.png");
  createMap(CSVrows);
  player = new Player(600, 600);
  mapHeight = CSVrows.length;
  mapWidth = split(CSVrows[0], ";").length;
}
 
void draw(){
  background(0);
 int playercol = int(player.center_x/Cell.BLOCK_SIZE);
 int playerrow = int(player.center_y/Cell.BLOCK_SIZE);
     scroll();
  //if(playercol > 0 && playercol < 13){
   xZone[0] = playercol-10;
   xZone[1] = playercol+10;
 // }
 // if(playerrow > 0 && playerrow < 11){
   yZone[0] = playerrow-6;
   yZone[1] = playerrow+6;
 // }
    for (int i = xZone[0]; i<xZone[1]; i++){
      for (int j = yZone[0]; j<yZone[1]; j++){
        //cells.get(i).display();
        if(i >= 0 && i < mapWidth){
                // print("   i :      "  , i,"    j    :    " ,j);

          if(j >= 0 && j < mapHeight){
            Mapcells[i][j].display();
          }
        }
      }
    }
    
  player.display();
  player.update(updated);
  //movement(player);
  collisions(player, Mapcells);
}
void scroll(){
 float rightBoundary = viewX + displayWidth - RIGHT_MARGIN;
 if(player.getRight() > rightBoundary){
   viewX += player.getRight() - rightBoundary;
 }
 
 float leftBoundary = viewX + LEFT_MARGIN;
 if(player.getLeft() < leftBoundary){
   viewX -= leftBoundary - player.getLeft();
 }
 
 float bottomBoundary = viewY + displayHeight - VERTICAL_MARGIN;
 if(player.getBottom() > bottomBoundary){
   viewY += player.getBottom() - bottomBoundary;
 }
 
 float topBoundary = viewY + VERTICAL_MARGIN;
 if(player.getTop() < topBoundary){
   viewY -= topBoundary - player.getTop();
 }
 translate(-viewX, -viewY);
}
public void movement(Sprite player){
  player.center_x += player.change_x;
  player.center_y += player.change_y;
}

public void collisions(Sprite player, Cell[][] mapBlocks){
  ArrayList<Cell> collisionList = checkColl(player, mapBlocks);
  //if(player.isOnBlock == false){
    player.change_y += GRAVITY;
  //  }
    player.center_y += player.change_y;
    
    //print("  << size: ", collisionList.size());
    if(player.change_y > 0){
      if(collisionList.get(5).visable && player.getBottom() >= collisionList.get(5).block.getTop()){
        player.setBottom(collisionList.get(5).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        blocktype = collisionList.get(5).block_num;
        if(blocktype != 3 && (player.change_x == 2||player.change_x == -2)){ 
          player.change_x = 0;
       }
       if ( blocktype == 4){
         collisionList.get(5).block.update(updated);
         updated = true; 
       }
      }
      if(collisionList.get(5).visable == false){
        player.isOnBlock = false;
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
       if(collisionList.get(3).visable && player.getTop() <= collisionList.get(3).block.getBottom()){
         player.setTop(collisionList.get(3).block.getBottom());
         player.isOnBlock = false;
         player.change_y = 0;
       }
    }
  
  player.center_x += player.change_x;
  if(player.change_x > 0){
    if(collisionList.get(7).visable && player.getRight() >= collisionList.get(7).block.getLeft()){
       player.setRight(collisionList.get(7).block.getLeft());
       if(collisionList.get(5).visable == false){
        player.isOnBlock = false;
       }
     }
  }
  if(player.change_x < 0){
    if(collisionList.get(1).visable && player.getLeft() <= collisionList.get(1).block.getRight()){
       player.setLeft(collisionList.get(1).block.getRight());
       if(collisionList.get(5).visable == false || collisionList.get(2).visable == false){
        player.isOnBlock = false;
       }
     }
  }
}

public ArrayList<Cell> checkColl(Sprite player, Cell[][] blockList){
   ArrayList<Cell> collisionList = new ArrayList<Cell>(); // make an array instead and sort according to the needs later!!
   for(int i = int(player.center_x/Cell.BLOCK_SIZE) - 1; i < int(player.center_x/Cell.BLOCK_SIZE) + 2; i++){
     for(int j = int(player.center_y/Cell.BLOCK_SIZE) - 1; j < int(player.center_y/Cell.BLOCK_SIZE) + 2; j++){
       //if(blockList[i][j].visable){ //This .visable replaces the checkCollision function
         collisionList.add(blockList[i][j]);
       //}
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
  else if(keyCode == UP && player.isOnBlock){
    player.change_y = -JUMP_SPEED;
    player.isOnBlock = false;
    updated = false; 
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    if(blocktype == 3){
      player.change_x = 2;
    }
    else{
    player.change_x = 0;
    }
  }
  else if(keyCode == LEFT){
     if(blocktype == 3){
      player.change_x = -2;
    }
    else{
    player.change_x = 0;
    }
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
