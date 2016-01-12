Bomb bomb;

//game_state:
//0 = title screen
//1 = difficulty select
//2 = options
//3 = gameplay
//4 = game over
int game_state; 

void setup() {
  fullScreen();
  //size(900, 600);
  frameRate(100);

  game_state = 3;

  bomb = new Bomb(10);
}

void draw() {
  if (game_state == 3) {
    //gameplay, draw the bomb
    background(255);

    bomb.display();
  } else if (game_state == 4) {
    //game over, draw the game over text
    background(0);

    fill(255);
    textAlign(CENTER, CENTER);
    text("Boom.", width/2, height/2);
  }
}

void keyPressed() {
  if (game_state == 3) {
    bomb.keyPress();
  } else if (game_state == 4) {
    setup();
  }
}