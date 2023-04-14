// Global variables
final static float WALK_SPEED = 6;
final static float JUMP_SPEED = 14.4;
final static float BLOCK_SIZE = 50;
final static float BLOCK_SCALEW = BLOCK_SIZE/128;
final static float BLOCK_SCALEH = BLOCK_SIZE/146;
final static float CHEST_SIZE = BLOCK_SIZE/3;
final static float CHEST_SCALEW = CHEST_SIZE/62;
final static float CHEST_SCALEH = CHEST_SIZE/55;
final static float GRAVITY = 0.5;
PImage menu;
String state ="menu";


final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 50;

float viewX = 0;
float viewY = 0;
float mapHeight;
float mapWidth;


Sprite player;
Sprite reward;
PImage dirt, grass, sand, snow, stone, wood, chest, treasure1;
PImage theMapImg;
ArrayList<Sprite> blocks;
ArrayList<Sprite> frameBlocks;
boolean treasure = false;


void setup(){
  fullScreen();
  imageMode(CENTER);
  print(viewY,"\n", viewX, "\n");
  player = new Player( 1.5 * BLOCK_SIZE, 500);
  player.change_x = 0;
  player.change_y = 0;
  menu = loadImage("data/menutest.png");
  menu.resize(displayWidth, displayHeight);
  
  blocks = new ArrayList<Sprite>();
  frameBlocks = new ArrayList<Sprite>();
  
  dirt = loadImage("data/blocks/tileDirt.png");
  grass = loadImage("data/blocks/tileGrass.png");
  sand = loadImage("data/blocks/tileSand.png");
  snow = loadImage("data/blocks/tileSnow.png");
  stone = loadImage("data/blocks/tileStone.png");
  wood = loadImage("data/blocks/tileWood.png");
  chest = loadImage("data/blocks/box_treasure.png");
  treasure1 = loadImage("data/treasures/runeBlack_slab_002.png");
  String[] CSVrows = loadStrings("data/blocks/blockMap.csv");
  String[] mapFrame = loadStrings("data/blocks/mapFrame.csv");
  mapHeight = mapFrame.length;
  mapWidth = split(mapFrame[0], ",").length - 1;
  //print(mapWidth);
  createMapFrame(mapFrame);
  createBlocks(CSVrows);
  createTreasure();
  theMapImg = createMap(blocks);
  
  frameRate(60);
  
}

void draw(){
  
  if( state !="game"){
    background(menu);
    }
   
  else if( state == "game"){
    background(255);
    //image(theMapImg, 0, 0);
    scroll();
    player.display();
    blockCollisions(player, blocks);
    player.update();
    for(Sprite frameBlock: frameBlocks){
      frameBlock.display();
    }
    /*for(Sprite block: blocks){
      block.display(); 
    }*/
    if(treasure){
      reward.display();
    }
    image(theMapImg, theMapImg.width/2 - BLOCK_SIZE/2, theMapImg.height/2 - BLOCK_SIZE/2);
  }
  
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
public void blockCollisions(Sprite player, ArrayList<Sprite> blocks){
   player.change_y += GRAVITY;
   player.center_y += player.change_y;
   ArrayList<Sprite> collisionList = checkCollisions(player, blocks);
   if(player.getBottom() >= ((mapHeight - 1) * BLOCK_SIZE) && player.change_y > 0){
      player.setBottom((mapHeight - 1) * BLOCK_SIZE);
      player.isOnBlock = true;
      player.change_y = 0;
   }
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
   }
 
  player.center_x += player.change_x;
  collisionList = checkCollisions(player, blocks);
  if(player.getLeft() <= BLOCK_SIZE && player.change_x < 0){
    player.setLeft(BLOCK_SIZE);
  }
  else if(player.getRight() >= mapWidth * BLOCK_SIZE && player.change_x > 0){
    player.setRight(mapWidth*BLOCK_SIZE);
  }
 if(collisionList.size() > 0){
  Sprite collision = collisionList.get(0);
  if(collision.treasure && player.change_x > 0){
    player.setRight(collision.getLeft());
    reward.center_x = player.center_x + CHEST_SIZE;
    reward.center_y = player.center_y;
    player.treasure = true; //Solve with while-loop?
  }
  else if(collision.treasure && player.change_x < 0){
    player.setLeft(collision.getRight());
    reward.center_x = player.center_x + CHEST_SIZE;
    reward.center_y = player.center_y;
    player.treasure = true;
  }
  else if(player.change_x < 0){
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

void createTreasure(){
  Sprite t = new Sprite(treasure1, CHEST_SCALEW, CHEST_SCALEH, 1, false);
  t.center_x = player.center_x - 2*CHEST_SCALEW;
  t.center_y = player.center_y;
  reward = t;
}

//Creating the game map blocks from a csv file
void createBlocks(String[] blockrows){
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
    if(columns[col].equals("1")){
     Sprite block = new Sprite(dirt, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
     block.display();
    }
    else if(columns[col].equals("2")){
     Sprite block = new Sprite(grass, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("3")){
     Sprite block = new Sprite(sand, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("4")){
     Sprite block = new Sprite(snow, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("5")){
     Sprite block = new Sprite(stone, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("6")){
     Sprite block = new Sprite(wood, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("7")){
     Sprite block = new Sprite(chest, CHEST_SCALEW, CHEST_SCALEH, 1, true);
     block.center_x = BLOCK_SIZE/2 + CHEST_SIZE + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 - CHEST_SIZE + row * BLOCK_SIZE + BLOCK_SIZE;
     blocks.add(block);
     //print(block);
    }
   }
  } 
}//End of createBlocks()

//Creating the frame blocks from a csv file
void createMapFrame(String[] blockrows){
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
    if(columns[col].equals("1")){
     Sprite block = new Sprite(dirt, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("2")){
     Sprite block = new Sprite(grass, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("3")){
     Sprite block = new Sprite(sand, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("4")){
     Sprite block = new Sprite(snow, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("5")){
     Sprite block = new Sprite(stone, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("6")){
     Sprite block = new Sprite(wood, BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("7")){
     Sprite block = new Sprite(chest, CHEST_SCALEW, CHEST_SCALEH, 1, true);
     block.center_x = CHEST_SIZE + col * BLOCK_SIZE;
     block.center_y = CHEST_SIZE/2 + row * BLOCK_SIZE + BLOCK_SIZE - CHEST_SIZE;
     frameBlocks.add(block);
     //print(block);
    }
   }
  } 
}//End of createMapFrame()

PImage createMap(ArrayList<Sprite> blocks){
  PImage mapImage = createImage(int(mapWidth * BLOCK_SIZE + BLOCK_SIZE/2), int(mapHeight * BLOCK_SIZE), 255);
  print("In createMap: ");
  print(mapImage.width, "+", mapImage.height);
  for(Sprite block: blocks){
    block.img.resize(int(block.w), int(block.w));
    mapImage.set(int(block.center_x), int(block.center_y), block.img);
  }
  return mapImage;
}//End of createMap()
