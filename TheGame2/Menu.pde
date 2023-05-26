public class Menu{
  float MENU_MARGIN;
  float SCALE_W;
  float SCALE_RIGHT_H;
  float SCALE_PANEL_W;
  float SCALE_PANEL_H;
  float SCALE_LEFT_H;
  
  PImage menu;
  PImage menuBoxBrown;
  PImage menuBoxBlue;
  PImage menuPanel;
  PImage itemBox;
  PImage closeButton;
  PImage cross;
  PImage playButton;
  PImage hpLeft;
  PImage hpRight;
  PImage hpMid;
  PImage lvlLeft;
  PImage lvlRight;
  PImage lvlMid;
  PImage lvlPointLeft;
  PImage lvlPointRight;
  PImage lvlPointMid;
  PImage skillBox;
  int healthPoints = 25;
  int hpCounter = healthPoints;
  int expCounter = 0;
  int lvlCounter = 1;
  PImage[] healthBar = new PImage[healthPoints];
  PImage[] lvlBar = new PImage[healthPoints];
  
  public Menu(){
    MENU_MARGIN = displayWidth/20;
    SCALE_W = displayWidth/2 - MENU_MARGIN;
    SCALE_RIGHT_H = displayHeight - MENU_MARGIN;
    SCALE_PANEL_W = displayWidth/2 - 2*MENU_MARGIN;
    SCALE_PANEL_H = displayHeight/2 - 2*MENU_MARGIN;
    SCALE_LEFT_H = displayHeight/2 - MENU_MARGIN;
    
    menuBoxBrown = loadImage("data/menu/panel_brown.png");
    menuBoxBlue = loadImage("data/menu/panel_blue.png");
    itemBox = loadImage("data/menu/buttonSquare_beige.png");
    menuPanel = loadImage("data/menu/panelInset_beige.png");
    closeButton = loadImage("data/menu/buttonRound_blue.png");
    cross = loadImage("data/menu/iconCross_grey.png");
    hpLeft = loadImage("data/menu/barRed_horizontalLeft.png");
    hpRight = loadImage("data/menu/barRed_horizontalRight.png");
    hpMid = loadImage("data/menu/barRed_horizontalMid.png");
    hpLeft.resize(hpLeft.get().width*2, hpLeft.get().height*2);
    hpRight.resize(hpRight.get().width*2, hpRight.get().height*2);
    hpMid.resize(hpMid.get().width, hpMid.get().height*2);
    healthBar = createBar(hpLeft, hpMid, hpRight, healthPoints);
    
    lvlLeft = loadImage("data/menu/barBack_horizontalLeft.png");
    lvlRight = loadImage("data/menu/barBack_horizontalRight.png");
    lvlMid = loadImage("data/menu/barBack_horizontalMid.png");
    lvlLeft.resize(lvlLeft.get().width*2, lvlLeft.get().height*2);
    lvlRight.resize(lvlRight.get().width*2, lvlRight.get().height*2);
    lvlMid.resize(lvlMid.get().width, lvlMid.get().height*2);
    lvlBar = createBar(lvlLeft, lvlMid, lvlRight, healthPoints);
    
    lvlPointLeft = loadImage("data/menu/barBlue_horizontalLeft.png");
    lvlPointRight = loadImage("data/menu/barBlue_horizontalRight.png");
    lvlPointMid = loadImage("data/menu/barBlue_horizontalBlue.png");
    lvlPointLeft.resize(lvlPointLeft.get().width*2, lvlPointLeft.get().height*2);
    lvlPointRight.resize(lvlPointRight.get().width*2, lvlPointRight.get().height*2);
    lvlPointMid.resize(lvlPointMid.get().width, lvlPointMid.get().height*2);
    
    skillBox = loadImage("data/menu/square_shadow.png");
    
  }
  
  void createMenuBlocks(){
    
  }
  
  public void drawMenu(){
    background(#3890BF);
    imageMode(CORNER);
    image(menuBoxBrown, displayWidth/2 + MENU_MARGIN/2, MENU_MARGIN, displayWidth/2 - 1.5*MENU_MARGIN, displayHeight - 2*MENU_MARGIN); //draws the right side box
    for(int i = 0; i < healthBar.length; i++){ //draws the health and lvl bars
      image(healthBar[i], (displayWidth/2 + 3*MENU_MARGIN) + i*healthBar[i].width, 2.5*MENU_MARGIN);
      image(lvlBar[i], (displayWidth/2 + 3*MENU_MARGIN) + i*healthBar[i].width, 3.5*MENU_MARGIN);
    }
    image(menuBoxBrown, MENU_MARGIN, MENU_MARGIN, displayWidth/2 - 1.5*MENU_MARGIN, displayHeight/2 - 1.5*MENU_MARGIN); //draws the upper left box
    image(menuBoxBlue, MENU_MARGIN, displayHeight/2 + MENU_MARGIN/2, displayWidth/2 - 1.5*MENU_MARGIN, displayHeight/2 - 1.5*MENU_MARGIN); //draws the lower left box
    image(itemBox, 1.5*MENU_MARGIN, displayHeight/2 + MENU_MARGIN, 2*MENU_MARGIN, 3*MENU_MARGIN);
    image(itemBox, 4*MENU_MARGIN, displayHeight/2 + MENU_MARGIN, 2*MENU_MARGIN, 3*MENU_MARGIN);
    image(itemBox, 6.5*MENU_MARGIN, displayHeight/2 + MENU_MARGIN, 2*MENU_MARGIN, 3*MENU_MARGIN);
    image(menuPanel, 1.5*MENU_MARGIN, 1.5*MENU_MARGIN, displayWidth/2 - 2.5*MENU_MARGIN, displayHeight/2 - 2.5*MENU_MARGIN); //draws the upper left panel that is in the box
    textSize(128);
    fill(#296986); 
    text("The Game", 2.5*MENU_MARGIN, 2*MENU_MARGIN);  
    image(menuPanel, displayWidth/2 + MENU_MARGIN, displayHeight/2 + MENU_MARGIN, displayWidth/2 - 2.5*MENU_MARGIN, displayHeight/2 - 2.5*MENU_MARGIN); //draws the bottom right side panel that is in the box
    fill(#F0C879);
    textAlign(LEFT, TOP);
    textSize(36);
    text("Lvl: "+str(lvlCounter), displayWidth/2 + MENU_MARGIN, 3.5*MENU_MARGIN);
    text("Health: "+str(int(100*hpCounter/healthPoints))+"%", displayWidth/2 + MENU_MARGIN, 2.5*MENU_MARGIN);
    fill(#936F27);
    text("Speed: ", displayWidth/2 + 1.5*MENU_MARGIN, displayHeight/2 + 1.5*MENU_MARGIN);
    imageMode(CENTER);
    image(closeButton, displayWidth - MENU_MARGIN - closeButton.get().width , MENU_MARGIN + closeButton.get().height , MENU_MARGIN, MENU_MARGIN); //draws the closeButton of the top right corner
    image(cross, displayWidth - MENU_MARGIN - closeButton.get().width , MENU_MARGIN + closeButton.get().height, 3*cross.get().width, 3*cross.get().height); //draws the cross of the closeButton
  }

  PImage[] createBar(PImage left, PImage mid, PImage right, int hp){
    PImage[] bar = new PImage[hp];
    bar[0] = left;
    for(int i = 1; i < bar.length - 1; i++){
      bar[i] = mid;
    }
    bar[bar.length-1] = right;
    return bar;
  }
}
