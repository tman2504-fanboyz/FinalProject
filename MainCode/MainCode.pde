Bomb bomb;

//game_state:
//1 = title screen
//2 = difficulty select
//3 = gameplay
//4 = game over
//5 = game won
int game_state; 
int game_state_prev;

//difficulty:
//1 = easy
//2 = medium
//3 = hard
//4 = insane
int difficulty;

//for the title slide-in effect
float title_y;

//for the text blink effect
int flicker_timer;

//so player can't rush through the menus
int menu_key_timer;
int menu_key_timer_max;

//score values
int mods_completed;
int mistakes_made;

//backgrounds for each game state
PImage title;
PImage diff;
PImage game;
PImage lose;
PImage win;

//help popup images
PImage hdifficulty;
PImage hgame;
PImage hmath;
PImage hbrickbreaker;
PImage hfrogger;
PImage hpong;

void setup() {
  fullScreen();
  frameRate(100);

  //set the font to be comic sans
  PFont font;
  font = createFont("Comic Sans MS", 32); 
  textFont(font);   

  game_state = 1;
  game_state_prev = 0;

  difficulty = 1;

  //load all images
  title = loadImage("rsc/stitle.png");
  diff = loadImage("rsc/sdiff.png");
  game = loadImage("rsc/sgame.png");
  lose = loadImage("rsc/slose.png");
  win = loadImage("rsc/swin.png");

  hdifficulty = loadImage("rsc/hdifficulty.png");
  hgame = loadImage("rsc/hgame.png");
  hmath = loadImage("rsc/hmath.png");
  hbrickbreaker = loadImage("rsc/hbrickbreaker.png");
  hfrogger = loadImage("rsc/hfrogger.png");
  hpong = loadImage("rsc/hpong.png");

  flicker_timer = 0;

  menu_key_timer_max = 50;
  menu_key_timer = menu_key_timer_max;

  mods_completed = 0;
  mistakes_made = 0;

  title_y = width*4;
}

void draw() {
  if (game_state == 1) {
    if (title_y != 0)
      title_y *= 0.9;

    //title screen
    background(255);

    imageMode(CENTER);
    image(title, width/2, height/2 - title_y);

    fill(0);
    textAlign(CENTER, CENTER);

    if (flicker_timer > 33) 
      text("Press Any Key", width/2, 7*height/8);
  } else if (game_state == 2) {
    //difficulty select
    background(255);

    imageMode(CENTER);
    image(diff, width/2, height/2);

    fill(0);
    textAlign(CENTER, CENTER);

    //display difficulty
    switch(difficulty) {
    case 1:
      text("<    EASY    >", width/2, height/2);
      break;
    case 2:
      text("<  MEDIUM  >", width/2, height/2);
      break;
    case 3:
      text("<    HARD    >", width/2, height/2);
      break;
    case 4:
      text("<  INSANE  >", width/2, height/2);
      break;
    }
    
    image(hdifficulty, width/2, 6*height/8);

    if (flicker_timer > 33)
      text("Press ENTER", width/2, 7*height/8);
  } else if (game_state == 3) {
    //gameplay, draw the bomb
    background(28, 38, 55);

    imageMode(CENTER);
    image(game, width/2, height/2);

    bomb.display();
  } else if (game_state == 4) {
    //game over, draw the game over text
    background(0);

    imageMode(CENTER);
    image(lose, width/2, height/2);

    fill(255);

    //score text
    textAlign(LEFT, CENTER);
    text("Modules Completed: "+mods_completed+"/"+int(float(difficulty)/4.0*float(mod_num))+"\n"+
      "Mistakes Made: "+mistakes_made, 
      width/6, 3*height/4);

    textAlign(CENTER, CENTER);

    if (flicker_timer > 33)
      text("Press Any Key", width/2, 7*height/8);
  } else if (game_state == 5) {
    //game won, draw the game over text
    background(34, 177, 76);

    imageMode(CENTER);
    image(win, width/2, height/2);

    fill(255);

    //score text
    textAlign(LEFT, CENTER);

    text("Time Elapsed: "+nf(90-bomb.defuse_time, 0, 2)+"s"+"\n"+
      "Modules Completed: "+mods_completed+"/"+int(float(difficulty)/4.0*float(mod_num))+"\n"+
      "Mistakes Made: "+mistakes_made, 
      width/6, 3*height/4);

    textAlign(CENTER, CENTER);

    if (flicker_timer > 33) 
      text("Press Any Key", width/2, 7*height/8);
  }

  //increment the timer for flickering the text, reset if it's too big
  flicker_timer++;

  if (flicker_timer > 100)
    flicker_timer = 0;

  //decrement menu key timer
  if (menu_key_timer > 0)
    menu_key_timer--;
}

void keyPressed() {
  if (menu_key_timer <= 0) {
    if (game_state == 1) {
      //go to difficulty menu
      game_state = 2;
    } else if (game_state == 2) {
      //navigate the difficulty menu
      if (keyCode == ENTER) {
        bomb = new Bomb(difficulty);
        game_state = 3;
      } else if (keyCode == LEFT && difficulty > 1) {
        difficulty--;
      } else if (keyCode == RIGHT && difficulty < 4) {
        difficulty++;
      }
    } else if (game_state == 3) {
      //do key presses for the bomb
      bomb.keyPress();
    } else if (game_state == 4 || game_state == 5) {
      //reset the game
      setup();
    }
  }

  if (game_state_prev != game_state) {
    menu_key_timer = menu_key_timer_max;
  }

  game_state_prev = game_state;
}