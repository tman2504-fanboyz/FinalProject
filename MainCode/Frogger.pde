class Frogger extends Module {
  //creates frog, car, car1, pos variables
  //Dan, get rid of car1 if we don't need it (and we shouldn't anymore)
  int width;
  PImage frog;
  PImage car, car1;
  PVector pos;
  PVector[] cars;

  Frogger() {
    fill(100, 100, 100);
    rect(0, 0, mod_width, mod_height);
    size (600, 600);
    width = 600;
    
    //created position vector for frog
    pos = new PVector(268, 550);
    
    //loads images used in game
    frog = loadImage("Frogger_sprite.png");
    car = loadImage("SimpleYellowCarTopView.png");
    car1 = loadImage("SimpleYellowCarTopView.png");
    
    //creates array of cars
    cars = new PVector[8];
    for (int i = 0; i < 8; i++) {
      cars[i] = new PVector(random(0, width), 490-(i*60));
    }
  }
    completed = false;
  }

  void display() {
    fill(100, 100, 100);
    rect(0, 0, mod_width, mod_height);
  }

  void run() {
    background(0);
    
    //draws lanes and grass
    fill(0, 0, 0);
    rect(0, 60, width, 480);
    fill(0, 255, 0);
    rect(0, 0, width, 60);
    rect(0, 540, width, 60);
    
    //places frog image in program
    image(frog, pos.x, pos.y);
    
    //creates if-statements such that frog cannot move beyond boundaries
    if (pos.x > width-68) {
      pos.x = width-68;
    }
    if (pos.x < 0) {
      pos.x = 0;
    }
    if (pos.y > height) {
      pos.y = height-50;
    }
    if (pos.y < 0) {
      pos.y = 0;
    }
    
    //places cars in program, gives them velocity, and resets cars after leaving screen
    for (int i = 0; i < 8; i++) {
      image(car, cars[i].x, cars[i].y);
      cars[i].x += 7.5;
      if (cars[i].x > width) {
        cars[i].x = -100;
      }
      if (dist(cars[i].x, cars[i].y, pos.x, pos.y) <= 32){
        setup();
    }
    }

  }

  void keyPress() {
    image(frog, pos.x, pos.y);
    
    //creates movement of frog through usage of arrow keys
    if (key == CODED) {
      if (keyCode == UP) {
        pos.y = pos.y-60;
      }
      if (keyCode == DOWN) {
        pos.y = pos.y+60;
      }
      if (keyCode == RIGHT) {
        pos.x = pos.x+60;
      }
      if (keyCode == LEFT) {
        pos.x = pos.x-60;
      }
    }
  }