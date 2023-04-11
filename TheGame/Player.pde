public class Player extends Sprite{
  final static int stand_frames = 5;
  final static int walk_frames = 2;
  PImage player_stand = loadImage("data/zombie_seq.png");
  PImage[] pl_stand = new PImage[stand_frames];
  PImage player_walk = loadImage("data/zombie_walk.png");
  PImage player_walk_left = loadImage("data/zombie_walk_left.png");
  PImage[] pl_walk_right = new PImage[walk_frames];
  PImage[] pl_walk_left = new PImage[walk_frames];

  final static float PLAYER_SCALE = 0.8;
  
  public Player(float x_pos, float y_pos ){
    super("data/zombie_seq.png", PLAYER_SCALE, x_pos, y_pos, stand_frames);
    i_w = player_stand.width / stand_frames;
      for (int i = 0; i < stand_frames; i++) {
        pl_stand[i] = player_stand.get(int(i_w*(i%stand_frames)), 0, int(i_w), int(player_stand.height));
        pl_stand[i].resize(int(i_w*PLAYER_SCALE),int(player_stand.height*PLAYER_SCALE));
      }
      i_w = player_walk.width / walk_frames;
      for (int i = 0; i < walk_frames; i++) {
        pl_walk_right[i] = player_walk.get(int(i_w*(i%walk_frames)), 0, int(i_w), int(player_walk.height));
        pl_walk_right[i].resize(int(i_w*PLAYER_SCALE),int(player_walk.height*PLAYER_SCALE));
        pl_walk_left[i] = player_walk_left.get(int(i_w*(i%walk_frames)), 0, int(i_w), int(player_walk.height));
        pl_walk_left[i].resize(int(i_w*PLAYER_SCALE),int(player_walk.height*PLAYER_SCALE));
      }
  }
  @Override
  public void display(){
    //image(pl_stand[0], center_x, center_y, fr_w, h);
    
    if(change_x==0){
      image(pl_stand[(int(currentFrame))% stand_frames], center_x, center_y, fr_w, h);
    }
    else if (change_x<0){
      image(pl_walk_left[(int(currentFrame))% walk_frames], center_x, center_y, fr_w, h);
    }
    else{
      image(pl_walk_right[(int(currentFrame))% walk_frames], center_x, center_y, fr_w, h);
    }
  }
}
