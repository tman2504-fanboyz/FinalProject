class MMultiply extends Module {
  int multiply1 = round(random(0, 99));
  int multiply2 = round(random(0, 10));
  String product = trim(str(multiply1 * multiply2));
  String userproduct = "";

  MMultiply() {
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

    //place "___" if user has not entered anything
    if (userproduct.equals(""))
      text("" + multiply1 + " * " + multiply2 + " = ___", mod_width/2, 2*mod_height/4);
    //remove "___" if user has entered something
    else
      text("" + multiply1 + " * " + multiply2 + " = " + userproduct, mod_width/2, 2*mod_height/4);
  }

  void run() {
    //draw the help popup
    image(hmath, width/2, 7*height/8);
  }

  //record number
  void keyPress() {
    //make sure number is only three digits
    if (key >= '0' && key <= '9') {
      userproduct += key;
      if (abs(int(userproduct)) > 999) {
        userproduct = userproduct.substring(0, userproduct.length()-1);
      }
    }

    //check if multiplied correctly
    if (!product.equals(userproduct) && userproduct.length() >= 3) {
      failures++;
      userproduct = "";
    }
    if (product.equals(userproduct)) {
      mods_completed++;
      completed = true;
    }
  }
}