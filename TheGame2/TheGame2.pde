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
int land_block; 
int head_block;
int side_block;
float viewX = 0;
float viewY = height;
float mapHeight;
float mapWidth;
int[] xZone = new int[2];
int[] yZone = new int[2];
int z = 0;

public PGraphics blockGraphics;
PImage mapimg;
PImage bakgroundimg;
Sprite player;
Sprite reward;
PImage[] blocks = new PImage[11];

Sprite ladder;
ArrayList<Cell> cells;
boolean treasure = false;
Cell[][] Mapcells;

void setup(){
  fullScreen(P2D);
  imageMode(CENTER);
  
  bakgroundimg = loadImage("data/blocks/background.png");
  bakgroundimg.resize(displayWidth+400,displayHeight);
  String[] CSVrows = loadStrings("data/blocks/blockMapPelle.csv");
  cells = new ArrayList<Cell>();
  Mapcells = new Cell[split(CSVrows[0], ";").length][CSVrows.length];
  blocks[0] = loadImage("data/blocks/dirt.png");
  blocks[1] = loadImage("data/blocks/dirt_grass.png");
  blocks[2] = loadImage("data/blocks/dirt_sand.png");
  blocks[3] = loadImage("data/blocks/dirt_snow.png");
  blocks[4] = loadImage("data/blocks/gravelseq2.png");
  blocks[5] = loadImage("data/blocks/wood_red.png");
  blocks[6] = loadImage("data/blocks/box_treasure.png");
  blocks[7] = loadImage("data/treasures/runeBlack_slab_002.png");
  blocks[8] = loadImage("data/blocks/dirt.png");
  blocks[9] = loadImage("data/blocks/trunk_top.png");
  blocks[10] = loadImage("data/blocks/ladder_large_resized.png");
  createMap(CSVrows);
  player = new Player(600, 600);
  mapHeight = CSVrows.length;
  mapWidth = split(CSVrows[0], ";").length;
  //print("dispWidth: ", displayWidth, " <<< dispHeight: ", displayHeight);
}
 
