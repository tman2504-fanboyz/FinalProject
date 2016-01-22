class Module {
  boolean completed;
  boolean empty;
  
  int failures;

  Module() {
    completed = true;
    empty = true;
    
    failures = 0;
  }

  void dispComplete() {
    fill(0, 255, 0);
    rect(0, 0, mod_width, mod_height);

    textSize(32);
    textAlign(CENTER, CENTER);

    fill(255);
    text("COMPLETE!", mod_width/2, mod_height/2);
  }

  void display() {
    fill(100, 100, 100);
    rect(0, 0, mod_width, mod_height);
  }

  void run() {
    return;
  }

  void keyPress() {
    return;
  }
}