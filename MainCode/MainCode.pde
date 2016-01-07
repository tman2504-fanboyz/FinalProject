Bomb bomb;

//game_state:
//0 = title screen
//1 = difficulty select
//2 = options
//3 = gameplay
//4 = game over
int game_state = 3; 

void setup(){
  size(640, 480);
  frameRate(100);
  
  bomb = new Bomb(10);
}

void draw(){
  if(game_state == 3){
    background(255);
    
    bomb.display();
  }
  else if(game_state == 4){
    background(0);
    
    fill(255);
    textAlign(CENTER, CENTER);
    text("Boom.", width/2, height/2);
  }
}