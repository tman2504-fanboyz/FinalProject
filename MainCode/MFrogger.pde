class MFrogger extends Module {
  //creates frog, car, pos variables
 
  
  int frog_x, frog_y;

  
  PVector[] cars;

  int frog_size = 60;
  float car_speed = 0.04;

  int press_delay;

  MFrogger() {

    //created position for frog
    frog_x = mod_width/frog_size/2;
    frog_y = mod_height/frog_size - 1;

    //creates array of cars
    cars = new PVector[8];

    //place cars into rows
    for (int i = 0; i < 8; i++) {
      cars[i] = new PVector(round(random(0, mod_width/frog_size - 2)), i + 1);
    }

    completed = false;
    empty = false;
  }

  void display() {
    imageMode(CORNER);

    fill(0);
    rect(0, 0, mod_width, mod_height);

    //draw grass
    fill(0, 255, 0);

    rect(0, 0, mod_width, frog_size);
    rect(0, mod_height-frog_size, mod_width, mod_height);

    //places frog image in program
    image(frog, frog_x*frog_size, frog_y*frog_size);

    //places cars in program
    for (int i = 0; i < 8; i++) {
      image(car, cars[i].x*frog_size, cars[i].y*frog_size);
    }
  }

  void run() {
    //gives cars velocity, and resets cars after leaving screen
    for (int i = 0; i < 8; i++) {
      cars[i].x += car_speed;

      if (cars[i].x + 2 > mod_width/frog_size) {
        cars[i].x = 0;
      }

      //if the car hit the frog, fail
      if ((frog_x == round(cars[i].x) && frog_y == round(cars[i].y)) ||
        (frog_x == round(cars[i].x)+1 && frog_y == round(cars[i].y))) {
        failures++;
        frog_x = mod_width/frog_size/2;
        frog_y = mod_height/frog_size - 1;
        press_delay = 50;
      }
    }

    //win if the frog made it to the end
    if (frog_y == 0) {
      mods_completed++;
      completed = true;
    }

    //tick down press delay if it is > 0
    if (press_delay > 0)
      press_delay--;
    else if (press_delay < 0)
      press_delay = 0;

    //draw the help popup
    image(hfrogger, width/2, 7*height/8);
  }

  void keyPress() {
    if (press_delay > 0) return;

    //creates movement of frog through usage of arrow keys
    if (keyCode == UP && frog_y > 0) {
      frog_y--;
    }
    if (keyCode == DOWN && frog_y < mod_height/frog_size - 1) {
      frog_y++;
    }
    if (keyCode == RIGHT && frog_x < mod_width/frog_size - 1) {
      frog_x++;
    }
    if (keyCode == LEFT && frog_x > 0) {
      frog_x--;
    }
  }
}