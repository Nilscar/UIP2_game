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
  boolean treasure;
  
  //Constructor for sprite
  public Sprite(String filename, float scale, float xPos, float yPos, int num_of_frames){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    center_x = xPos;
    center_y = yPos;
    change_x = 0;
    change_y = 0;
    n_frames = num_of_frames;
    isOnBlock = false;
    treasure = false;
    Scale = scale;
    
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
  //Constructor for stuff in upper left corner?? idk
  public Sprite(String filename, float scale, int n_frames){
    this(filename, scale, 0, 0, n_frames );
  }
  //Constructor for blocks
  public Sprite(String filename, float scaleW, float scaleH, int num_of_frames, boolean chest){
   img = loadImage(filename);
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
    }
    else{
      fr_w = w / n_frames;
      for (int i = 0; i < n_frames; i++) {
        imgs[i] = img.get(int(fr_w*(i%n_frames)), 0, int(fr_w), int(h));
      }
    }
  }
  
  public void display(){
   // image(img,center_x, center_y, w, h);
    //image(imgs[0],center_x, center_y, w, h);
    if (n_frames < 2){
    image(imgs[0], center_x, center_y, fr_w, h);
    }
    else{
    image(imgs[(int(currentFrame))% n_frames], center_x, center_y, fr_w, h);
    }
  }
  
  public void update(){
    currentFrame = (currentFrame+(n_frames/90.0));
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
