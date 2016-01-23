class MSubtract extends Module {
  int subtract1 = round(random(0, 50));
  int subtract2 = round(random(0, subtract1));
  String difference = trim(str(subtract1 - subtract2));
  String userdifference = "";

  MSubtract() {
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

    if (userdifference.equals(""))
      text("" + subtract1 + " - " + subtract2 + " = __", mod_width/2, 2*mod_height/4);
    else
      text("" + subtract1 + " - " + subtract2 + " = " + userdifference, mod_width/2, 2*mod_height/4);
  }

  //record number
  void keyPress() {
    //make sure number is only two digits
    if (key >= '0' && key <= '9') {
      userdifference += key;
      if (abs(int(userdifference)) > 100) {
        userdifference = userdifference.substring(0, userdifference.length()-1);
      }
    }

    //check if subtracted correctly
    if (!difference.equals(userdifference) && userdifference.length() >= 2) {
      failures++;
      userdifference = "";
    }
    if (difference.equals(userdifference)) {
      completed = true;
    }
  }
}