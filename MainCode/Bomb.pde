static final int mod_num = 12;
static final int mod_per_row = 4;

static final int mod_padding = 10;

static final int mod_width = 600;
static final int mod_height = 600;

class Bomb {
  Module[] modules;

  float defuse_time;
  
  int mod_active;

  Bomb(float difficulty) {
    defuse_time = 60.00;

    //initialize the array
    modules = new Module[mod_num];
    
    //initialize each module
    for (int i = 0; i < mod_num; i++) {
      modules[i] = new Module();
    }
    
    mod_active = 0;
  }

  void display() {
    resetMatrix();
    
    //view scaling, if there is an active mod, zoom to it
    if(mod_active >= 0){
      scale(1);
      
      int ix = mod_active % mod_per_row;
      int iy = mod_active / mod_per_row;
      
      translate(-mod_width *(ix-1)+mod_padding*(ix)-(mod_width+mod_padding)/2, 
                -mod_height*(iy)+mod_padding*(iy)+(mod_height)/2);
                
      modules[mod_active].run();
    }
    //if not, scale out to see everything
    else{
      scale(0.25);
    }
    
    //iterate through the array of modules and draw each
    for (int i = 0; i < mod_num; i++) {
      pushMatrix();
      
      int ix = i % mod_per_row;
      int iy = i / mod_per_row;
      
      translate(mod_width*ix+mod_padding*(ix+1), mod_width*iy+mod_padding*(iy+1));
      
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
  
  void keyPress(){
     if(keyCode == ENTER)
       mod_active = -1;
  }
  
  void mousePress(){
    if(mod_active == -1){
       int ix = int(mouseX/((mod_width +mod_padding)*0.25));
       int iy = int(mouseY/((mod_height+mod_padding)*0.25));
       
       mod_active = ix*iy;
       
       println(mod_active);
    }
  }
}