class MPong extends Module {
  float paddleX = 0;
  float paddleY = mod_height/2;
  float paddleWidth = 25;
  float paddleHeight = 100;
  float paddleSpeed = 0;
  float gap = 150;
  float wall_width = 25;
  float wally1 = random(mod_height - 200);
  float wally2 = wally1 + gap;
  float ballX = mod_width/2;
  float ballY = mod_height/2;
  float xSpeed = 5;
  float ySpeed = 5;
  float radius = 10;

  MPong() {
    rectMode(CORNERS);
    completed = false;
    empty = false;
  }

  void display() {      
    //background
    fill(0);
    rect(0, 0, mod_width, mod_height);

    fill(0, 240, 0);

    //player paddle
    rect(paddleX, paddleY, paddleX + paddleWidth, paddleY + paddleHeight);

    //random walls
    rect(mod_width - wall_width, wally1, mod_width, 0);
    rect(mod_width - wall_width, mod_height, mod_width, wally2);

    //ball
    ellipse(ballX, ballY, radius*2, radius*2);
  }

  void run() {    
    ballY = ballY + ySpeed;
    ballX = ballX + xSpeed;

    //limit the paddle at the top and bottom, or if there are no keys being pressed
    if ((paddleY <= 0 && paddleSpeed < 0) || (paddleY + paddleHeight >= mod_height && paddleSpeed > 0) || !keyPressed) {
      paddleSpeed = 0;
    }

    paddleY += paddleSpeed;

    //paddle collide right side
    if (ballX - radius <= paddleWidth) {
      if (ballY + radius >= paddleY && ballY - radius <= paddleY + paddleHeight) {
        xSpeed = abs(xSpeed);
        ySpeed += random(-2, 2) + paddleSpeed/10;
        ySpeed = ySpeed % 5;
      }
    }

    //top and bottom limits
    if (ballY - radius <= 0 || ballY + radius >= mod_height) {
      ySpeed = -ySpeed;
    }

    //right limit for upper rectangle
    if (ballX + radius >= mod_width - wall_width && ballX <= mod_width - wall_width + radius/60) {
      if (ballY + radius <= wally1) {
        xSpeed = -abs(xSpeed);
      }
    }

    //right limit for lower rectangle
    if (ballX + radius >= mod_width - wall_width && ballX <= mod_width - wall_width + radius/60) {
      if (ballY + radius >= wally2) {
        xSpeed = -abs(xSpeed);
      }
    } 

    //bottom limit for upper rectangle
    if (ballY - radius <= wally1 && ballY >= wally1 - radius/60) {
      if (ballX + radius >= mod_width - wall_width) {
        ySpeed = abs(ySpeed);
      }
    }

    //top limit for lower rectangle
    if (ballY + radius >= wally2 && ballY <= wally2 + radius/60) {
      if (ballX + radius >= mod_width - wall_width) {
        ySpeed = -abs(ySpeed);
      }
    }    

    //complete at right limit
    if (ballX + radius >= mod_width) {
      mods_completed++;
      completed = true;
    }

    //left limit
    if (ballX - radius <=0) {
      ballX = mod_width/2;
      ballY = mod_height/2;

      xSpeed = 5;
      ySpeed = 5;

      failures++;
    }
  }

  void keyPress() {
    if (keyCode == UP && paddleY > 0) {//move left paddle up
      paddleSpeed = -10;
    } else if (keyCode == DOWN && paddleY + paddleHeight < mod_height) { //move left paddle down
      paddleSpeed =  10;
    } else {
      paddleSpeed = 0;
    }
  }
}