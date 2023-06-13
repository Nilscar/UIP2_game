public class Sprite{
  PImage img;
  float center_x, center_y;
  float change_x, change_y;
  float currentFrame = 0;
  float w, h;
  float fr_w;
  float i_w;
  int n_frames;
  float Scale;
  PImage[] imgs;
  boolean isOnBlock;
  boolean isOnLadder;
  boolean isOnTop = false;
  boolean treasure;
  boolean dead = false;
  boolean button;
  float deadspot;
  int land_block; 
  int head_block;
  int side_block;
  boolean isPlayer; 
  
  //Constructor for sprite /or player
  public Sprite(String filename, float scale, float xPos, float yPos, int num_of_frames, boolean is_player){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    center_x = xPos;
    center_y = yPos;
    change_x = 0;
    change_y = 0;
    n_frames = num_of_frames;
    isOnBlock = false;
    isOnLadder = false;
    treasure = false;
    Scale = scale;
    isPlayer=is_player;
    imgs = new PImage[n_frames];
    if (n_frames < 2){
      fr_w = w;
      imgs[0] = img;
    }
    else{
      i_w = img.width / n_frames;
      for (int i = 0; i < n_frames; i++) {
        imgs[i] = img.get(int(i_w*(i%n_frames)), 0, int(i_w), int(img.height));
         imgs[i].resize(int(i_w*scale),int(h));
      }
      fr_w=w/n_frames;
    }
  }
  //Constructor for sprite
  public Sprite(String filename, float scale, int n_frames){
    this(filename, scale, 0, 0, n_frames, false );
  }
  //Constructor for map blocks
  public Sprite(PImage image, float scaleW, float scaleH, int num_of_frames, boolean chest){
   img = image;
   
   w = img.width * scaleW;
   h = img.height * scaleH;
   center_x = 0;
   center_y = 0;
   change_x = 0;
   change_y = 0;
   n_frames = num_of_frames;
   treasure = chest;
   imgs = new PImage[n_frames];
    if (n_frames < 2){
      fr_w = w;
      imgs[0] = img;
      //print("one got through");
    }
    else{
      fr_w = img.width * (BLOCK_SIZE/img.width);
      img.resize(int(BLOCK_SIZE*n_frames),img.height);
      for (int i = 0; i < n_frames; i++) {
        imgs[i] = img.get(int(fr_w*(i%n_frames)), 0, int(fr_w), int(h));
        //imgs[i].resize(int(100),int(100));
      }
    }
  }
  
  //Constructor for menu blocks
  public Sprite(PImage image, float xPos, float yPos, float scaleW, float scaleH, boolean button){
   img = image;
   n_frames = 0;
   
   w = scaleW;
   h = scaleH;
   fr_w = w;
   
   center_x = xPos;
   center_y = yPos;
   change_x = 0;
   change_y = 0;
   
   this.button = button;
  }
  
  public void display(){ //sets the sprite/image to be shown on screen
    if(n_frames == 0){
      image(img, center_x, center_y, w, h);
    }
    else if (n_frames == 1){
    image(imgs[0], center_x, center_y, fr_w, h);
    }
    else if(n_frames > 1){
    image(imgs[(int(currentFrame%n_frames))], center_x, center_y, fr_w, h);
    }
  }
  
  public void update(){
    currentFrame = (currentFrame+(n_frames/90.0));
  
   
  }
  public void stone_update(boolean updated){
    
    if (!updated && currentFrame < n_frames-1){currentFrame++;}
  
   
  }
  void setLeft(float left){
    center_x = left + fr_w/2;
  }
  float getLeft(){
    return center_x - fr_w/2;
  }
  void setRight(float right){
    center_x = right - fr_w/2;
  }
  float getRight(){
    return center_x + fr_w/2;
  }
  void setTop(float top){
    center_y = top + h/2;
  }
  float getTop(){
    return center_y - h/2;
  }
  void setBottom(float bottom){
    center_y = bottom - h/2;
  }
  float getBottom(){
    return center_y + h/2;
  }
}
