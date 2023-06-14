public class Mob extends Sprite{
  final static float MOB_SCALE = 0.8;
  PImage pig_left = loadImage("data/pigLeft.png");
  PImage pig_right = loadImage("data/pigRight.png");
  PImage chicken_left = loadImage("data/chickenwalkLeft.png");
  PImage chicken_right = loadImage("data/chickenwalkRight.png");
  PImage doll = loadImage("data/TrainingDoll.png");
  PImage[] Chicken_right = new PImage[2];
  PImage[] Chicken_left = new PImage[2];
  PImage farmer = loadImage("data/Farmer.png");
  PImage[] Farmer = new PImage[5];
  PImage deadfarmer = loadImage("data/FarmerDead.png");
  PImage[] deadFarmer = new PImage[5];
  int life = 2; 
  int anim;
  boolean farmeronlydieonce = false;
  float deadFrame = 0;
  
  
  //Construct the mobs
  public Mob(float x_pos, float y_pos, int animal ){
    super("data/pigRight.png", MOB_SCALE* SizeScale, x_pos, y_pos, 1, false);
    anim = animal;
       change_x = 1.2;
       Chicken_right[0] = chicken_right.get(0, 0, 80, 100);
       Chicken_right[1] = chicken_right.get(80, 0, 80, 100);
       
       Chicken_left[0] = chicken_left.get(0, 0, 80, 100);
       Chicken_left[1] = chicken_left.get(80, 0, 80, 100);
       
       for(int fi = 0; fi<5; fi++){
         Farmer[fi] = farmer.get(fi*200,0,200,200);
         deadFarmer[fi] = deadfarmer.get(fi*200,0,200,200);
       }
  }
  @Override
  public void display(){
    //display the mobs animation depending on which mob displayed
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
      image(doll, center_x, center_y, 90* SizeScale, 120* SizeScale);
      change_x = 0;
      change_y = 0; 
    }
    else if( anim == 4 && life>0){
      image(Farmer[(int(currentFrame))%5], center_x, center_y, fr_w, h);
      change_x = 0;
      change_y = 0; 
    }
    else if( anim == 4 && life<0){
      image(deadFarmer[int(deadFrame)%5], center_x, center_y, fr_w, h);
      center_y +=change_y;
    }
    else{
      center_x = -2000;
      center_y = -2000;
      change_x = 0;
      change_y = 0; 
    }
}
  @Override
   public void update(){
     //update the farmer 
     if ( anim == 4 && life<0){
       if (!farmeronlydieonce){
         farmeronlydieonce = true;
         change_y = -9;
         currentFrame = 0; 
       }
       if(deadFrame<4){
         change_y += 0.3;
         deadFrame = (deadFrame+(5/60.0));
       }
       else{
         change_y += 0.3;
         center_y +=change_y;
       }
     }
     else{
      currentFrame = (currentFrame+(n_frames/45.0));
     }
     }
  }
