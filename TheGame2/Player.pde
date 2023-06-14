public class Player extends Sprite{
  //initiate the variables and load the animation sequences
  final static int stand_frames = 5;
  final static int walk_frames = 2;
  PImage player_stand = loadImage("data/zombie_seq.png");
  PImage[] pl_stand = new PImage[stand_frames];
  PImage player_walk = loadImage("data/zombie_walk.png");
  PImage player_walk_left = loadImage("data/zombie_walk_left.png");
  PImage[] pl_walk_right = new PImage[walk_frames];
  PImage[] pl_walk_left = new PImage[walk_frames];
  PImage player_drown = loadImage("data/zombie_drown.png");
  PImage[] pl_drown = new PImage[7];
  boolean onlydieonce = false;
  final  float PLAYER_SCALE = 0.8 * SizeScale;
  
  public Player(float x_pos, float y_pos ){
    //construct the player and set up the animations by cutting the sequence img
    super("data/zombie_seq.png",  0.8 * SizeScale, x_pos, y_pos, stand_frames, true); //Calls the sprite class when creating the player
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
      i_w = player_drown.width / 7;
      for (int i = 0; i < 7; i++) {
        pl_drown[i] = player_drown.get(int(i_w*(i%7)), 0, int(i_w), int(player_drown.height));
        pl_drown[i].resize(int(i_w*PLAYER_SCALE),int(player_drown.height*PLAYER_SCALE));
       
      }
  }
   @Override
   //update the animations
   public void update(){
     if( !dead){
    currentFrame = (currentFrame+(n_frames/90.0));
     }
     else{
       if (currentFrame < 6){
         currentFrame = (currentFrame+(n_frames/120.0));}
     }
     
  }
  @Override
  public void display(){
    //Display the farmer with a animation that depends on players status
    if(dead){
      if(!onlydieonce){ currentFrame = 0;
          deadspot = (center_y + 2*BLOCK_SIZE)/BLOCK_SIZE;
          onlydieonce = true;}
      image(pl_drown[(int(currentFrame))%7], center_x, center_y, fr_w, h);
    }
    
    else if(change_x==0){
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
