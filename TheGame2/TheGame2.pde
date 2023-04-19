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

public PGraphics blockGraphics;
PImage mapimg;

Sprite player;
Sprite reward;
PImage[] blocks = new PImage[7];
ArrayList<Cell> cells;
boolean treasure = false;


void setup(){
  fullScreen();
  imageMode(CENTER);
  String[] CSVrows = loadStrings("data/blocks/blockMap.csv");
  cells = new ArrayList<Cell>();
  createMap(CSVrows);
  blocks[0] = loadImage("data/blocks/tileDirt.png");
  blocks[1]= loadImage("data/blocks/tileGrass.png");
  blocks[2] = loadImage("data/blocks/tileSand.png");
  blocks[3] = loadImage("data/blocks/tileSnow.png");
  blocks[4] = loadImage("data/blocks/tileStone.png");
  blocks[5] = loadImage("data/blocks/tileWood.png");
  blocks[6] = loadImage("data/blocks/box_treasure.png");
  player = new Player( 150, 500);
}
 
void draw(){
  for (int i = 0; i<11; i++){
    if (cells.get(i).visable){
      cells.get(i).display();
    }
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

//Creating the game map from csv file
void createMap(String[] blockrows){
  print("blockrows");
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
     Cell cell = new Cell(int(columns[col]), col, row, blocks[int(columns[col])]);
     cells.add(cell);
    
    } 
  }
}//End of createMapFrame()
