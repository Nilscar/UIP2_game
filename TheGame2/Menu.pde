public class Menu{
  float MENU_MARGIN;
  float SCALE_W;
  float SCALE_RIGHT_H;
  float SCALE_PANEL_W;
  float SCALE_PANEL_H;
  float SCALE_LEFT_H;
  
  String gameTitle = "GAME TITLE";
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
  PImage soundOn, soundOff, musicOn, musicOff;
  PImage skillBox;
  Sprite rightBox, leftBoxUp, leftBoxDown, panelLeft, panelRight, crossButton, soundButton, musicButton;
  Sprite[] itemBoxes;
  int nrItemBoxes = 3;
  int healthPoints = 11;
  int hpCounter = healthPoints-1;
  int expCounter = 0;
  int lvlCounter = 1;
  PImage[] healthBar = new PImage[healthPoints];
  PImage[] lvlBar = new PImage[healthPoints];
  
  public Menu(){
    //Setting the menu margins based on screen size
    MENU_MARGIN = displayWidth/20;
    SCALE_W = displayWidth/2 - MENU_MARGIN;
    SCALE_RIGHT_H = displayHeight - MENU_MARGIN;
    SCALE_PANEL_W = displayWidth/2 - 2*MENU_MARGIN;
    SCALE_PANEL_H = displayHeight/2 - 2*MENU_MARGIN;
    SCALE_LEFT_H = displayHeight/2 - MENU_MARGIN;
    itemBoxes = new Sprite[nrItemBoxes];
    
    menuBoxBrown = loadImage("data/menu/panel_brown.png");
    menuBoxBlue = loadImage("data/menu/panel_blue.png");
    itemBox = loadImage("data/menu/buttonSquare_beige.png");
    menuPanel = loadImage("data/menu/panelInset_beige.png");
    closeButton = loadImage("data/menu/buttonRound_blue.png");
    cross = loadImage("data/menu/iconCross_grey.png");
    hpLeft = loadImage("data/menu/barRed_horizontalLeft.png");
    hpRight = loadImage("data/menu/barRed_horizontalRight.png");
    hpMid = loadImage("data/menu/barRed_horizontalMid.png");
    hpLeft.resize(hpLeft.get().width*4, hpLeft.get().height*2);
    hpRight.resize(hpRight.get().width*4, hpRight.get().height*2);
    hpMid.resize(hpMid.get().width*2, hpMid.get().height*2);
    healthBar = createBar(hpLeft, hpMid, hpRight, healthPoints);
    
    lvlLeft = loadImage("data/menu/barBack_horizontalLeft.png");
    lvlRight = loadImage("data/menu/barBack_horizontalRight.png");
    lvlMid = loadImage("data/menu/barBack_horizontalMid.png");
    lvlLeft.resize(lvlLeft.get().width*4, lvlLeft.get().height*2);
    lvlRight.resize(lvlRight.get().width*4, lvlRight.get().height*2);
    lvlMid.resize(lvlMid.get().width*2, lvlMid.get().height*2);
    lvlBar = createBar(lvlLeft, lvlMid, lvlRight, healthPoints);
    
    lvlPointLeft = loadImage("data/menu/barBlue_horizontalLeft.png");
    lvlPointRight = loadImage("data/menu/barBlue_horizontalRight.png");
    lvlPointMid = loadImage("data/menu/barBlue_horizontalBlue.png");
    lvlPointLeft.resize(lvlPointLeft.get().width*4, lvlPointLeft.get().height*2);
    lvlPointRight.resize(lvlPointRight.get().width*4, lvlPointRight.get().height*2);
    lvlPointMid.resize(lvlPointMid.get().width*2, lvlPointMid.get().height*2);
    
    soundOn = loadImage("data/menu/shadedDark17.png");
    soundOff = loadImage("data/menu/shadedDark19.png");
    musicOn = loadImage("data/menu/shadedDark13.png");
    musicOff = loadImage("data/menu/shadedDark15.png");
    skillBox = loadImage("data/menu/square_shadow.png");
    
    rightBox = new Sprite(menuBoxBrown, 0.75*displayWidth, displayHeight/2, SCALE_W, SCALE_RIGHT_H, false);
    leftBoxUp = new Sprite(menuBoxBrown, 0.25*displayWidth, 0.25*displayHeight, SCALE_W, SCALE_LEFT_H, false);
    leftBoxDown = new Sprite(menuBoxBlue, 0.25*displayWidth, 0.75*displayHeight, SCALE_W, SCALE_LEFT_H, false);
    panelLeft = new Sprite(menuPanel, leftBoxUp.center_x, leftBoxUp.center_y, SCALE_PANEL_W, SCALE_PANEL_H, false);
    panelRight = new Sprite(menuPanel, rightBox.center_x, leftBoxDown.center_y, SCALE_PANEL_W, SCALE_PANEL_H, false);
    for(int i = 0; i < 3; i++){
      itemBoxes[i] = new Sprite(itemBox, leftBoxDown.getLeft() + (SCALE_W + SCALE_W*i)/4, leftBoxDown.center_y, (SCALE_W-MENU_MARGIN)/4, SCALE_LEFT_H - 1.5*MENU_MARGIN, false);
    }
    crossButton = new Sprite(closeButton, rightBox.getRight() - MENU_MARGIN/4, rightBox.getTop() + MENU_MARGIN/4, MENU_MARGIN, MENU_MARGIN, true);
    soundButton = new Sprite(soundOn, panelRight.getRight() - (MENU_MARGIN + soundOn.width/4), panelRight.getTop() + MENU_MARGIN/2, soundOn.width, soundOn.height, true);
    musicButton = new Sprite(musicOn, panelRight.getRight() - MENU_MARGIN/2, panelRight.getTop() + MENU_MARGIN/2, musicOn.width, musicOn.height, true);
  }
  
  void viewMenu(String hp, String lvl){ //displays the menu blocks and content of the pause menu
    rightBox.display();
    textAlign(CENTER, TOP);
    textSize(128);
    fill(#296986); 
    text(gameTitle, rightBox.center_x, rightBox.getTop() + MENU_MARGIN/2);
    leftBoxUp.display();
    leftBoxDown.display();
    panelLeft.display();
    panelRight.display();
    for(int i = 0; i < healthBar.length; i++){
        image(healthBar[i], panelLeft.w/2 + i*healthBar[i].width, panelLeft.getTop() + MENU_MARGIN);
        image(lvlBar[i], panelLeft.w/2 + i*lvlBar[i].width, panelLeft.getTop() + 1.5*MENU_MARGIN);
        
    }
    /*
    stroke(255);
    noFill();
    rect(displayWidth - int(RIGHT_MARGIN), 30, healthBar[0].width * healthPoints, healthBar[0].height);
    rect(panelLeft.w/2 - healthBar[0].width/2, panelLeft.getTop() + MENU_MARGIN, healthBar[0].width * healthPoints, healthBar[0].height/2);
    */
    fill(#B24A16);
    textAlign(LEFT, CENTER);
    textSize(healthBar[0].height);
    text("HP: "+hp+"%", panelLeft.getLeft() + MENU_MARGIN, panelLeft.getTop() + MENU_MARGIN - healthBar[0].height/4);
    text("Lvl: "+lvl, panelLeft.getLeft() + MENU_MARGIN, panelLeft.getTop() + 1.5*MENU_MARGIN - healthBar[0].height/4);
    
    for(int i = 0; i < 3; i++){
      itemBoxes[i].display();
    }
    crossButton.display();
    image(cross, crossButton.center_x, crossButton.center_y, crossButton.w/2, crossButton.h/2);
    soundButton.display();
    musicButton.display();
  }
  
  public void updateBars(int num, String bar){ //updates a bar to the according value(if hp is lost or exp gained)
    if(num >= 0 && num <= healthPoints - 2 && bar == "lvl"){
      lvlBar[num] = lvlPointMid;
    }
    else if(num > 0 && num == healthPoints - 1 && bar == "lvl"){
      lvlBar[num] = lvlPointMid;
      lvlBar = createBar(lvlLeft, lvlMid, lvlRight, healthPoints);
    }
    else if(num == 0 && bar == "hp"){
      healthBar = createBar(lvlLeft, lvlMid, lvlRight, healthPoints);
    }
    else if(num == healthPoints - 1 && bar == "hp"){
      healthBar[healthPoints-1] = lvlMid;
      healthBar[healthPoints-2] = hpMid;
    }
    else if(num < healthPoints - 1 && bar == "hp"){
      healthBar[num] = lvlMid;
      healthBar[num-1] = hpMid;
    }
  }
  
  public void drawBars(){ //copies the hp and lvl bar from the menu to the in-game view
     for(int i = 0; i < healthBar.length; i++){
         copy(healthBar[i], int(panelLeft.w/2 - healthBar[i].width/2 + i*healthBar[i].width), int(panelLeft.getTop() + MENU_MARGIN - healthBar[i].height/2), healthBar[i].width, healthBar[i].height, displayWidth - int(RIGHT_MARGIN) + i*healthBar[i].width, 30, healthBar[i].width, healthBar[i].height);
         copy(lvlBar[i], int(panelLeft.w/2 + i*lvlBar[i].width), int(panelLeft.getTop() + 1.5*MENU_MARGIN), lvlBar[i].width, lvlBar[i].height, displayWidth - int(RIGHT_MARGIN) + i*lvlBar[i].width, 80, lvlBar[i].width, lvlBar[i].height);

        //image(healthBar[i], displayWidth - int(RIGHT_MARGIN) + i*healthBar[i].width, 30);
        //image(lvlBar[i], displayWidth - int(RIGHT_MARGIN) + i*lvlBar[i].width, 80);
    }
  }

  PImage[] createBar(PImage left, PImage mid, PImage right, int hp){ //creates a hp or lvl bar of a given length
    PImage[] bar = new PImage[hp];
    for(int i = 0; i < bar.length; i++){
      bar[i] = mid;
    }
    return bar;
  }
}
