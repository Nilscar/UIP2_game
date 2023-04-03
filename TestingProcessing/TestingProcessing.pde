/*int numFrames = 7;  // The number of frames in the animation
int currentFrame = 0;
PImage images;
PImage[] img = new PImage[numFrames];

    
void setup() {
  size(640, 360);
  frameRate(30);
  
  images  = loadImage("data/anima.jpg");
  for (int i = 0; i < numFrames; i++) {
    img[i] = images.get(86*i, 0, 86, 150);
  }

} 
 
void draw() { 
  background(0);
  currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
    image(img[(currentFrame)% numFrames], 100, 100);
      
  
}*/
