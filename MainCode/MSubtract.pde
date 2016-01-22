class MSubtract extends Module{
int mod_width = 600;
int mod_height = 600;
int subtract1 = round(random(0,50));
int subtract2 = round(random(0,subtract1));
String difference = trim(str(subtract1 - subtract2));
String userdifference = "";
boolean completed;
  
  MSubtract(){
    textAlign(CENTER, CENTER);
    completed = false;
    empty = false;
  }
  
  void display(){
    background(0);
    text("Subtract these numbers: " + subtract1 + " - " + subtract2, mod_width/2, 2*mod_height/4);
    text(" = " + userdifference, mod_width/2, 3*mod_height/4);
  }
  
  //record number
  void keyPressed(){
    //make sure number is only two digits
    if (key >= '0' && key <= '9'){
      userdifference += key;
      if (abs(int(userdifference)) > 100){
        userdifference = userdifference.substring(0, userdifference.length()-1);
      }
    }
    
    //check if subtracted correctly
    if (key == ENTER || key == RETURN){
      if (!difference.equals(userdifference)){
        //flash red and penalize player
        userdifference = "";
      }
      if (difference.equals(userdifference)){
        completed = true;
        println(true);
      }
    }
  }
}