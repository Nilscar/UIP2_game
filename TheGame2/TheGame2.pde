// Global variables
float WALK_SPEED = 6;
float JUMP_SPEED = 14.4;
final static float GRAVITY = 0.5;
PImage menu;
import ddf.minim.*;
AudioPlayer Audioplayer;
AudioPlayer Pun;
Minim minim;//audio context
PFont f;

StringList Tutorial = new StringList();
  
int textReader = 0; 

PImage fartRight;
PImage[] FartRight = new PImage[4];
PImage fartLeft;
PImage[] FartLeft = new PImage[4];
PImage portalRed;
PImage[] PortalRed = new PImage[2];
PImage portalGreen;
PImage[] PortalGreen = new PImage[2];
PImage button;
PImage[] Button = new PImage[2];
PImage bubble;
int healthPoints = 11;
int hpCounter = healthPoints-1;
int expCounter = 0;
int lvlCounter = 1;
boolean attacked = false;
boolean pause;
Menu pauseScreen;
int timeNowR;
int timeNowL;
int time;
int ballspawned =19;
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
int[] portal1_in = new int[2];
int[] portal1_out = new int[2];
int[] portal2_in = new int[2];
int[] portal2_out = new int[2];
int[] portal3_in = new int[2];
int[] portal3_out = new int[2];

public PGraphics blockGraphics;
PImage mapimg;
PImage bakgroundimg;
Player player;
Mob[] pig = new Mob[3];
Mob[] chick = new Mob[3];
Mob doll;
Mob farmer; 
HalmBall[] ball = new HalmBall[20]; 
//HalmBall ball;
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
  //Audioplayer.play();
   f = createFont("Arial",70,true);
  createTutorial();
  Pun = minim.loadFile("data/music/burp.mp3", 2048);
  pauseScreen = new Menu();
  fartRight = loadImage("data/fartRight.png");
  fartLeft = loadImage("data/fartLeft.png"); 
  portalRed = loadImage("data/portalRed.png");
  portalGreen = loadImage("data/portalGreen.png");
  button = loadImage("data/Button.png"); 
  bubble = loadImage("data/bubble.png"); 
  bubble.resize(400,280); 
  Button[0] = button.get(0,0,128,64);
  Button[1] = button.get(128,0,128,64);
  button =Button[0];
  PortalRed[0] = portalRed.get(0,0,128,128);
  PortalRed[1] = portalRed.get(128,0,128,128);
  PortalGreen[0] = portalGreen.get(0,0,128,128);
  PortalGreen[1] = portalGreen.get(128,0,128,128);
  portal1_in[0] = 1250;
  portal1_in[1] = 7130;
  portal1_out[0] = 300;
  portal1_out[1] = 2200;
  portal2_in[0] = 4350;
  portal2_in[1] = 2500;
  portal2_out[0] = 300;
  portal2_out[1] = 300;
  portal3_in[0] = 2350;
  portal3_in[1] = 500;
  portal3_out[0] = 1780;
  portal3_out[1] = 7100;
  for(int bals = 0; bals <20;bals++){
    ball[bals] = new HalmBall(true);
  }
  
  for (int fartimg = 0; fartimg < 4 ; fartimg++){
    
    FartRight[fartimg] = fartRight.get(int(120*(fartimg%4)), 0, 120, 90);
    FartRight[fartimg].resize(80, 50);
    FartLeft[fartimg] = fartLeft.get(int(120*(fartimg%4)), 0, 120, 90);
    FartLeft[fartimg].resize(80, 50);
  }
  
  pause = true;

  bakgroundimg = loadImage("data/blocks/background.png");
  bakgroundimg.resize(displayWidth+400,displayHeight);
  String[] CSVrows = loadStrings("data/blocks/blockMapPelle.csv");
  cells = new ArrayList<Cell>();
  Mapcells = new Cell[split(CSVrows[0], ";").length][CSVrows.length];
  blocks[0] = loadImage("data/blocks/dirt.png");
  blocks[1] = loadImage("data/blocks/dirt_grass.png");
  blocks[2] = loadImage("data/blocks/brick_grey.png");
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
  player = new Player(400, 7000);
  //player = new Player(3780,5370);
  pig[0] = new Mob(200,600,1);
  pig[1] = new Mob(2400,1700,1);
  pig[2] = new Mob(3400,1200,1);
  doll = new Mob(300,7140,3);
  chick[0] = new Mob(400,600,2);
  chick[1] = new Mob(1300,500,2);
  chick[2] = new Mob(800,2600,2);
  farmer = new Mob(3780,5370,4);
  currentX = player.center_x;
  currentY = player.center_y;
  mapHeight = CSVrows.length;
  mapWidth = split(CSVrows[0], ";").length;
  //print("dispWidth: ", displayWidth, " <<< dispHeight: ", displayHeight);
}
 void createTutorial(){
   Tutorial.append("Welcome to the tutorial, press enter to continue");
   Tutorial.append("you move through the world using the arrow keys");
   Tutorial.append( "you jump and climb ladders with the up arrow");
   Tutorial.append("you attack using the space bar, you can only attack facing you enemies");
   Tutorial.append("killing enemies give you exp, as seen in the blue bar in the top right corner of you screen");
   Tutorial.append("Dont get to close to the enemies, as they attack back and you will lose HP");
   Tutorial.append("Your goal is to find and defeat the Local Farmer");
   Tutorial.append("Remember, Zombies can't swim");
   Tutorial.append("Go through the portal to begin your adventure");
 }
