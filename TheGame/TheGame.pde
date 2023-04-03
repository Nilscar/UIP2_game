// Global variables
Sprite player;

void setup(){
  size(1000, 800);
  player = new Sprite("data/orcspritesheet.png", 1.0, 100, 300,1);
  
}

void draw(){
  background(255);
  
  player.display();
  player.update();
}
