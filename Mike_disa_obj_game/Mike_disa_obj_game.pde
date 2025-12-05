int GameState = 1; //Gmae state tracker. 1=Start, 2=in Progress, 3=end
int Index = 0;

//Activate object array
Cup[] Cup = new Cup[3];

//Activate location tracking array
int[] Spot = new int[3];

//Standard procedure
void setup() {
  size(400, 400);
  //Fill the array with cup objects
  for (int i = 0; i< Cup.length; i++) {
    Cup[i] = new Cup();
  }
  //Fill the array with location data
  Spot[0] = 100;
  Spot[1] = 200;
  Spot[2] = 300;
}

//adding in mouse action, Just drops raised cup
void mouseClicked() {
  if (GameState == 1){
    GameState = 2;
  }
  //Check each cup to see if it was clicked
  for (int i = 0; i < Cup.length; i++){
    Cup[i].update(i);
  }
}

//The visual part
void draw() {
  fill(198,198,198);
  rect(0,0,400,400);

  //loop to manage all 3 cups
  for (int i=0; i< Cup.length; i++) {
    Index =i; //something to help with troubleshooting
    Cup[i].display();
  }
}


// Create cup object
class Cup {

  Cup() { //A constructor of the same name to be used for some reason
  }
  
  void update(int index){
    //Check each cup to see if it was clicked
  if (GameState == 2)  {

    int cupX = Spot[index]; //switched to variables
    int cupY;

    //revised version of cup raiser using variables
    if (GameState == 1 && index == 1) {
      cupY = 100;
    } else {
      cupY = 200;
    }

    //if mouse is within cup dimensions, register a click
    if (mouseX > cupX && mouseX < cupX + 50 && mouseY > cupY && mouseY < cupY + 100) {

      println("Clicked cup " + index);
    }
  }
}
  



  void display() {
    fill(0, 0, 255);
    //At the start of the game the middle cup starts up.
    if (GameState == 1&&Index==1) {
      rect(Spot[Index], 100, 50, 100);
    } else {
      rect(Spot[Index], 200, 50, 100);
    }
    //println("Cup "+Index);//something to help with troubleshooting
  }
}
