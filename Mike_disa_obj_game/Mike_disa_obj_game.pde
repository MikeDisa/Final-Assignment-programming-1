//Dealer bits
DealerHandR handR;

int selectedCup;
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
  if (GameState == 3 && selectedCup != -1) {
    float handX = Cup[selectedCup].pos.x;
    float handY = Cup[selectedCup].pos.y - 12;

    fill(255);           
    rect(handX, handY, 50, 10);
  }
}
