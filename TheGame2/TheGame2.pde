// Global variables
float WALK_SPEED = 6;
float JUMP_SPEED = 14.4;
final static float GRAVITY = 0.5;
PImage menu;
import ddf.minim.*;
AudioPlayer Audioplayer;
AudioPlayer Pun;
Minim minim;//audio context

int healthPoints = 25;
int hpCounter = healthPoints;
int expCounter = 0;
int lvlCounter = 1;
boolean pause;
Menu pauseScreen;

float currentX;
float currentY;

final static float RIGHT_MARGIN = 500;
final static float LEFT_MARGIN = 500;
final static float VERTICAL_MARGIN = 500;
boolean updated = false;

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
Player player;
Mob pig;
Sprite reward;
PImage[] blocks = new PImage[13];

Sprite ladder;
ArrayList<Cell> cells;
boolean treasure = false;
Cell[][] Mapcells;

void setup(){
  fullScreen(P2D);
  imageMode(CENTER);
  minim = new Minim(this);
  Audioplayer = minim.loadFile("data/music/backSong.mp3", 2048);
  Audioplayer.play();
  Pun = minim.loadFile("data/music/roblox.mp3", 2048);
  pauseScreen = new Menu();
  
  pause = true;

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
  blocks[10] = loadImage("data/blocks/Watershallow.png");
  blocks[11] = loadImage("data/blocks/Waterdeep.png");
  blocks[12] = loadImage("data/blocks/ladder_large_resized.png");
  createMap(CSVrows);
  player = new Player(600, 600);
  currentX = player.center_x;
  currentY = player.center_y;
  pig = new Mob(200,600);
  mapHeight = CSVrows.length;
  mapWidth = split(CSVrows[0], ";").length;
  //print("dispWidth: ", displayWidth, " <<< dispHeight: ", displayHeight);
}
 
