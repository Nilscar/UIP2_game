// Global variables
PImage img;
float center_x, center_y;
float change_x, change_y;

void setup(){
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
}
