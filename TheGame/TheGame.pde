// Global variables
final static float SPEED = 5;
Sprite player;

void setup(){
  size(1000, 800);
  player = new Sprite("data/player.png", 0.1, 100, 300);
  player.change_x = 0;
  player.change_y = 0;
}

void draw(){
  background(255);
  
  player.display();
  player.update();
}

void keyPressed(){
  if(keyCode == RIGHT){
    player.change_x = SPEED;
  }
  else if(keyCode == LEFT){
    player.change_x = -SPEED;
  }
  else if(keyCode == UP){
    player.change_y = -SPEED;
  }
  else if(keyCode == DOWN){
    player.change_y = SPEED;
  }
}

void keyReleased(){
  if(keyCode == RIGHT){
    player.change_x = 0;
  }
  else if(keyCode == LEFT){
    player.change_x = 0;
  }
  else if(keyCode == UP){
    player.change_y = 0;
  }
  else if(keyCode == DOWN){
    player.change_y = 0;
  }
}