void draw(){
  if(pause){

    background(#3890BF);
    pauseScreen.viewMenu(str(int(110*hpCounter/healthPoints)), str(lvlCounter));
    player.center_x = pauseScreen.panelLeft.getLeft() + pauseScreen.MENU_MARGIN/2;
    player.center_y = pauseScreen.panelLeft.getTop() + pauseScreen.MENU_MARGIN + pauseScreen.healthBar[0].height/2;
    player.display();
    player.update();
    
  }
  else{
    imageMode(CENTER);
    draw_background();
    int playercol = int(player.center_x/Cell.BLOCK_SIZE);
    int playerrow = int(player.center_y/Cell.BLOCK_SIZE);
    time = millis();
       scroll();
     xZone[0] = playercol-13;
     xZone[1] = playercol+13;
     yZone[0] = playerrow-8;
     yZone[1] = playerrow+8;
    for (int i = xZone[0]; i<xZone[1]; i++){
      for (int j = yZone[0]; j<yZone[1]; j++){
        if(i >= 0 && i < mapWidth){
          if(j >= 0 && j < mapHeight){
            Mapcells[i][j].display();
          }
        }
      }
    }
    for(int i = 0; i < pauseScreen.healthBar.length-1; i++){
      //image(healthBar[i], 820 + i*healthBar[i].width,  510);
      copy(pauseScreen.healthBar[i], 820 + i*pauseScreen.healthBar[i].width, 30, pauseScreen.healthBar[i].width, pauseScreen.healthBar[i].height,  820 + i*pauseScreen.healthBar[i].width, 30, pauseScreen.healthBar[i].width, pauseScreen.healthBar[i].height);    
      
      copy(pauseScreen.lvlBar[i], 820 + i*pauseScreen.lvlBar[i].width, 80, pauseScreen.healthBar[i].width, pauseScreen.lvlBar[i].height,  820 + i*pauseScreen.lvlBar[i].width, 80, pauseScreen.lvlBar[i].width, pauseScreen.lvlBar[i].height);
    }
    if( time<timeNowR+500){
      println(int(time-timeNowR)/126);
      image(FartRight[int(time-timeNowR)/126],player.center_x+60 ,player.center_y - 20);
    }
    else if( time<timeNowL+500){
      println(int(time-timeNowL)/126);
      image(FartLeft[int(time-timeNowL)/126],player.center_x-60 ,player.center_y - 20);
    }
    
      
    thinkText(doll,Tutorial.get(textReader));
    player.display();
    player.update();
    collisions(player, Mapcells);
    portalsDisp();
    doll.display();
    farmer.update();
    farmer.display();
    for(int j = 0; j<20;j++){
    ball[j].update();
    ball[j].display();
    collisions(ball[j], Mapcells);
    MobAttack(j, false);
    }
    if(ballspawned != int((time/1000)%20) && farmer.life>0){
      ballspawned = int((time/1000)%20);
      BallSpawner();
    }
    for(int i = 0; i<3;i++){
      pig[i].display();
      pig[i].update();
      chick[i].display();
      chick[i].update();
      MobAttack(i, true);
    
    
    
    
    if(pig[i].life >0){
    collisions(pig[i], Mapcells);
    }
    if(chick[i].life >0){
    collisions(chick[i], Mapcells);
    }
    
    }
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
void thinkText(Sprite champ, String txt_msg){
  image(bubble, champ.center_x + 200, champ.center_y -150);
  textAlign(CENTER, TOP);
  textSize(128);
  fill(#296986); 
  textFont(f,20);               
  text(txt_msg, champ.center_x + 35, champ.center_y -240, 310,290);
}

void BallSpawner(){
      ball[ballspawned] = new HalmBall(false);
}
void portalsDisp(){
  if(textReader >7){
    image(PortalGreen[int((time/500)%2)],portal1_in[0],portal1_in[1]);
    image(PortalRed[int((time/500)%2)],portal1_out[0],portal1_out[1]); 
    image(PortalGreen[int((time/500)%2)],portal2_in[0],portal2_in[1]);
    image(PortalRed[int((time/500)%2)],portal2_out[0],portal2_out[1]); 
    image(PortalGreen[int((time/500)%2)],portal3_in[0],portal3_in[1]);
    image(PortalRed[int((time/500)%2)],portal3_out[0],portal3_out[1]); 
    image(button,4000,5470);
    if(player.center_x < portal1_in[0] + 20 && player.center_x > portal1_in[0]-20 && player.center_y > portal1_in[1]+20 && player.center_y < portal1_in[1]+80){
      portals_transfer(1);
    }
    if(player.center_x < portal2_in[0] + 20 && player.center_x > portal2_in[0]-20 && player.center_y > portal2_in[1]+20 && player.center_y < portal2_in[1]+80){
      portals_transfer(2);
    }
    if(player.center_x < portal3_in[0] + 20 && player.center_x > portal3_in[0]-20 && player.center_y > portal3_in[1]+20 && player.center_y < portal3_in[1]+80){
      portals_transfer(3);
    }
    if(player.center_x < 4050  && player.center_x > 3950 && player.center_y > 5450 && player.center_y < 5530){
      button = Button[1];
      farmer.life = -2;
      
    }
  }
}

void draw_background(){
  int x = z % bakgroundimg.width;
  for (int i = -x ; i < width ; i += bakgroundimg.width) {
      copy(bakgroundimg, 0, 0, bakgroundimg.width, height, i, 0, bakgroundimg.width, height);    
  }
}
void portals_transfer(int port_nmr){
  if (port_nmr == 1){
    player.center_x = portal1_out[0];
    player.center_y = portal1_out[1];
  }
  else if (port_nmr == 2){
    player.center_x = portal2_out[0];
    player.center_y = portal2_out[1];
  }
  else if (port_nmr == 3){
    player.center_x = portal3_out[0];
    player.center_y = portal3_out[1];
  }
  
}
void MobAttack(int i, boolean mob){
  if(mob){
    if(Math.pow(pig[i].center_x - player.center_x,2) + Math.pow(pig[i].center_y-player.center_y,2) <800 && !attacked){
      print("OUUF");
      hpCounter -= 4;
      println("hp is at ", hpCounter);
      attacked=true;
      if(hpCounter <= 0){
         player.change_x = 0;
         player.dead = true;
       }
       else if(hpCounter > 0 && abs(hpCounter - healthPoints) > 1){
           pauseScreen.healthBar[hpCounter] = pauseScreen.lvlMid;
           pauseScreen.healthBar[hpCounter+1] = pauseScreen.lvlMid;
           pauseScreen.healthBar[hpCounter+2] = pauseScreen.lvlMid;
           pauseScreen.healthBar[hpCounter+3] = pauseScreen.lvlMid;
           //healthBar[hpCounter-1] = lvlMid;
         }
    }
     else if(Math.pow(chick[i].center_x - player.center_x,2) + Math.pow(chick[i].center_y-player.center_y,2) <800 && !attacked){
      print("OUUF");
      hpCounter-=3;
      attacked=true;
       if(hpCounter <= 0){
         player.dead = true;
       }
       else if(hpCounter > 0 && abs(hpCounter - healthPoints) > 1){
           pauseScreen.healthBar[hpCounter] = pauseScreen.lvlMid;
           pauseScreen.healthBar[hpCounter+1] = pauseScreen.lvlMid;
           pauseScreen.healthBar[hpCounter+2] = pauseScreen.lvlMid;
         }
      
    }
    else if(Math.pow(pig[i].center_x - player.center_x,2) + Math.pow(pig[i].center_y-player.center_y,2) > 800 && Math.pow(chick[i].center_x - player.center_x,2) + Math.pow(chick[i].center_y-player.center_y,2) > 800){
      attacked = false;
    }
  }
  else{
    if(Math.pow(ball[i].center_x - player.center_x,2) + Math.pow(ball[i].center_y-player.center_y,2) <800 && !attacked){
      //hpCounter--;
      println("hp is at ", hpCounter);
      attacked=true;
      if(hpCounter <= 0){
         player.change_x = 0;
         player.dead = true;
       }
       else if(hpCounter > 0 && abs(hpCounter - healthPoints) > 1){
           pauseScreen.healthBar[hpCounter] = pauseScreen.lvlMid;
           //healthBar[hpCounter-1] = lvlMid;
         }
    }
    else if(Math.pow(ball[i].center_x - player.center_x,2) + Math.pow(ball[i].center_y-player.center_y,2) > 800){
      attacked = false;
    }
    
    
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
    
    if(player.center_y/Cell.BLOCK_SIZE < player.deadspot && player.dead){
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
        else if (  player.land_block == 4 && !updated && player.isPlayer && !player.dead){// Add damage
         collisionList.get(5).block.stone_update(updated);
         collisionList.get(5).counter++;
         
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

       if ( player.land_block == 4 && !updated && player.isPlayer && !player.dead){ //Add damage
         collisionList.get(5).block.stone_update(updated);
         collisionList.get(5).counter++;
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
      else if(collisionList.get(8).visable && player.getRight() > collisionList.get(8).block.getLeft() && player.getBottom() >= collisionList.get(8).block.getTop() && !player.dead){
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
      else if(collisionList.get(2).visable && player.getLeft() < collisionList.get(2).block.getRight() && player.getBottom() >= collisionList.get(2).block.getTop() && !player.dead){
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
      
      else if(!collisionList.get(5).visable /*&& !collisionList.get(8).visable && !collisionList.get(2).visable*/){
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
       if(collisionList.get(3).visable && player.getTop() <= collisionList.get(3).block.getBottom()&& !player.dead){
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
       else if(collisionList.get(3).ladder && player.getBottom() <= collisionList.get(3).block.getTop() || collisionList.get(4).ladder && player.getBottom() <= collisionList.get(4).block.getTop()&& !player.dead){
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
  float PunchRadie = player.center_x +140;
  for(int i = 0; i<3;i++){
    if(pig[i].center_x > player.center_x && pig[i].center_x < PunchRadie && (int(pig[i].center_y/100) == int(player.center_y/100))){
      timeNowR = millis(); 
      Pun.rewind();
      Pun.play();
      pig[i].life--;
      pig[i].change_x = pig[i].change_x*3.2;
      if(pig[i].life == 0){   
        giveExp(4);
      }
      }
      if(chick[i].center_x > player.center_x && chick[i].center_x < PunchRadie && (int(chick[i].center_y/100) == int(player.center_y/100))){
      timeNowR = millis(); 
      Pun.rewind();
      Pun.play();
      chick[i].life--;
      chick[i].change_x = chick[i].change_x*3.2;
      if(chick[i].life == 0){   
        giveExp(3);
      }
      
    }
    if(doll.center_x > player.center_x && doll.center_x < PunchRadie && (int(doll.center_y/100) == int(player.center_y/100))){
      timeNowR = millis(); 
      Pun.rewind();
      Pun.play();
      giveExp(1);
      }
    }
  }
  else{
  float PunchRadie = player.center_x -140;
  for(int i = 0; i<3;i++){
    if(pig[i].center_x < player.center_x && pig[i].center_x > PunchRadie && (int(pig[i].center_y/100) == int(player.center_y/100))){
      timeNowL = millis();
      Pun.rewind();
      Pun.play();
      pig[i].life--;
      pig[i].change_x = pig[i].change_x*3.2;
      if(pig[i].life == 0){   
        giveExp(4);
      }
      }
      if(chick[i].center_x < player.center_x && chick[i].center_x > PunchRadie && (int(chick[i].center_y/100) == int(player.center_y/100))){
      timeNowL = millis();
      Pun.rewind();
      Pun.play();
      chick[i].life--;
      chick[i].change_x = pig[i].change_x*3.2;
      if(chick[i].life == 0){   
        giveExp(3);
      
      }
      }
      if(doll.center_x < player.center_x && doll.center_x > PunchRadie && (int(doll.center_y/100) == int(player.center_y/100))){
      timeNowL = millis(); 
      Pun.rewind();
      Pun.play(); 
      giveExp(1);
      }
    }
  }
}

void giveExp(int expGain){
    if(expCounter >= 0 && expCounter <= healthPoints - 2){
      expCounter += expGain;
      if( expCounter >= healthPoints-1){
        expCounter = 0;
        WALK_SPEED += lvlCounter;
        JUMP_SPEED += lvlCounter;
        lvlCounter += 1;
        //lvlBar = createBar( lvlMid, healthPoints);
        print(" \n lvl: ", lvlCounter, " >>>");
      }
      else{
        for(int i = 0; i < expCounter;i++){
          pauseScreen.lvlBar[i] = pauseScreen.lvlPointMid;
      }
    }
  }
}

void keyPressed(){
  if(keyCode == RIGHT && !player.dead && textReader>0){
    player.change_x = WALK_SPEED;
  }
  else if(keyCode == 32 && !player.dead && textReader > 2){
    Punch();
  }
  else if(keyCode == LEFT&& !player.dead && textReader>0){
    player.change_x = -WALK_SPEED;
  }
  else if(keyCode == UP && (player.isOnBlock || player.isOnTop) && !player.dead && textReader>1){
    player.change_y = -JUMP_SPEED;
    player.isOnBlock = false;
    updated = false;
    player.isOnLadder = false;
    player.isOnTop = false;
  }
  else if(keyCode == ENTER ){
    if(textReader<8){
      textReader++;
    }
  }
  
  else if(keyCode == DOWN && (player.isOnTop || player.isOnLadder)){
    player.change_y = WALK_SPEED/2;
    player.isOnTop = false;
  }
  else if(key == 'a' && !pause){
      giveExp(1);
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
    //println("pause meassures center_x: ", pauseScreen.leftBoxDown.center_x);
    //println("mob meassures w: ", pig.w);
    //println("mob meassures h: ", pig.h);
    println("mob dist player: ", dist(player.center_x, player.center_y, pig[0].center_x, pig[0].center_y), " minDist: ", pig[0].fr_w/2 + player.fr_w/2);
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
  else if(pmouseX >= pauseScreen.soundButton.getLeft() && pmouseX <= pauseScreen.soundButton.getRight() && 
          pmouseY <= pauseScreen.soundButton.getBottom() && pmouseY >= pauseScreen.soundButton.getTop() && pause && mouseButton == LEFT){
       if(pauseScreen.soundButton.img == pauseScreen.soundOn){
         pauseScreen.soundButton.img = pauseScreen.soundOff;
       }
       else{
         pauseScreen.soundButton.img = pauseScreen.soundOn;
       }
  }
  else if(pmouseX >= pauseScreen.musicButton.getLeft() && pmouseX <= pauseScreen.musicButton.getRight() && 
          pmouseY <= pauseScreen.musicButton.getBottom() && pmouseY >= pauseScreen.musicButton.getTop() && pause && mouseButton == LEFT){
       if(pauseScreen.musicButton.img == pauseScreen.musicOn){
         pauseScreen.musicButton.img = pauseScreen.musicOff;
         Audioplayer.pause();
       }
       else{
         pauseScreen.musicButton.img = pauseScreen.musicOn;
         Audioplayer.play();
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
