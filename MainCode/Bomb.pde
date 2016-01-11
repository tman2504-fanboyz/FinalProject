static final int mod_num = 12;
static final int mod_per_row = 4;

static final int mod_width = 600;
static final int mod_height = 600;

class Bomb {
  Module[] modules;

  float defuse_time;

  Bomb(float difficulty) {
    defuse_time = 10.00;

    //initialize the array
    modules = new Module[mod_num];
    
    //initialize each module
    for (int i = 0; i < mod_num; i++) {
      modules[i] = new Module();
    }
  }

  void display() {
    //set the view, scale out too see everything
    scale(1);
    
    //iterate through the array of modules and draw each
    for (int i = 0; i < mod_num; i++) {
      pushMatrix();
      
      translate(mod_width*(i % mod_per_row), 0);
      
      modules[i].display();
      
      popMatrix();
    }

    //draw the defuse time text
    textSize(32);
    textAlign(LEFT, TOP);

    fill(255, 0, 0);
    text(defuse_time, 10, 10);
    
    //lower the time
    defuse_time -= 0.01;

    //time is zero, explode
    if (defuse_time <= 0)
      explode();
  }

  void explode() {
    game_state = 4;
  }
}