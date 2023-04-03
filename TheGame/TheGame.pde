// Global variables
final static float SPEED = 5;
final static float SPRITE_SIZE = 50.0;
final static float SPRITE_SCALE = 50.0/128;

Sprite player;
PImage dirt, grass, sand, snow, stone, wood;
ArrayList<Sprite> blocks;

void setup(){
  size(1000, 800);
  player = new Sprite("data/player.png", 0.1, 100, 300, 1); //Sprite("path", scale, xPos, yPos, frames)
  player.change_x = 0;
  player.change_y = 0;
  
  blocks = new ArrayList<Sprite>();
  
  dirt = loadImage("data/blocks/tileDirt.png");
  grass = loadImage("data/blocks/tileGrass.png");
  sand = loadImage("data/blocks/tileSand.png");
  snow = loadImage("data/blocks/tileSnow.png");
  stone = loadImage("data/blocks/tileStone.png");
  wood = loadImage("data/blocks/tileWood.png");
  
  createBlocks("data/blocks/blockMap.csv");
  //player = new Sprite("data/player.png", 0.1, 100, 300, 1);
  //player = new Sprite("data/orcspritesheet.png", 1.0, 100, 300, 10);
  //player = new Sprite("data/anima.jpg", 1.0, 100, 300, 7);
  frameRate(30);
  
}

void draw(){
  background(255);
  
  player.display();
  player.update();
  
  for(Sprite block: blocks){
    block.display(); 
  }
}

void keyPressed(){
  if(keyCode == RIGHT){
    player.change_x = SPEED;
  }
  else if(keyCode == LEFT){
    player.change_x = -SPEED;
  }
  else if(keyCode == UP){
    player.change_y = -SPEED;
  }
  else if(keyCode == DOWN){
    player.change_y = SPEED;
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
//dirt, grass, sand, snow, stone, wood
void createBlocks(String filename){
  String[] rows = loadStrings(filename);
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
    if(columns[col].equals("1")){
     Sprite block = new Sprite(dirt, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("2")){
     Sprite block = new Sprite(grass, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("3")){
     Sprite block = new Sprite(sand, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("4")){
     Sprite block = new Sprite(snow, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("5")){
     Sprite block = new Sprite(stone, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("6")){
     Sprite block = new Sprite(wood, SPRITE_SCALE, 1);
     block.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
     block.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
     blocks.add(block);
    }
   }
  }
}
