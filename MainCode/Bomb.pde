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

  Bomb(int difficulty) {
    defuse_time = 60.00;

    //initialize the array
    modules = new Module[mod_num];

    //initialize each module
    for (int i = 0; i < mod_num; i++) {
      modules[i] = new Module();
    }

    modules[1] = new MPong();

    modules[10] = new MPong();

    mod_selected = 0;
    mod_is_active = false;
  }

  void display() {
    resetMatrix();

    //view scaling, if there is an active mod, zoom to it's position
    if (mod_is_active) {
      scale(1);

      //center the view on a specific module
      translate(width/2, height/2);

      int ix = mod_selected % mod_per_row;
      int iy = mod_selected / mod_per_row;

      float mwt = mod_width  + (mod_padding*2);
      float mht = mod_height + (mod_padding*2);

      translate(-(ix*mwt + mwt/2), -(iy*mht + mht/2));

      if (!modules[mod_selected].completed)
        modules[mod_selected].run();
    }
    //if not, scale out to see everything
    else {
      scale(0.25);

      //center the bomb in the view
      float bomb_width  = mod_width*mod_per_row;
      float bomb_height = mod_height*(mod_num/mod_per_row);

      translate(width*2 - bomb_width/2, height*2 - bomb_height/2);
    }

    //iterate through the array of modules and draw each
    for (int i = 0; i < mod_num; i++) {
      pushMatrix();

      int ix = i % mod_per_row;
      int iy = i / mod_per_row;

      translate(mod_width*ix+mod_padding*(ix+1), mod_height*iy+mod_padding*(iy));

      if (i == mod_selected) {
        fill(255, 255, 0);
        rect(0, 0, mod_width+(mod_padding*2), mod_height+(mod_padding*2));
      }

      translate(mod_padding, mod_padding);

      if (!modules[i].completed || modules[i].empty)
        modules[i].display();
      else
        modules[i].dispComplete();

      popMatrix();
    }

    resetMatrix();

    //draw the defuse time text
    textSize(32);
    textAlign(LEFT, TOP);

    fill(255, 0, 0);
    text(defuse_time, 10, 10);

    //if all modules are completed, win
    boolean mod_incomplete = false;

    for (Module mod : modules) {
      if (!mod.completed)
        mod_incomplete = true;
    }

    if (!mod_incomplete)
      win();

    //lower the time, and if it's zero, explode
    defuse_time -= 0.01;

    if (defuse_time <= 0)
      explode();
  }

  void explode() {
    game_state = 4;
  }

  void win() {
    game_state = 5;
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

      if (keyCode == LEFT && mod_selected >= mod_per_row)
        mod_selected -= mod_per_row;
      if (keyCode == RIGHT && mod_selected < mod_num-mod_per_row)
        mod_selected += mod_per_row;
    } else {
      //run keypresses for the current module
      modules[mod_selected].keyPress();
    }
  }
}