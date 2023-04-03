int numFrames = 7;  // The number of frames in the animation
int currentFrame = 0;
PImage images;
PImage[] img = new PImage[numFrames];

    
void setup() {
  size(640, 360);
  frameRate(8);
  
  images  = loadImage("anima.jpg");
  img[0] = images.get(0, 0, 86, 150);
  img[1] = images.get(86, 0, 86, 150); 
  img[2] = images.get(172, 0, 86, 150); 
  img[3] = images.get(258, 0, 86, 150); 
  img[4] = images.get(344, 0, 86, 150); 
  img[5] = images.get(430, 0, 86, 150); 
  img[6] = images.get(516, 0, 86, 150); 

  // If you don't want to load each image separately
  // and you know how many frames you have, you
  // can create the filenames as the program runs.
  // The nf() command does number formatting, which will
  // ensure that the number is (in this case) 4 digits.
  //for (int i = 0; i < numFrames; i++) {
  //  String imageName = "PT_anim" + nf(i, 4) + ".gif";
  //  images[i] = loadImage(imageName);
  //}
} 
 
void draw() { 
  background(0);
  currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames

    image(img[(currentFrame)], 100, 100);
      
  
}
