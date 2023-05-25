public class Mob extends Sprite{
  final static float MOB_SCALE = 0.8;
  PImage pig_left = loadImage("data/pigLeft.png");
  PImage pig_right = loadImage("data/pigRight.png");
  int life = 2; 
  
  
  
  public Mob(float x_pos, float y_pos ){
    super("data/pigRight.png", MOB_SCALE, x_pos, y_pos, 1, false);
       change_x = 1.2;
      }
  @Override
  public void display(){
    if(life>0){
      if (change_x<=0){
        image(pig_left, center_x, center_y, fr_w, h);
      }
      else{
        image(pig_right, center_x, center_y, fr_w, h);
      }
    }
}
  @Override
   public void update(){
     }
  }
