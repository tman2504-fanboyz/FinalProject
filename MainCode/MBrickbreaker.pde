class Paddle {
  float paddleX;
  float paddleY;
  float paddleWidth;
  float paddleHeight;

  Paddle() {
    paddleX = mod_width/2;
    paddleY = mod_height - 75;
    paddleWidth = 100;
    paddleHeight = 25;
  }

  void display() {
    fill(255);
    rect(paddleX, paddleY, paddleWidth, paddleHeight);
  }
}

class Ball {
  float ballX;
  float ballY;
  float velX;
  float velY;
  float diam; 

  Ball() {
    ballX = 300;
    ballY = mod_height - 300; 
    velX = 0; //initial zero in x direction
    velY = 4; 
    diam = 20;
  }

  void display() {
    fill(255);
    ellipse(ballX, ballY, diam, diam);
  }

  void run() {
    ballY = ballY + velY;
    ballX = ballX + velX;
  }

  //Ball goes left
  void goLeft() {
    velX = -4; //decrement x
  }

  //Ball goes right
  void goRight() {
    velX = 4; //increment x
  }

  //Ball changes in y direction
  void changeY() {
    velY *= -1;
  }

  //If ball goes below paddle, reset
  void reset() {
    ballX = mod_width/2;
    ballY = mod_height - 300;
    velX = 0;
    velY = 4;
  }

  boolean collidedWith(float x, float y, float bwidth, float bheight) {
    return (ballX - diam/2 <= x + bwidth && 
      ballX + diam/2 >= x &&
      ballY - diam/2 <= y + bheight &&
      ballY + diam/2 >= y);
  }
}

  class Brick {
  float brickX;
  float brickY;
  float brickWidth;
  float brickHeight;
  float r;
  float g;
  float b; 

  //hit by ball yes or no 
  boolean hit; 

  Brick(float xinit, float yinit) {
    brickX = xinit;
    brickY = yinit;

    r = random(150, 300);
    g = random(150, 300);
    b = random(150, 300); 

    brickWidth = mod_width/8;
    brickHeight = 40; 

    //bricks aren't hit initially
    hit = false;
  }

  void display() {
    fill(r, g, b);
    rect(brickX, brickY, brickWidth, brickHeight);
  }

  //What happens to the brick once it gets hit
  void hit() {
    //brick recognizes that it has been hit
    hit = true; 
    r = 0;
    g = 0;
    b = 0;
  }
}

class MBrickbreaker extends Module {

  int rows = 4; //number of bricks per row 
  int columns = 3; //number of columns 
  int i;
  int j;

  Paddle paddle = new Paddle();
  Ball ball = new Ball();
  Brick[][] brick = new Brick[rows][columns];

  MBrickbreaker() {
    completed = false;
    empty = false;

    //places all the bricks into the array, properly labelled
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        brick[i][j] = new Brick((i+1) * mod_width/(rows + 2), (j+1) * 50);
      }
    }
  }

  void display() {
    rectMode(CORNER);

    //background
    fill(0);
    rect(0, 0, mod_width, mod_height);

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        brick[i][j].display();
      }
    }  

    paddle.display();
    ball.display();

    rectMode(CORNERS);
  }

  void run() {
    boolean nobricks = true;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        //if ball hits bottom of brick ball moves down
        if (ball.ballY - ball.diam/2 <= brick[i][j].brickY + brick[i][j].brickHeight &&
          ball.ballY - ball.diam/2 >= brick[i][j].brickY &&
          ball.ballX >= brick[i][j].brickX && 
          ball.ballX <= brick[i][j].brickX + brick[i][j].brickWidth &&
          brick[i][j].hit == false) {
          ball.changeY();
          brick[i][j].hit();
        }

        //If ball hits top of brick ball moves up
        if (ball.ballY + ball.diam/2 >= brick[i][j].brickY &&
          ball.ballY - ball.diam/2 <= brick[i][j].brickY + brick[i][j].brickHeight/2 &&
          ball.ballX >= brick[i][j].brickX && ball.ballX <= brick[i][j].brickX + brick[i][j].brickWidth &&
          brick[i][j].hit == false ) {
          ball.changeY();
          brick[i][j].hit();
        }

        //if ball hits the left of the brick, ball switches to the right, and moves in same direction
        if (ball.ballX + ball.diam/2 >= brick[i][j].brickX &&
          ball.ballX + ball.diam/2 <= brick[i][j].brickX + brick[i][j].brickWidth / 2 && ball.ballY >= brick[i][j].brickY &&
          ball.ballY <= brick[i][j].brickY + brick[i][j].brickHeight &&
          brick[i][j].hit == false) {
          ball.goLeft();
          brick[i][j].hit();
        }

        //if ball hits the right of the brick, ball switches to the left, and moves in same direction
        if (ball.ballX - ball.diam/2 <= brick[i][j].brickX + brick[i][j].brickWidth &&
          ball.ballX + ball.diam/2 >= brick[i][j].brickX + brick[i][j].brickWidth/2 &&
          ball.ballY >= brick[i][j].brickY &&
          ball.ballY <= brick[i][j].brickY + brick[i][j].brickHeight &&
          brick[i][j].hit == false) {
          ball.goRight();
          brick[i][j].hit();
        }

        if (brick[i][j].hit == false) {
          nobricks = false;
        }
      }
    }

    if (nobricks) {
      completed = true;
    }

    //collisions with the left top and right top of the paddle
    if (ball.ballY <= paddle.paddleY &&
      ball.ballY >= paddle.paddleY + paddle.paddleHeight &&
      ball.ballX >= paddle.paddleX && 
      ball.ballX <= paddle.paddleX + (paddle.paddleWidth/2) ) {
      ball.goLeft();
      ball.changeY();
    }

    if (ball.ballY <= paddle.paddleY &&
      ball.ballY >= paddle.paddleY + paddle.paddleHeight &&
      ball.ballX >= paddle.paddleX + (paddle.paddleWidth/2) &&
      ball.ballX <= paddle.paddleX + paddle.paddleWidth) {
      ball.goRight();
      ball.changeY();
    }

    //wall collisions
    if (ball.ballX + ball.diam / 2 >= mod_width) {
      ball.goLeft();
    }

    if (ball.ballX - ball.diam / 2 <= 0) {
      ball.goRight();
    }

    if (ball.ballY - ball.diam / 2 <= 0) {
      ball.changeY();
    }

    if (ball.ballY > mod_height) {
      ball.reset();
      failures++;
    }

    ball.run();

    if (keyPressed) {
      if (keyCode == RIGHT) {
        if (paddle.paddleX + paddle.paddleWidth < mod_width) {
          paddle.paddleX += 10;
        }
      }

      if (keyCode == LEFT) {
        if (paddle.paddleX > 0) {
          paddle.paddleX -= 10;
        }
      }
    }
  }
}