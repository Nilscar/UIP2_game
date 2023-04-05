public class Player extends Sprite{
  final static float PLAYER_SCALE = 0.4;
  
  public Player(float x_pos, float y_pos ){
    super("data/zombie_walk.png", PLAYER_SCALE, x_pos, y_pos, 2);
  }
}
