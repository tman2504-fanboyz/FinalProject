class MPong extends Module{
  float paddleX = 0;
  float paddleY = mod_height/2;
  float paddleWidth = 50;
  float paddleHeight = 200;
  float gap = 10;
  float wall_width = 50;
  float wally1 = random(mod_height - 200);
  float wally2 = wally1 + gap;
  float ballX = mod_width/2;
  float ballY = mod_height/2;
  float xSpeed = 1;
  float ySpeed = 1;
  float diam = 50;
  
   MPong(){
      rectMode(CORNERS);
      completed = false;
   }
   
   void display(){
      background(255);
      fill(0);
      
      //player paddle
      rect(paddleX, paddleY, paddleX + paddleWidth, paddleY + paddleHeight);
      
      //random walls
      rect(mod_width - wall_width, wally1, mod_width, 0);
      rect(mod_width - wall_width, mod_height, mod_width, wally2);
      
      //ball
      ellipse(ballX, ballY, diam, diam);    
      ballY = ballY - ySpeed;
      ballX = ballX - xSpeed;
      
      //top and bottom limits
      if (ballY <= 0 || ballY >= height) {
        ySpeed = -ySpeed;
      }
      
      //right limits
      if (ballX >= mod_width - 50){
        if (ballY <= wally1 || ballY >= wally2){
          xSpeed = -abs(xSpeed);
        }
        else {
          completed = true;
        }
      }
      
      //left limit
      if (ballX <=0){
        float ballX = mod_width/2;
        float ballY = mod_height/2;
      }
      
      
      //move Paddle
      if (keyPressed) { //move left paddle
        if (keyCode == UP && (paddleY) > 0) {//move left paddle up
            paddleY = paddleY - 20;
        }
        if (keyCode == DOWN && (paddleY + paddleHeight) < height) { //move left paddle down
            paddleY = paddleY + 20;
        }
      }
 
   }
}