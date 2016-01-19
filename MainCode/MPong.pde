class MPong extends Module {
  float paddleX = 0;
  float paddleY = mod_height/2;
  float paddleWidth = 50;
  float paddleHeight = 200;
  float gap = 100;
  float wall_width = 50;
  float wally1 = random(mod_height - 200);
  float wally2 = wally1 + gap;
  float ballX = mod_width/2;
  float ballY = mod_height/2;
  float xSpeed = -5;
  float ySpeed = -5;
  float diam = gap/10;

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
    ellipse(ballX, ballY, diam, diam);
  }

  void run() {    
    ballY = ballY - ySpeed;
    ballX = ballX - xSpeed;

    //top and bottom limits
    if (ballY - diam <= 0 || ballY + diam >= mod_height) {
      ySpeed = -ySpeed;
    }

    //right limit for upper rectangle
    if (ballX + diam >= mod_width - wall_width) {
      if (ballY - diam >= 0 && ballY + diam <= wally1) {
        xSpeed = abs(xSpeed);
      }
    }

    //right limit for lower rectangle
    if (ballX + diam >= mod_width - wall_width) {
      if (ballY + diam >= wally2 && ballY - diam <= mod_height) {
        xSpeed = abs(xSpeed);
      }
    } 

    //completed
    if (ballX + diam >= mod_width) {
      completed = true;
    }

    //left limit
    if (ballX - diam <=0) {
      ballX = mod_width/2;
      ballY = mod_height/2;

      xSpeed = -5;
      ySpeed = -5;
    }

    //paddle collide right side
    if (ballX -diam <= paddleX + paddleWidth) {
      if (ballY - diam >= paddleY && ballY + diam <= paddleY + paddleHeight) {
        xSpeed = -abs(xSpeed);
      }
    }

    //paddle collide top and bottom
    if (ballY - diam >= paddleY && ballX - diam < paddleWidth) {
      ySpeed = -abs(ySpeed);
    }
    if (ballY + diam<= paddleY + paddleHeight && ballX - diam< paddleWidth) {
      ySpeed = abs(ySpeed);
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