void draw(){
  if(pause){

    background(#3890BF);
    pauseScreen.viewMenu(str(int(100*hpCounter/healthPoints)), str(lvlCounter));
    player.center_x = pauseScreen.panelLeft.getLeft() + pauseScreen.MENU_MARGIN/2;
    player.center_y = pauseScreen.panelLeft.getTop() + pauseScreen.MENU_MARGIN;
    player.display();
    player.update();
  }
  else{
    imageMode(CENTER);
    draw_background();
    int playercol = int(player.center_x/Cell.BLOCK_SIZE);
    int playerrow = int(player.center_y/Cell.BLOCK_SIZE);
       scroll();
     xZone[0] = playercol-10;
     xZone[1] = playercol+10;
     yZone[0] = playerrow-6;
     yZone[1] = playerrow+6;
    for (int i = xZone[0]; i<xZone[1]; i++){
      for (int j = yZone[0]; j<yZone[1]; j++){
        if(i >= 0 && i < mapWidth){
          if(j >= 0 && j < mapHeight){
            Mapcells[i][j].display();
          }
        }
      }
    }
    pauseScreen.drawBars(player);
    player.display();
    player.update();
    pig.display();
    pig.update();
    collisions(player, Mapcells);
    collisions(pig, Mapcells);
    if(keyPressed && (keyCode == UP && player.isOnLadder && ladder != null)){
      if(player.getBottom() >= ladder.getTop()){
        player.change_y = -WALK_SPEED/2;
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
  }
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

public void collisions(Sprite player, Cell[][] mapBlocks){
  ArrayList<Cell> collisionList = checkColl(player, mapBlocks);
  if(!player.isOnLadder){
    player.change_y += GRAVITY;
  }
    player.center_y += player.change_y;
    if(player.center_y/Cell.BLOCK_SIZE < 19 && player.dead){
       player.change_y = 1;
       hpCounter = 0;
       pauseScreen.updateBars(hpCounter, "hp");
       }
    else if (player.center_y/Cell.BLOCK_SIZE > player.deadspot && player.dead){
       player.change_y = -GRAVITY;
       hpCounter = 0;
       pauseScreen.updateBars(hpCounter, "hp");
       }
          
    if(player.change_y > 0){
      if(collisionList.get(5).visable && player.getBottom() >= collisionList.get(5).block.getTop() && collisionList.get(8).visable && collisionList.get(2).visable && !player.dead){
        player.setBottom(collisionList.get(5).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        player.land_block = collisionList.get(5).block_num;
        
        if(player.land_block != 3 && (player.change_x == 2||player.change_x == -2)&& player.isPlayer){ 
          player.change_x = 0;
       }
       if(player.land_block == 10 && !player.dead && player.isPlayer){ 
         println("coll water 1");
         print(player.center_y/Cell.BLOCK_SIZE);
          player.dead = true;
          player.change_x = 0;
          player.isOnBlock = false;
          hpCounter = 0;
          pauseScreen.updateBars(hpCounter, "hp");
       }
        else if (  player.land_block == 4 && !updated && player.isPlayer){// Add damage
         collisionList.get(5).block.stone_update(updated);
         collisionList.get(5).counter++;
         hpCounter--;
         if (collisionList.get(5).counter > 4){
           collisionList.get(5).visable = false;
         }
         updated = true; 
         if(abs(hpCounter - healthPoints) == 1){
           pauseScreen.updateBars(hpCounter, "hp");
         }
         else if(hpCounter > 1 && abs(hpCounter - healthPoints) > 1){
           pauseScreen.updateBars(hpCounter, "hp");
         }
       }
      }
      else if(collisionList.get(5).visable && player.getBottom() >= collisionList.get(5).block.getTop() && !player.dead){
        player.setBottom(collisionList.get(5).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
           player.land_block = collisionList.get(5).block_num;
        if(player.land_block != 3 && (player.change_x == 2||player.change_x == -2)&& player.isPlayer){ 
          player.change_x = 0;
       }

       if ( player.land_block == 4 && !updated && player.isPlayer){ //Add damage
         collisionList.get(5).block.stone_update(updated);
         collisionList.get(5).counter++;
         hpCounter--;
         if (collisionList.get(5).counter > 4){
           collisionList.get(5).visable = false;
         }
         updated = true;
         if(abs(hpCounter - healthPoints) == 1){
           pauseScreen.updateBars(hpCounter, "hp");
         }
         else if(hpCounter > 1 && abs(hpCounter - healthPoints) > 1){
           pauseScreen.updateBars(hpCounter, "hp");
         }
       }
       if(player.land_block == 10 && !player.dead && player.isPlayer){ 
         println("coll water 2");
         print(player.center_y/Cell.BLOCK_SIZE);
          player.dead = true;
          player.change_x = 0;
          player.isOnBlock = false;
          hpCounter = 0;
          pauseScreen.updateBars(hpCounter, "hp");
       }
      }
      else if(collisionList.get(8).visable && player.getRight() > collisionList.get(8).block.getLeft() && player.getBottom() >= collisionList.get(8).block.getTop()){
        player.setBottom(collisionList.get(8).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        player.land_block = collisionList.get(8).block_num;
        
        if(player.land_block == 10 && !player.dead && player.isPlayer){ 
          println("coll water 3");
         print(player.center_y/Cell.BLOCK_SIZE);
          player.dead = true;
          player.change_x = 0;
          player.isOnBlock = false;
          hpCounter = 0;
          pauseScreen.updateBars(hpCounter, "hp");
       }
      }
      else if(collisionList.get(2).visable && player.getLeft() < collisionList.get(2).block.getRight() && player.getBottom() >= collisionList.get(2).block.getTop()){
        player.setBottom(collisionList.get(2).block.getTop());
        player.isOnBlock = true;
        player.change_y = 0;
        player.land_block = collisionList.get(2).block_num;
        if(player.land_block == 10 && !player.dead && player.isPlayer){ 
          println("coll water 4");
         print(player.center_y/Cell.BLOCK_SIZE);
          player.dead = true;
          player.change_x = 0;
          player.isOnBlock = false;
          hpCounter = 0;
          pauseScreen.updateBars(hpCounter, "hp");

       }
        
      }
      else if(collisionList.get(5).ladder && player.getBottom() >= collisionList.get(5).block.getTop()){
        player.isOnLadder = true;
        player.isOnTop = true;
      }
      
      else if(!collisionList.get(5).visable && !collisionList.get(8).visable && !collisionList.get(2).visable){
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
         player.head_block = collisionList.get(3).block_num;
         player.change_y = 0;
          if ( player.head_block == 4 && !updated && player.isPlayer){
         collisionList.get(3).block.stone_update(updated);
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
       player.side_block = collisionList.get(7).block_num;
       if(!player.isPlayer){player.change_x = - player.change_x;}
       if(collisionList.get(5).visable == false){
        player.isOnBlock = false;
       }
       
       
     }
  }
  if(player.change_x < 0){
    if(collisionList.get(1).visable && player.getLeft() <= collisionList.get(1).block.getRight()){
       player.setLeft(collisionList.get(1).block.getRight());
       if(!player.isPlayer){player.change_x = - player.change_x;}
       if(collisionList.get(5).visable == false || collisionList.get(2).visable == false){
        player.isOnBlock = false;
       }
     }
  }
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
         collisionList.add(blockList[i][j]);
     }
   }
   return collisionList;
}
void Punch(){
  if (player.change_x >= 0){
  float PunchRadie = player.center_x +90;
  if(pig.center_x > player.center_x && pig.center_x < PunchRadie && (int(pig.center_y/100) == int(player.center_y/100))){
    print("BAAAM");
        print("pig.center_x  : ", pig.center_x, "player.center_x : ",player.center_x);
    print("pig.center_y  : ", int(pig.center_y/100), "player.center_y : ",int(player.center_y/100));
    println("-------------------");
    Pun.rewind();
    Pun.play();
    pig.life--;
    pig.change_x = pig.change_x*3.2;
    }
  }
  else{
  float PunchRadie = player.center_x -90;
  if(pig.center_x < player.center_x && pig.center_x > PunchRadie && (int(pig.center_y/100) == int(player.center_y/100))){
    print("pig.center_x  : ", pig.center_x, "player.center_x : ",player.center_x);
    print("pig.center_y  : ", int(pig.center_y/100), "player.center_y : ",int(player.center_y/100));
    println("-------------------");
    Pun.rewind();
    Pun.play();
    pig.life--;
    pig.change_x = pig.change_x*3.2;
    }
  }
  
  
}

void keyPressed(){
  if(keyCode == RIGHT && !player.dead){
    player.change_x = WALK_SPEED;
  }
  else if(keyCode == 32 && !player.dead){
    Punch();
  }
  else if(keyCode == LEFT&& !player.dead){
    player.change_x = -WALK_SPEED;
  }
  else if(keyCode == UP && (player.isOnBlock || player.isOnTop) && !player.dead){
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
  else if(key == 'a' && !pause){
    if(expCounter == 0){
      pauseScreen.updateBars(expCounter, "lvl");
      expCounter += 1;
    }
    else if(expCounter > 0 && expCounter <= healthPoints - 2){
      pauseScreen.updateBars(expCounter, "lvl");
      expCounter += 1;
    }
    else{
      pauseScreen.updateBars(expCounter, "lvl");
      expCounter = 0;
      WALK_SPEED += lvlCounter;
      JUMP_SPEED += lvlCounter;
      lvlCounter += 1;
      //print(" \n lvl: ", lvlCounter, " >>>");
    }
  }
  else if(key == 'q'){
    if(pause){
      player.center_x = currentX;
      player.center_y = currentY;
      pause = false;
    }
    else{
      currentX = player.center_x;
      currentY = player.center_y;
      pause = true;
    }
  }
  else if(key == 'w'){
    println("pause meassures center_x: ", pauseScreen.leftBoxDown.center_x);
    println("pause meassures: ", pauseScreen.leftBoxDown.getLeft());
    }
}

void keyReleased(){
  if(keyCode == RIGHT && !player.dead){
    if(player.land_block == 3){
      player.change_x = 2;
    }
    else if(player.isOnLadder && keyCode != UP){
      player.change_y = 0;
      player.change_x = 0;
    }
    else{
      player.change_x = 0;
    }
  }
  else if(keyCode == LEFT && !player.dead){
     if(player.land_block == 3){
      player.change_x = -2;
    }
    else if(player.isOnLadder && keyCode != UP){
      player.change_y = 0;
      player.change_x = 0;
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
  else if(key == 'a' && expCounter == healthPoints - 1){
    pauseScreen.updateBars(expCounter, "lvl");
    expCounter += 1;
  }
}

void mouseClicked(){
  //println("mouseClicked, pmouseX: ", pmouseX, "\n pmouseY: ", pmouseY, "\n");
  //println("button x: ", pauseScreen.crossButton.getLeft(), "-", pauseScreen.crossButton.getRight(), "\nbutton y: ", pauseScreen.crossButton.getTop(), "-", pauseScreen.crossButton.getBottom());
  if(pmouseX >= pauseScreen.crossButton.getLeft() && pmouseX <= pauseScreen.crossButton.getRight() && 
     pmouseY <= pauseScreen.crossButton.getBottom() && pmouseY >= pauseScreen.crossButton.getTop() && pause && mouseButton == LEFT){
       player.center_x = currentX;
       player.center_y = currentY;
       pause = !pause;
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
