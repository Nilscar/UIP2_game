public class Map extends Sprite{
  final static float BLOCK_SIZE = 50;
  final static float BLOCK_SCALEW = BLOCK_SIZE/128;
  final static float BLOCK_SCALEH = BLOCK_SIZE/146;
  final static float CHEST_SIZE = BLOCK_SIZE/3;
  final static float CHEST_SCALEW = CHEST_SIZE/62;
  final static float CHEST_SCALEH = CHEST_SIZE/55;
  final static int BLOCK_AMOUNT = 8;
  
  float mapHeight;
  float mapWidth;
  
  /*final static PImage dirt = loadImage("data/blocks/tileDirt.png");
  final static PImage grass = loadImage("data/blocks/tileGrass.png");
  final static PImage sand = loadImage("data/blocks/tileSand.png");
  final static PImage snow = loadImage("data/blocks/tileSnow.png");
  final static PImage stone = loadImage("data/blocks/tileStone.png");
  final static PImage wood = loadImage("data/blocks/tileWood.png");
  final static PImage chest = loadImage("data/blocks/box_treasure.png");
  final static PImage treasure1 = loadImage("data/treasures/runeBlack_slab_002.png");
  */
  //PImage dirt, grass, sand, snow, stone, wood, chest, treasure1;
  PImage[] mapBlocks = new PImage[BLOCK_AMOUNT];
  PImage img, mapImg;
  ArrayList<Sprite> blocks;
  ArrayList<Sprite> frameBlocks;
  
  Sprite reward;
  boolean treasure = false;
  boolean tChest;
  
  public Map(){
    super(filename, BLOCK_SCALEW, BLOCK_SCALEH, 1, tChest);
    blocks = new ArrayList<Sprite>();
    frameBlocks = new ArrayList<Sprite>();
    
    mapBlocks[0] = loadImage("data/blocks/tileDirt.png");
    mapBlocks[1] = loadImage("data/blocks/tileGrass.png");
    mapBlocks[2] = loadImage("data/blocks/tileSand.png");
    mapBlocks[3] = loadImage("data/blocks/tileSnow.png");
    mapBlocks[4] = loadImage("data/blocks/tileStone.png");
    mapBlocks[5] = loadImage("data/blocks/tileWood.png");
    mapBlocks[6] = loadImage("data/blocks/box_treasure.png");
    mapBlocks[7] = loadImage("data/treasures/runeBlack_slab_002.png");
    String[] CSVrows = loadStrings("data/blocks/blockMap.csv");
    String[] mapFrame = loadStrings("data/blocks/mapFrame.csv");
    
    mapHeight = mapFrame.length;
    mapWidth = split(mapFrame[0], ",").length - 1;
    
    createMapFrame(mapFrame);
    createBlocks(CSVrows);
    mapImg = createMapImg();
  }
  
  @Override
  public void display(){
    //image(mapImg);
  }
  
  PImage createMapImg(){
    for(Sprite block: blocks){
      // create PImage or image with the blocks and frameBlocks
      img = image(block.img, block.center_x, block.center_y, block.fr_w, block.h);
      return img;
    }
  }
  
  float getMapHeight(){
     return mapHeight;
  }
  
  float getMapWidth(){
     return mapWidth;
  }
  
  ArrayList<Sprite> getBlocks(){
    return ArrayList<Sprite> blocks;
  }
  
  ArrayList<Sprite> getFrameBlocks(){
    return ArrayList<Sprite> frameBlocks;
  }
  
  void createTreasure(){
  Sprite t = new Sprite(treasure1, CHEST_SCALEW, CHEST_SCALEH, 1, false);
  t.center_x = player.center_x - 2*CHEST_SCALEW;
  t.center_y = player.center_y;
  reward = t;
}
  
  //Creating the game map from csv file
void createBlocks(String[] blockrows){
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
    if(columns[col].equals("1")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("2")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("3")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("4")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("5")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("6")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     blocks.add(block);
    }
    else if(columns[col].equals("7")){
     Sprite block = new Sprite(mapBlocks[col], CHEST_SCALEW, CHEST_SCALEH, 1, true);
     block.center_x = CHEST_SIZE + col * BLOCK_SIZE;
     block.center_y = CHEST_SIZE/2 + row * BLOCK_SIZE + BLOCK_SIZE - CHEST_SIZE;
     blocks.add(block);
     //print(block);
    }
   }
  } 
}//End of createBlocks()

//Creating the game map from csv file
void createMapFrame(String[] blockrows){
  String[] rows = blockrows;
  for(int row = 0; row < rows.length; row++){
   String[] columns = split(rows[row], ",");
   for(int col = 0; col < columns.length; col++){
    if(columns[col].equals("1")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("2")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("3")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("4")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("5")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("6")){
     Sprite block = new Sprite(mapBlocks[col], BLOCK_SCALEW, BLOCK_SCALEH, 1, false);
     block.center_x = BLOCK_SIZE/2 + col * BLOCK_SIZE;
     block.center_y = BLOCK_SIZE/2 + row * BLOCK_SIZE;
     frameBlocks.add(block);
    }
    else if(columns[col].equals("7")){
     Sprite block = new Sprite(mapBlocks[col], CHEST_SCALEW, CHEST_SCALEH, 1, true);
     block.center_x = CHEST_SIZE + col * BLOCK_SIZE;
     block.center_y = CHEST_SIZE/2 + row * BLOCK_SIZE + BLOCK_SIZE - CHEST_SIZE;
     frameBlocks.add(block);
     //print(block);
    }
   }
  }
}//End of createMapFrame()
}
