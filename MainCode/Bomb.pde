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

  void display(boolean countdown) {
    resetMatrix();

    //scale the view out if no mod is active
    if (mod_is_active) {
      scale(1);
    } else {
      scale(0.25);
    }

    //center the bomb in the view
    float bomb_width  = (mod_width+mod_padding*2)*mod_per_row;
    float bomb_height = (mod_width+mod_padding*2)*(mod_num/mod_per_row);

    translate(width*2 - bomb_width/2, height*2 - bomb_height/2);

    //center the view on a specific module
    if (mod_is_active) {
      float ix = int(mod_selected % mod_per_row) + 2;
      float iy = int(mod_selected / mod_per_row) + 1.25;

      translate(-mod_width*ix-mod_padding*(ix+1), -mod_height*iy-mod_padding*(iy));
    }

    //draw the bomb casing
    fill(70, 70, 70);
    rect(0, -mod_padding, bomb_width-mod_padding, bomb_height-mod_padding);

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
        mistakes_made += modules[i].failures;

        defuse_time -= modules[i].failures*5;
        modules[i].failures = 0;

        flash_time = flash_time_max;
      }

      popMatrix();
    }

    resetMatrix();

    imageMode(CENTER);

    //run the active module
    if (!modules[mod_selected].completed && mod_is_active)
      modules[mod_selected].run();

    //draw the defuse time text
    textSize(32);
    textAlign(LEFT, TOP);

    fill(255, 0, 0);
    text(nf(defuse_time, 0, 2), 10, 10);

    //fill the screen with red on a failure
    fill(255, 0, 0, (float(flash_time)/float(flash_time_max))*255);
    rect(0, 0, width, height);

    fill(255, 255, 255, (float(flash_time)/float(flash_time_max))*255);

    textSize(128);
    textAlign(CENTER, CENTER);
    text("-5 s", width/2, height/2);
    textSize(32);

    //draw the selection help text
    if (!mod_is_active)
      image(hgame, width/2, 7*height/8);

    //if all mods are completed, call win
    if (!mod_incomplete && countdown)
      win();

    //lower the time, and if it's zero, explode
    if (countdown)
      defuse_time -= 0.01;

    if (defuse_time <= 0)
      explode();

    //lower flash time if it's greater than zero
    if (flash_time > 0)
      flash_time--;
    else
      flash_time = 0;
  }

  //if game is not completed in time
  void explode() {
    game_state = 4;
    menu_key_timer = menu_key_timer_max;
  }
  //if game is completed on time
  void win() {
    game_state = 5;
    title_y = height*4;
    menu_key_timer = menu_key_timer_max;
  }

  //randomize modules based on difficulty
  void randomizeBomb(int difficulty) {
    int num_mod_types = 4;

    int active_modules = int(float(difficulty)/4.0*float(mod_num));
    int created_modules = 0;

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
        //random math 
        int rnd = round(random(100));

        if (rnd > 66) {
          modules[i] = new MAdd();
        } else if (rnd > 33) {
          modules[i] = new MSubtract();
        } else {                       
          modules[i] = new MMultiply();
        }
        break;
      case 3:
        modules[i] = new MBrickbreaker();
        break;
      }

      created_modules++;

      //advance to a new kind of module
      mod_type += random(1, 3);

      if (mod_type >= num_mod_types)
        mod_type = 0;

      //have a chance of skipping the next space
      if (random(100) > 10 && active_modules - created_modules + 1 < mod_num - i)
        i++;
    }
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