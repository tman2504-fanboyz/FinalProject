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
  float xSpeed = 10;
  float ySpeed = 10;
  float diam = 5;

  MPong() {
    rectMode(CORNERS);
    completed = false;
  }

  void display() {
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
    if (ballY <= 0 || ballY >= mod_height) {
      ySpeed = -ySpeed;
    }

    //right limits
    if (ballX >= mod_width - 50) {
      if (ballY <= wally1 || ballY >= wally2) {
        xSpeed = abs(xSpeed);
      } else {
        completed = true;
      }
    }

    //left limit
    if (ballX <=0) {
      ballX = mod_width/2;
      ballY = mod_height/2;
    }

    //paddle collide right side
    if (ballX <= paddleX + paddleWidth) {
      if (ballY >= paddleY && ballY <= paddleY + paddleHeight) {
        xSpeed = -abs(xSpeed);
      }
    }

    //paddle collide top and bottom
    if (ballY >= paddleY && ballX < paddleWidth) {
      ySpeed = -abs(ySpeed);
    }
    if (ballY <= paddleY + paddleHeight && ballX < paddleWidth) {
      ySpeed = abs(ySpeed);
    }
  }

  void keyPress() {
    if (keyCode == UP && (paddleY) > 0) {//move left paddle up
      paddleY = paddleY - 20;
    }
    if (keyCode == DOWN && (paddleY + paddleHeight) < height) { //move left paddle down
      paddleY = paddleY + 20;
    }
  }
}