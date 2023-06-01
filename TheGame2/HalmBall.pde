public class HalmBall extends Sprite{
  final static float MOB_SCALE = 0.8;
  PImage halm = loadImage("data/Halm.png");
  PImage[] Halm = new PImage[4];
  public HalmBall(boolean first){
    super("data/pigRight.png", MOB_SCALE, 3720, 5320, 1, false);
    Halm[0] = halm.get(0, 0, 128, 128);
    Halm[1] = halm.get(128, 0, 128, 128);
    Halm[2] = halm.get(256, 0, 128, 128);
    Halm[3] = halm.get(394, 0, 128, 128);
    if(first){
      center_x = 4300;
      center_y = 7100;
      change_x = 0;
    }
    else{
      change_x = random(-3.5,-1.2);
    }
  }
  @Override
  public void display(){
    center_x += change_x;
    image(Halm[(int(currentFrame))%4], center_x, center_y, fr_w, h);
  }
  @Override
   public void update(){
      currentFrame = (currentFrame+(4/45.0));
     }
}
