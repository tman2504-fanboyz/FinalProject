static final int mod_num = 12;
static final int mod_per_row = 4;

static final int mod_padding = 10;

static final int mod_width = 600;
static final int mod_height = 600;

class Bomb {
  Module[] modules;

  float defuse_time;

  int mod_selected;
  boolean mod_is_active;

  Bomb(float difficulty) {
    defuse_time = 60.00;

    //initialize the array
    modules = new Module[mod_num];

    //initialize each module
    for (int i = 0; i < mod_num; i++) {
      modules[i] = new Module();
    }

    modules[1] = new MPong();

    mod_selected = 0;
    mod_is_active = false;
  }

  void display() {
    resetMatrix();

    //center the bomb
    translate(width/2, height/2);

    //view scaling, if there is an active mod, zoom to it's position
    if (mod_is_active) {
      scale(1);

      int ix = mod_selected % mod_per_row;
      int iy = mod_selected / mod_per_row;

      translate(-mod_width *(ix-1)+mod_padding*(ix)-(mod_width+mod_padding)*1.5, 
        -mod_height*(iy)+mod_padding*(iy)-(mod_width+mod_padding)*0.5);

      modules[mod_selected].run();
    }
    //if not, scale out to see everything
    else {
      scale(0.25);
    }

    //iterate through the array of modules and draw each
    for (int i = 0; i < mod_num; i++) {
      pushMatrix();

      int ix = i % mod_per_row;
      int iy = i / mod_per_row;

      translate(mod_width*ix, mod_width*iy);
      
      if(i == mod_selected){
        fill(255, 255, 0);
        rect(0, 0, mod_width+(mod_padding*2), mod_height+(mod_padding*2));
      }
      
      translate(mod_padding*(ix+1), mod_padding*(iy+1));

      modules[i].display();

      popMatrix();
    }

    resetMatrix();

    //draw the defuse time text
    textSize(32);
    textAlign(LEFT, TOP);

    fill(255, 0, 0);
    text(defuse_time, 10, 10);

    //lower the time, and if it's zero, explode
    defuse_time -= 0.01;

    if (defuse_time <= 0)
      explode();
  }

  void explode() {
    game_state = 4;
  }

  void keyPress() {
    //bomb selecting
    if (keyCode == ENTER)
      mod_is_active = !mod_is_active;

    if (!mod_is_active) {
      //navigate to a new module
      if (keyCode == RIGHT && mod_selected < mod_num-1)
        mod_selected++;
      if (keyCode == LEFT && mod_selected > 0)
        mod_selected--;

      if (keyCode == UP && mod_selected >= mod_per_row)
        mod_selected -= mod_per_row;
      if (keyCode == DOWN && mod_selected < mod_num-mod_per_row)
        mod_selected += mod_per_row;
    } else {
      //run keypresses for the current module
      modules[mod_selected].keyPress();
    }
  }
}