void draw(){
  draw_background();
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
        //print(mapHeight-1, " AND " , mapWidth-1);
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
void draw_background(){
  
  int x = z % bakgroundimg.width;
  

  for (int i = -x ; i < width ; i += bakgroundimg.width) {
      copy(bakgroundimg, 0, 0, bakgroundimg.width, height, i, 0, bakgroundimg.width, height);    
  }
}


void scroll(){
 float rightBoundary = viewX + displayWidth - RIGHT_MARGIN;
 if(player.getRight() > rightBoundary){
   viewX += player.getRight() - rightBoundary;
   z+=2;
 }
 
 float leftBoundary = viewX + LEFT_MARGIN;
 if(player.getLeft() < leftBoundary){
   viewX -= leftBoundary - player.getLeft();
   z-=2;
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
  if(!player.isOnLadder){
    player.change_y += GRAVITY;
  }
    player.center_y += player.change_y;
    
    if(player.change_y > 0){
      if(collisionList.get(5).visable && player.getBottom() >= collisionList.get(5).block.getTop() && collisionList.get(8).visable && collisionList.get(2).visable){
        player.setBottom(collisionList.get(5).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        land_block = collisionList.get(5).block_num;
        if(land_block != 3 && (player.change_x == 2||player.change_x == -2)){ 
          player.change_x = 0;
       }
       if ( land_block == 4 && !updated){
         collisionList.get(5).block.update(updated);
         collisionList.get(5).counter++;
         if (collisionList.get(5).counter > 4){
           collisionList.get(5).visable = false;
         }
         updated = true; 
       }
      }
      else if(collisionList.get(5).visable && player.getBottom() >= collisionList.get(5).block.getTop()){
        player.setBottom(collisionList.get(5).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
           land_block = collisionList.get(5).block_num;
        if(land_block != 3 && (player.change_x == 2||player.change_x == -2)){ 
          player.change_x = 0;
       }
       if ( land_block == 4 && !updated){
         collisionList.get(5).block.update(updated);
         collisionList.get(5).counter++;
         if (collisionList.get(5).counter > 4){
           collisionList.get(5).visable = false;
         }
         updated = true; 
       }
      }
      else if(collisionList.get(8).visable && player.getRight() > collisionList.get(8).block.getLeft() && player.getBottom() >= collisionList.get(8).block.getTop()){
        player.setBottom(collisionList.get(8).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        //println(" col 3");
      }
      else if(collisionList.get(2).visable && player.getLeft() < collisionList.get(2).block.getRight() && player.getBottom() >= collisionList.get(2).block.getTop()){
        player.setBottom(collisionList.get(2).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        //println(" col 4");
      }
      else if(collisionList.get(5).ladder && player.getBottom() >= collisionList.get(5).block.getTop()){
        player.isOnLadder = true;
        player.isOnTop = true;
      }
      
      else if(!collisionList.get(5).visable && !collisionList.get(8).visable && !collisionList.get(2).visable){
        player.isOnBlock = false;
      }
    }
    if(player.change_y < 0){
       if(collisionList.get(3).visable && player.getTop() <= collisionList.get(3).block.getBottom()){
         player.setTop(collisionList.get(3).block.getBottom());
         player.isOnBlock = false;
         head_block = collisionList.get(3).block_num;
         player.change_y = 0;
          if ( head_block == 4 && !updated){
         collisionList.get(3).block.update(updated);
         collisionList.get(3).counter++;
         if (collisionList.get(3).counter > 4){
           collisionList.get(3).visable = false;
         }
         updated = true; 
       }
       }
       else if(collisionList.get(3).ladder && player.getBottom() <= collisionList.get(3).block.getTop() || collisionList.get(4).ladder && player.getBottom() <= collisionList.get(4).block.getTop()){
         player.isOnTop = true;
         player.change_y = 0;
       }
    }
  
  player.center_x += player.change_x;
  if(player.change_x > 0){
    if(collisionList.get(7).visable && player.getRight() >= collisionList.get(7).block.getLeft()){
       player.setRight(collisionList.get(7).block.getLeft());
       side_block = collisionList.get(7).block_num;
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
  //float minDist = Cell.BLOCK_SIZE;
  for(int i = 0; i < collisionList.size(); i += 1){
        if(collisionList.get(i).ladder && 
            dist(player.center_x, player.center_y, collisionList.get(i).block.center_x, collisionList.get(i).block.center_y) <= collisionList.get(i).block.w){
          ladder = collisionList.get(i).block;
          player.isOnLadder = true;
        }
      }
   if(ladder != null && player.getLeft() > ladder.getRight() ||
   ladder != null && player.getRight() < ladder.getLeft()){
     player.isOnLadder = false;
     player.isOnTop = false;
   }
}

public ArrayList<Cell> checkColl(Sprite player, Cell[][] blockList){ // creates a 3x3 matrix containing the surrounding blocks of the player
   ArrayList<Cell> collisionList = new ArrayList<Cell>();
   for(int i = int(player.center_x/Cell.BLOCK_SIZE) - 1; i < int(player.center_x/Cell.BLOCK_SIZE) + 2; i++){
     for(int j = int(player.center_y/Cell.BLOCK_SIZE) - 1; j < int(player.center_y/Cell.BLOCK_SIZE) + 2; j++){
       //if(blockList[i][j].visable){
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
  else if(keyCode == UP && player.isOnLadder && ladder != null){
    
    if(player.getBottom() >= ladder.getTop()){
      player.change_y = -WALK_SPEED/2;
      //player.center_y = constrain(player.center_y, ladder.getBottom() - player.h/2, ladder.getTop());
      player.isOnBlock = false;
      player.isOnTop = false;
    }
    else if(player.getBottom() <= ladder.getTop()){
      player.isOnTop = true;
      player.change_y = -JUMP_SPEED;
      player.isOnBlock = false;
      player.isOnLadder = false;
      player.isOnTop = false;
    }
  }
  else if(keyCode == UP && (player.isOnBlock || player.isOnTop)){
    player.change_y = -JUMP_SPEED;
    player.isOnBlock = false;
    updated = false;
    player.isOnLadder = false;
    player.isOnTop = false;
  }
  
  else if(keyCode == DOWN && (player.isOnTop || player.isOnLadder)){
    player.change_y = WALK_SPEED/2;
    player.isOnTop = false;
  }
  else if(key == 'a' && ladder != null){
    print("top: ", player.isOnTop);
    print("\n ladder: ", player.isOnLadder, "\n block: ", player.isOnBlock, "\n");
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    if(land_block == 3){
      player.change_x = 2;
    }
    else{
    player.change_x = 0;
    }
  }
  else if(keyCode == LEFT){
     if(land_block == 3){
      player.change_x = -2;
    }
    else{
    player.change_x = 0;
    }
  }
  else if(keyCode == UP && player.isOnLadder && ladder != null){
    player.change_y = 0;
  }
  else if(keyCode == DOWN && (player.isOnLadder || player.isOnTop)){
    player.change_y = 0;
    player.isOnTop = false;
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
