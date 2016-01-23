int rows = 4; //number of bricks per row 
int columns = 3; //number of columns 
int i;
int j;

Paddle paddle = new Paddle();
Ball ball = new Ball();
Brick[][] brick = new Brick[rows][columns];

void setup() {
  size(600, 600); 
  background(0);

  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < columns; j++)
    {
      brick[i][j] = new Brick((i+1) * width/(rows + 2), (j+1) * 50); //places all the bricks into the array, properly labelled
    }
  }
}

void draw() {
  background(0);
    
    for (int i = 0; i < rows; i++){
    for (int j = 0; j < columns; j++){
      brick[i][j].update();
      }
    }  

  paddle.update();
  ball.update();
    for (int i = 0; i < rows; i++){
    for (int j = 0; j < columns; j++){
    if (ball.ballY - ball.diam/2 <= brick[i][j].brickY + brick[i][j].brickHeight &&  ball.ballY - ball.diam/2 >= brick[i][j].brickY && ball.ballX >= brick[i][j].brickX && ball.ballX <= brick[i][j].brickX + brick[i][j].brickWidth  && brick[i][j].hit == false){
      ball.changeY();
      brick[i][j].hit();
    }
 
    //If ball hits top of brick ball moves up
    if (ball.ballY + ball.diam/2 >= brick[i][j].brickY && ball.ballY - ball.diam <= brick[i][j].brickY + brick[i][j].brickHeight/2 && ball.ballX >= brick[i][j].brickX&& ball.ballX <= brick[i][j].brickX+ brick[i][j].brickWidth && brick[i][j].hit == false ){
      ball.changeY();
      brick[i][j].hit();
    }
 
    //if ball hits the left of the brick, ball switches to the right, and moves in same direction
    if (ball.ballX + ball.diam/2 >= brick[i][j].brickX && ball.ballX + ball.diam/2 <= brick[i][j].brickX+ brick[i][j].brickWidth / 2 && ball.ballY >= brick[i][j].brickY && ball.ballY <= brick[i][j].brickY + brick[i][j].brickHeight  && brick[i][j].hit == false){
      ball.goLeft();
      brick[i][j].hit();
    }
 
    //if ball hits the right of the brick, ball switches to the left, and moves in same direction
    if (ball.ballX - ball.diam/2 <= brick[i][j].brickX + brick[i][j].brickWidth && ball.ballX +ball.diam/2 >= brick[i][j].brickX+ brick[i][j].brickWidth/2 && ball.ballY >= brick[i][j].brickY && ball.ballY <= brick[i][j].brickY + brick[i][j].brickHeight  && brick[i][j].hit == false){
      ball.goRight();
      brick[i][j].hit();
    }
    }
    }
  if (ball.ballY == paddle.paddleY && ball.ballX > paddle.paddleX && ball.ballX <= paddle.paddleX + (paddle.paddleWidth / 2) ){
    ball.goLeft();
    ball.changeY();
  }

  if (ball.ballY == paddle.paddleY && ball.ballX > paddle.paddleX + (paddle.paddleWidth/2) && ball.ballX <= paddle.paddleX + paddle.paddleWidth){
    ball.goRight();
    ball.changeY();
  }

  if (ball.ballX + ball.diam / 2 >= width){
    ball.goLeft();
  }

  if (ball.ballX - ball.diam / 2 <= 0){
    ball.goRight();
  }

  if (ball.ballY - ball.diam / 2 <= 0){
    ball.changeY();
  }

  if (ball.ballY > height){
    ball.reset();
  }
  
if (keyPressed){
 if(keyCode == RIGHT){
   if(paddle.paddleX + paddle.paddleWidth < width){
   paddle.paddleX += 10; 
   }
 }
 
 if(keyCode == LEFT){
 if(paddle.paddleX > 0){
   paddle.paddleX -= 10;
     }
   }
  }
}


class Paddle {
  float paddleX;
  float paddleY;
  float paddleWidth;
  float paddleHeight;

  Paddle() {
    paddleX = width/2;
    paddleY = height + 400;
    paddleWidth = 200;
    paddleHeight = 50;
  }

  void update(){
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
    ballY = paddle.paddleY - 100; 
    velX = 0; //initial zero in x direction
    velY = 4; 
    diam = 20;
  }


  void update() {
    noStroke();
    fill(255);
    ellipse(ballX, ballY, diam, diam);

    ballY = ballY + velY;
    ballX = ballX + velX;
  }
  
  //Ball goes left
  void goLeft()
  {
    velX = -4; //decrement x
  }

  //Ball goes right
  void goRight()
  {
    velX = 4; //increment x
  }

  //Ball changes in y direction
  void changeY()
  {
    velY *= -1;
  }

  //If ball goes below paddle, reset
  void reset()
  {
    ballX = width/2;
    ballY = height/5;
    velX = 0;
    velY = 4;
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

    brickWidth = width/8;
    brickHeight = 40; 

//bricks aren't hit initially
    hit = false; 
  }

  void update(){
    noStroke();
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
    rect(brickX, brickY, brickWidth, brickHeight);
  }
}