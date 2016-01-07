static final int MOD_NUM = 12;

class Bomb{
  Module[] modules;
  
  float defuse_time;
  
  Bomb(float difficulty){
    defuse_time = 10.00;
    
    modules = new Module[MOD_NUM];
    
    for(Module module : modules){
        module = new Module();
    }
  }
  
  void display(){
    defuse_time -= 0.01;
    
    textSize(32);
    textAlign(LEFT, TOP);
    
    fill(255, 0, 0);
    text(defuse_time, 10, 10);
    
    for(Module module : modules){
        module.display();
    }
    
    if(defuse_time <= 0)
      explode();
  }
  
  void explode(){
    game_state = 4;
  }
}