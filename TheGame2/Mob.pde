public class Mob extends Sprite{
  final static float MOB_SCALE = 0.8;
  PImage pig_left = loadImage("data/pigLeft.png");
  PImage pig_right = loadImage("data/pigRight.png");
  PImage chicken_left = loadImage("data/chickenwalkLeft.png");
  PImage chicken_right = loadImage("data/chickenwalkRight.png");
  PImage doll = loadImage("data/TrainingDoll.png");
  PImage[] Chicken_right = new PImage[2];
  PImage[] Chicken_left = new PImage[2];
  int life = 2; 
  int anim;
  
  
  
  public Mob(float x_pos, float y_pos, int animal ){
    super("data/pigRight.png", MOB_SCALE, x_pos, y_pos, 1, false);
    anim = animal;
    
       change_x = 1.2;
       Chicken_right[0] = chicken_right.get(0, 0, 80, 100);
       Chicken_right[1] = chicken_right.get(80, 0, 80, 100);
       
       Chicken_left[0] = chicken_left.get(0, 0, 80, 100);
       Chicken_left[1] = chicken_left.get(80, 0, 80, 100);
  }
  @Override
  public void display(){
    if(life>0 && anim == 1){
      if (change_x<=0){
        image(pig_left, center_x, center_y, fr_w, h);
      }
      else {
        image(pig_right, center_x, center_y, fr_w, h);
      }
    }
    else if(life>0 && anim == 2){
      if (change_x<=0){
        image(Chicken_left[(int(currentFrame))%2], center_x, center_y, fr_w, h);
      }
      else{
        image(Chicken_right[(int(currentFrame))%2], center_x, center_y, fr_w, h);
      }
    }
    else if( anim == 3){
      image(doll, center_x, center_y, 90, 120);
      change_x = 0;
      change_y = 0; 
    }
    else{
      center_x = 2000;
      center_y=2000;
      change_x = 0;
      change_y = 0; 
    }
}
  @Override
   public void update(){
      currentFrame = (currentFrame+(n_frames/45.0));
     }
  }
