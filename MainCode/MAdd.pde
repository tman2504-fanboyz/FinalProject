class MAdd extends Module {
  int add1, add2;
  String sum;
  String usersum;

  MAdd() {
    add1 = round(random(0, 50));
    add2 = round(random(0, 50));
    sum = trim(str(add1 + add2));

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

    if (usersum.equals(""))
      text("" + add1 + " + " + add2 + " = __", mod_width/2, 2*mod_height/4);
    else
      text("" + add1 + " + " + add2 + " = " + usersum, mod_width/2, 2*mod_height/4);
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
      failures++;
      usersum = "";
    }
    if (sum.equals(usersum)) {
      mods_completed++;
      completed = true;
    }
  }
}