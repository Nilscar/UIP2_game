public class Sprite{
  PImage img;
  float center_x, center_y;
  float change_x, change_y;
  float w, h;
  
  public Sprite(String filename, float scale, float xPos, float yPos){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    center_x = xPos;
    center_y = yPos;
    change_x = 0;
    change_y = 0;
  }
}

/*void setup(){
  size(800, 600);
  img = loadImage("data/orcspritesheet.png");
  center_x = 100;
  center_y = 300;
  change_x = 5;
  change_y = 2;
}

void draw(){
  background(255);
  
  image(img, center_x, center_y);
  center_x += change_x;
  center_y += change_y;
}*/
