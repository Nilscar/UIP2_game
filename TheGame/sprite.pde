public class Sprite{
  PImage img;
  float center_x, center_y;
  float change_x, change_y;
  float w, h;
  int n_frames;
  
  public Sprite(String filename, float scale, float xPos, float yPos, int num_of_frames){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    center_x = xPos;
    center_y = yPos;
    change_x = 0;
    change_y = 0;
    n_frames = num_of_frames;
  }
  public Sprite(String filename, float scale, int num_of_frames){
    this(filename, scale, 0, 0, num_of_frames);
  }
  public Sprite(PImage image, float scale, int num_of_frames){
   img = image;
   w = img.width * scale;
   h = img.height * scale;
   center_x = 0;
   center_y = 0;
   change_x = 0;
   change_y = 0;
   n_frames = num_of_frames;
  }
  
  public void display(){
    image(img, center_x, center_y, w, h);
  }
  
  public void update(){
    center_x += change_x;
    center_y += change_y;
  }
}
