class MAdd extends Module{
int mod_width = 600;
int mod_height = 600;
int add1 = round(random(0,50));
int add2 = round(random(0,50));
String sum = trim(str(add1 + add2));
String usersum = "";
boolean completed;
  
  MAdd(){
    textAlign(CENTER, CENTER);
    completed = false;
    empty = false;
  }
  
  void display(){
    background(0);
    text("Add these numbers: " + add1 + " + " + add2, mod_width/2, 2*mod_height/4);
    text(" = " + usersum, mod_width/2, 3*mod_height/4);
  }
  
  //record number
  void keyPressed(){
    //make sure number is only two digits
    if (key >= '0' && key <= '9'){
      usersum += key;
      if (abs(int(usersum)) > 100){
        usersum = usersum.substring(0, usersum.length()-1);
      }
    }
    
    //check if added correctly
    if (key == ENTER || key == RETURN){
      if (!sum.equals(usersum)){
        //flash red and penalize player
        usersum = "";
      }
      if (sum.equals(usersum)){
        completed = true;
        println(true);
      }
    }
  }
}