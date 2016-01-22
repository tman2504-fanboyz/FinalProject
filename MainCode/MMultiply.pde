class MMultiply extends Module{
int mod_width = 600;
int mod_height = 600;
int multiply1 = round(random(0,99));
int multiply2 = round(random(0,10));
String difference = trim(str(multiply1 * multiply2));
String userdifference = "";
boolean completed;
  
  MMultiply(){
    textAlign(CENTER, CENTER);
    completed = false;
    empty = false;
  }
  
  void display(){
    background(0);
    text("Multiply these numbers: " + multiply1 + " * " + multiply2, mod_width/2, 2*mod_height/4);
    text(" = " + userdifference, mod_width/2, 3*mod_height/4);
  }
  
  //record number
  void keyPressed(){
    //make sure number is only three digits
    if (key >= '0' && key <= '9'){
      userdifference += key;
      if (abs(int(userdifference)) > 999){
        userdifference = userdifference.substring(0, userdifference.length()-1);
      }
    }
    
    //check if multiplied correctly
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