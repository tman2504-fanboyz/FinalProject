Bomb bomb;

//game_state:
//1 = title screen
//2 = difficulty select
//3 = gameplay
//4 = game over
//5 = game won
int game_state; 

//difficulty:
//1 = easy
//2 = medium
//3 = hard
//4 = insane
int difficulty;

int flicker_timer;

void setup() {
  fullScreen();
  frameRate(100);

  //set the font to be comic sans
  PFont font;
  font = createFont("Comic Sans MS", 32); 
  textFont(font); 

  game_state = 1;
  difficulty = 1;

  flicker_timer = 0;
}

void draw() {
  if (game_state == 1) {
    //title screen
    background(255);

    if (flicker_timer > 33) fill(0);
    else fill(255, 255, 255, 0);

    textAlign(CENTER, CENTER);
    text("Press any Key", width/2, 7*height/8);
  } else if (game_state == 2) {
    //difficulty select
    background(255);

    if (flicker_timer > 33) fill(0);
    else fill(255, 255, 255, 0);

    textAlign(CENTER, CENTER);
    text("Press ENTER", width/2, 7*height/8);
  } else if (game_state == 3) {
    //gameplay, draw the bomb
    background(255);

    bomb.display();
  } else if (game_state == 4) {
    //game over, draw the game over text
    background(0);

    if (flicker_timer > 33) fill(0);
    else fill(255, 255, 255, 0);

    text("Press any Key", width/2, 7*height/8);
  } else if (game_state == 5) {
    //game won, draw the game over text
    background(0, 255, 0);

    if (flicker_timer > 33) fill(0);
    else fill(255, 255, 255, 0);

    textAlign(CENTER, CENTER);
    text("Press any Key", width/2, 7*height/8);
  }

  //increment the timer for flickering the text, reset if it's too big
  flicker_timer++;

  if (flicker_timer > 100)
    flicker_timer = 0;
}

void keyPressed() {
  if (game_state == 1) {
    game_state = 2;
  } else if (game_state == 2) {
    if (keyCode == ENTER) {
      bomb = new Bomb(difficulty);
      game_state = 3;
    } else if (keyCode == LEFT && difficulty > 1) {
      difficulty--;
    } else if (keyCode == RIGHT && difficulty < 4) {
      difficulty++;
    }
  } else if (game_state == 3) {
    bomb.keyPress();
  } else if (game_state == 4 || game_state == 5) {
    setup();
  }
}