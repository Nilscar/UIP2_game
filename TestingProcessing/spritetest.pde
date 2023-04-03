// Global variables
int numFrames = 50;  // The number of frames in the animation
int currentFrame = 0;
int center_x;
int center_y;
int change_x;
int change_y;
int size_img;
PImage images;
PImage[] img = new PImage[numFrames];

void setup(){
  size(800, 600);
  size_img = 32;
  frameRate(30);
  images = loadImage("data/orcspritesheet.png");
  for (int i = 0; i < numFrames; i++) {
    img[i] = images.get(size_img*(i%10), size_img*int(i/10), 32, 32);
  }
  center_x = 100;
  center_y = 300;
  change_x = 0;
  change_y = 0;
}

void draw(){
  background(255);
  currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
  img[(currentFrame)% numFrames].resize(128,128);
    image(img[(currentFrame)% numFrames], 100, 100);
  center_x += change_x;
  center_y += change_y;
}
