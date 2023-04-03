// Global variables
Sprite player;

void setup(){
  size(1000, 800);
  frameRate(30);
  player = new Sprite("data/orcspritesheet.png", 1.0, 100, 300,10);
  //player = new Sprite("data/anima.jpg", 1.0, 100, 300,7);
}

void draw(){
  background(255);
  
  player.display();
  player.update();
}
