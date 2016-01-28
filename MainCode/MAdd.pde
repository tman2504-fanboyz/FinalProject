class MAdd extends Module {
  int add1, add2;
  String sum;
  String usersum;

  MAdd() {
    //choose two integers
    add1 = round(random(0, 50));
    add2 = round(random(0, 50));
    sum = trim(str(add1 + add2));

    //string to store user submission
    usersum = "";

    completed = false;
    empty = false;
  }

  void display() {
    fill(100, 100, 100);
    rect(0, 0, mod_width, mod_height);

    fill(0);
    rect(mod_width/4, mod_height/3, mod_width - mod_width/4, mod_height - mod_height/3);

    fill(0, 240, 0);
    textAlign(CENTER, CENTER);

    //test if usersum is empty
    if (usersum.equals(""))
      //add "__" if no response has been entered
      text("" + add1 + " + " + add2 + " = __", mod_width/2, 2*mod_height/4);
    else
      //only display number if response has been entered
      text("" + add1 + " + " + add2 + " = " + usersum, mod_width/2, 2*mod_height/4);
  }

  void run() {
    //draw the help popup
    image(hmath, width/2, 7*height/8);
  }

  //record number
  void keyPress() {
    //make sure number is only two digits
    if (key >= '0' && key <= '9') {
      usersum += key;
      if (abs(int(usersum)) > 100) {
        usersum = usersum.substring(0, usersum.length()-1);
      }
    }

    //check if added correctly
    if (!sum.equals(usersum) && usersum.length() >= 2) {
      //not added correctly
      failures++;
      usersum = "";
    }
    if (sum.equals(usersum)) {
      //added correctly
      mods_completed++;
      completed = true;
    }
  }
}