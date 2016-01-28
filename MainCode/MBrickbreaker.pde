class Paddle {
  float x;
  float y;
  float Width;
  float Height;

  Paddle() {
    //create paddle
    x = mod_width/2;
    y = mod_height - 75;
    Width = 100;
    Height = 25;
  }

  void display() {
    fill(0, 240, 0);
    rect(x, y, Width, Height);
  }
}

class Ball {
  float x;
  float y;
  float velX;
  float velY;
  float diam; 

  Ball() {
    //create ball
    x = mod_width/2;
    y = mod_height/2; 
    velX = 0; //initial zero in x direction
    velY = 2; 
    diam = 20;
  }

  void display() {
    fill(0, 240, 0);
    ellipse(x, y, diam, diam);
  }

  void run() {
    y = y + velY;
    x = x + velX;
  }

  //Ball goes left
  void goLeft() {
    velX = -3 - random(2); //decrement x
  }

  //Ball goes right
  void goRight() {
    velX = 3 + random(2); //increment x
  }

  //Ball goes up
  void goUp() {
    velY = -4;
  }

  //Ball goes down
  void goDown() {
    velY = 4;
  }

  //If ball goes below paddle, reset
  void reset() {
    x = mod_width/2;
    y = mod_height - 300;
    velX = 0;
    velY = 2;
  }

  boolean collidedWith(float bx, float by, float bwidth, float bheight) {
    return (x - diam/2 <= bx + bwidth && 
      x + diam/2 >= bx &&
      y - diam/2 <= by + bheight &&
      y + diam/2 >= by);
  }
}

class Brick {
  float x;
  float y;
  float Width;
  float Height;

  //hit by ball yes or no 
  boolean hit; 

  Brick(float xinit, float yinit) {
    x = xinit;
    y = yinit;

    Width = mod_width/8;
    Height = 40; 

    //bricks aren't hit initially
    hit = false;
  }

  void display() {
    if(hit) return;
    
    fill(0, 240, 0);
    rect(x, y, Width, Height);
  }

  //What happens to the brick once it gets hit
  void hit() {
    //brick recognizes that it has been hit
    hit = true; 
  }
}

class MBrickbreaker extends Module {
  int rows = 4; //number of bricks per row 
  int columns = 3; //number of columns 
  int i;
  int j;

  Paddle paddle = new Paddle();
  Ball ball = new Ball();
  //2D array for bricks
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

    //collisions with the block
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {

        Brick tbrick = brick[i][j];

        if (!brick[i][j].hit) {

          //bottom side
          if (ball.collidedWith(tbrick.x, tbrick.y + tbrick.Height - 2.5, tbrick.Width, 5)) {
            brick[i][j].hit();
            ball.goDown();
          }

          //top side
          if (ball.collidedWith(tbrick.x, tbrick.y + 2.5, tbrick.Width, 5)) {
            brick[i][j].hit();
            ball.goUp();
          }

          //left side
          if (ball.collidedWith(tbrick.x + 2.5, tbrick.y, 5, tbrick.Height)) {
            brick[i][j].hit();
            ball.goLeft();
          }

          //right side
          if (ball.collidedWith(tbrick.x + tbrick.Width - 2.5, tbrick.y, 5, tbrick.Height)) {
            brick[i][j].hit();
            ball.goRight();
          }
        }

        //if a brick was not hit, make sure the module is not completed
        if (!brick[i][j].hit) {
          nobricks = false;
        }
      }
    }

    //collisions with the left top and right top of the paddle
    if (ball.collidedWith(paddle.x, paddle.y, paddle.Width, paddle.Height)) {
      ball.goUp();

      if (ball.x < paddle.x + (paddle.Width/2))
        ball.goLeft();
      else
        ball.goRight();
    }

    //wall collisions
    if (ball.x + ball.diam / 2 >= mod_width) {
      ball.goLeft();
    }

    if (ball.x - ball.diam / 2 <= 0) {
      ball.goRight();
    }

    if (ball.y - ball.diam / 2 <= 0) {
      ball.goDown();
    }

    if (ball.y  + ball.diam/2 >= mod_height) {
      ball.reset();
      failures++;
    }

    ball.run();

    //if all bricks have been hit, complete module
    if (nobricks) {
      mods_completed++;
      completed = true;
    }

    //move the paddle left and right
    if (keyPressed) {
      if (keyCode == RIGHT) {
        if (paddle.x + paddle.Width < mod_width) {
          paddle.x += 10;
        }
      }

      if (keyCode == LEFT) {
        if (paddle.x > 0) {
          paddle.x -= 10;
        }
      }
    }

    //draw the help popup
    image(hbrickbreaker, width/2, 7*height/8);
  }
}