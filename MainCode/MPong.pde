class MPong extends Module {
  float paddleX = 0;
  float paddleY = mod_height/2;
  float paddleWidth = 50;
  float paddleHeight = 200;
  float gap = 150;
  float wall_width = 200;
  float wally1 = random(mod_height - 200);
  float wally2 = wally1 + gap;
  float ballX = mod_width/2;
  float ballY = mod_height/2;
  float xSpeed = -5;
  float ySpeed = -5;
  float radius = 10;

  MPong() {
    rectMode(CORNERS);
    completed = false;
    empty = false;
  }

  void display() {      
    //background
    fill(255);

    rect(0, 0, mod_width, mod_height);

    fill(0);

    //player paddle
    rect(paddleX, paddleY, paddleX + paddleWidth, paddleY + paddleHeight);

    //random walls
    rect(mod_width - wall_width, wally1, mod_width, 0);
    rect(mod_width - wall_width, mod_height, mod_width, wally2);

    //ball
    ellipse(ballX, ballY, radius*2, radius*2);
  }

  void run() {    
    ballY = ballY - ySpeed;
    ballX = ballX - xSpeed;
    
    //complete at right limit
    if (ballX + radius >= mod_width) {
      completed = true;
    }
    
    //left limit
    if (ballX - radius <=0) {
      ballX = mod_width/2;
      ballY = mod_height/2;

      xSpeed = -5;
      ySpeed = -5;
    }

    //top and bottom limits
    if (ballY - radius <= 0 || ballY + radius >= mod_height) {
      ySpeed = -ySpeed;
    }

    //right limit for upper rectangle
    if (ballX + radius >= mod_width - wall_width) {
      if (ballY + radius <= wally1) {
        xSpeed = abs(xSpeed);
      }
    }

    //right limit for lower rectangle
    if (ballX + radius >= mod_width - wall_width) {
      if (ballY + radius >= wally2 && ballY - radius <= mod_height + radius/10) {
        xSpeed = abs(xSpeed);
      }
    } 
    
    //bottom limit for upper rectangle
    if(ballY - radius <= wally1){
      if(ballX + radius >= mod_width - wall_width + radius/10){
        ySpeed = -abs(ySpeed);
      }
    }
    
    //top limit for lower rectangle
    if(ballY + radius >= wally2){
      if(ballX + radius >= mod_width - wall_width + radius/10){
        ySpeed = abs(ySpeed);
      }
    }

    //paddle collide right side
    if (ballX -radius <= paddleX + paddleWidth) {
      if (ballY - radius >= paddleY && ballY + radius <= paddleY + paddleHeight) {
        xSpeed = -abs(xSpeed);
      }
    }

    if (keyPressed) {
      if (keyCode == UP && (paddleY) > 0) {//move left paddle up
        paddleY = paddleY - 5;
      }
      if (keyCode == DOWN && (paddleY + paddleHeight) < mod_height) { //move left paddle down
        paddleY = paddleY + 5;
      }
    }
  }
}