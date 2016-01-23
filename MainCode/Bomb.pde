static final int mod_num = 12;
static final int mod_per_row = 4;

static final int mod_padding = 10;

static final int mod_width = 600;
static final int mod_height = 600;

class Bomb {
  Module[] modules;

  float defuse_time;

  int flash_time;
  int flash_time_max;

  int mod_selected;
  boolean mod_is_active;

  Bomb(int difficulty) {
    //once this hits 0, the game is terminated
    defuse_time = 90.00;

    //timing for the failure flash, make sure it's not too low
    flash_time_max = 50;
    flash_time = 0;

    //initialize the array
    modules = new Module[mod_num];

    //initialize each module
    for (int i = 0; i < mod_num; i++) {
      modules[i] = new Module();
    }

    randomizeBomb(difficulty);

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

    //checking if all mods are complete
    boolean mod_incomplete = false;

    //iterate through the array of modules and draw each
    for (int i = 0; i < mod_num; i++) {
      pushMatrix();

      int ix = i % mod_per_row;
      int iy = i / mod_per_row;

      translate(mod_width*ix+mod_padding*(ix+1), mod_height*iy+mod_padding*(iy));

      //draw a yellow highlight if selected
      if (i == mod_selected) {
        fill(255, 255, 0);
        rect(0, 0, mod_width+(mod_padding*2), mod_height+(mod_padding*2));
      }

      translate(mod_padding, mod_padding);

      //draw the module
      if (!modules[i].completed || modules[i].empty)
        modules[i].display();
      else
        modules[i].dispComplete();

      //see if it is completed
      if (!modules[i].completed)
        mod_incomplete = true;

      //add to failure time and subtract from defuse time for failures
      if (modules[i].failures > 0) {
        defuse_time -= modules[i].failures*10;
        modules[i].failures = 0;

        flash_time = flash_time_max;
      }

      popMatrix();
    }

    resetMatrix();

    //draw the defuse time text
    textSize(32);
    textAlign(LEFT, TOP);

    fill(255, 0, 0);
    text(defuse_time, 10, 10);

    //fill the screen with red on a failure
    fill(255, 0, 0, (float(flash_time)/float(flash_time_max))*255);
    rect(0, 0, width, height);

    //if all mods are completed, call win
    if (!mod_incomplete)
      win();

    //lower the time, and if it's zero, explode
    defuse_time -= 0.01;

    if (defuse_time <= 0)
      explode();

    //lower flash time if it's greater than zero
    if (flash_time > 0)
      flash_time--;
    else
      flash_time = 0;
  }

  void explode() {
    game_state = 4;
    menu_key_timer = menu_key_timer_max;
  }
  void win() {
    game_state = 5;
    menu_key_timer = menu_key_timer_max;
  }

  void randomizeBomb(int difficulty) {
    int active_modules = int(float(difficulty)/4.0*float(mod_num));
    int created_modules = 0;

    int num_mod_types = 5;
    int mod_type = int(random(0, num_mod_types));

    //for every module slot,
    for (int i = 0; created_modules < active_modules; i++) {

      //add a new module based on mod_type
      switch(mod_type) {
      case 0: 
        modules[i] = new MPong(); 
        break;
      case 1: 
        modules[i] = new MFrogger(); 
        break;
      case 2: 
        modules[i] = new MAdd(); 
        break;
      case 3: 
        modules[i] = new MSubtract(); 
        break;
      case 4: 
        modules[i] = new MMultiply(); 
        break;
      }

      created_modules++;

      //go to the next kind of module, with a chance of skipping
      mod_type += random(1, 3);

      if (mod_type >= num_mod_types)
        mod_type = 0;

      //have a chance of skipping the next space
      if (random(100) > 50 && active_modules - created_modules + 1 < mod_num - i)
        i++;
    }
    
    println(created_modules == active_modules);
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