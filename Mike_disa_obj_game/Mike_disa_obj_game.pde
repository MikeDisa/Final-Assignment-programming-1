//Dealer bits
DealerHandR handR;


int GameState = 1; //Game state tracker. 1=Start, 2=in Progress, 3=end
int Index = 0;
int Moves = 5; //the number of times the cups will be shuffled
boolean Win = false;

//////Image managers///////////
PImage CupSprite;

//Activate object array
Cup[] Cup = new Cup[3];

//Activate location tracking array
int[] Spot = new int[3];

boolean dropping = false; //tracks first falling cup
boolean shuffling = false; //triggers when cups try to move

boolean shuffledOnce = false; //should stop stuff from getting stuck
boolean allAtTargets = false;
////////////////////////////////////////////////////////////////////////
void setup() {
  size(400, 400);
  //dealer stuff
  handR = new DealerHandR(160,2);
  
  // image stuff
  CupSprite = loadImage("RedCup.png");
  
    //Fill the array with location data
  Spot[0] = 100;
  Spot[1] = 200;
  Spot[2] = 300;
  
  //Fill the array with cup objects
  for (int i = 0; i< Cup.length; i++) {
    Cup[i] = new Cup(i);
  }
}
////////////////////////////////////////////////////////////////////////////////

//manages actions that occur when mouse is clicked
void mouseClicked() {
  if (GameState == 1) {
    GameState = 2;
    dropping = true;
    return;
  } 
  if (GameState == 2 && !dropping && !shuffling && !shuffledOnce) {
    // incremental difficulty shuffle once the game is in progress
    for (int i = 0; i < Moves; i++) {
      int a = int(random(3));
      int b = int(random(3));

      while (b == a) {
        b = int(random(3));
      }

      int temp = Spot[a];
      Spot[a] = Spot[b];
      Spot[b] = temp;
    }

    // Tells each cup where it's trying to go
    for (int i = 0; i < Cup.length; i++) {
      Cup[i].targetX = Spot[i];
    }

    shuffling = true;
    shuffledOnce = true;
    return;
  }

  //Check each cup to see if it was clicked, using their animated positions
  if (GameState == 2 && !dropping && !shuffling && shuffledOnce) {
  for (int i = 0; i < Cup.length; i++) {
    Cup[i].update(i);
  }
  if (Index == 1){
      Win = true;
      println("win");
    }
    if ((Index == 0)||(Index == 2)){
      Win = false;
      println("loose");
    }
}
}
//////////////////////////////////////////////////////////////////////////////////
void keyPressed(){
  if ((key == ' ')&&(GameState ==3)){
    println("reset");
  }
}
//////////////////////////////////////////////////////////////////////////////////
//The visual part
void draw() {
  fill(198,198,198);
  rect(0,0,400,400);
  //table////////////////////////////////////
  fill(137,76,11);
  beginShape();
  vertex(400,400);
  vertex(0,400);
  vertex(80,250);
  vertex(320,250);
  endShape();
  
  //ball///////////////////////////////////////////
  fill(224,190,16);
  ellipse(Cup[1].pos.x+20,280,25,25);
  
  ////////////Dealer////////////////////////////
  fill(255,255,255);
  if ((GameState==1)||(GameState==2)){
    handR.update();
  }
  
  ////////////Cups///////////////////////////
  allAtTargets = true;

  //loop to manage all 3 cups
  for (int i=0; i< Cup.length; i++) {
    Index =i; //something to help with troubleshooting
    Cup[i].updateMotion();
    Cup[i].display();
  }
  if (shuffling && allAtTargets) {
    shuffling = false;
  }
}


//Dealer class
//Look familiar? yeah I gutted the train class from train_whistle example
class DealerHandR {
  PVector position;
  PVector velocity;
  int direction;
  
  DealerHandR(float y, float speed) {
    position = new PVector(0, y);
    velocity = new PVector(speed, 0);
    direction = 1;
  }
  void update() {
    //check if the train is at the edge of the screen, if so reverse train direction
    bounce();
    //increase train position in the direction we want
    moveHandR();
    //draw the train:
    drawHandR();
    }
    
     void moveHandR() {
    position.add(velocity.mult(direction));
  }
  
  void bounce() {
    if ( (position.x + 50) >= width || position.x < 0) {
      direction = direction * -1;
    }
  }
  void drawHandR(){
    fill(255,255,255);
    rect(position.x, position.y + 20, 50, 20);
  }
  }
  
