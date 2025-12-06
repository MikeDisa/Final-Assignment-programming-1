//Dealer bits
DealerHandR handR;
DealerHandL handL;
int selectedCup = -1;
int GameState = 1; //Game state tracker. 1=Start, 2=in Progress, 3=end
int Index = 0;
int Moves = 5; //the number of times the cups will be shuffled
boolean Win = false;

//////Image managers///////////
PImage CupSprite;
PImage HandR;
PImage HandRLift;
PImage HandL;
PImage Dealer;
PImage Dealer2;
PImage Dealerbreak;
PImage Ball;
PImage table;

//Activate object array
Cup[] Cups = new Cup[3];

//Activate location tracking array
int[] Spot = new int[3];

boolean dropping = false; //tracks first falling cup
boolean shuffling = false; //triggers when cups try to move

boolean shuffledOnce = false; //should stop stuff from getting stuck
boolean allAtTargets = false;
////////////////////////////////////////////////////////////////////////
void setup() {
  size(400, 400);
  println("Press SPACE to reset");
  //dealer stuff
  handR = new DealerHandR(160,2);
  handL = new DealerHandL(170,1.5);
  
  // image stuff
  CupSprite = loadImage("RedCup.png");
  HandR = loadImage("handR.png");
  HandRLift = loadImage("hand2.png");
  HandL = loadImage ("handL.png");
  Dealer = loadImage ("Dealer1.png");
  Dealer2 = loadImage ("Dealer2.png");
  Dealerbreak = loadImage ("DealerBreak2.png");
  Ball = loadImage ("GoldBall.png");
  table = loadImage ("table.png");

    //Fill the array with location data
  Spot[0] = 80;
  Spot[1] = 180;
  Spot[2] = 280;
  
  //Fill the array with cup objects
  for (int i = 0; i< Cups.length; i++) {
    Cups[i] = new Cup(i);
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
    for (int i = 0; i < Cups.length; i++) {
      Cups[i].targetX = Spot[i];
    }

    shuffledOnce = true;
    return;
  }

  //Check each cup to see if it was clicked, using their animated positions
  if (GameState == 2 && !dropping && !shuffling && shuffledOnce) {
  for (int i = 0; i < Cups.length; i++) {
    Cups[i].update(i);
  }
}
}
//////////////////////////////////////////////////////////////////////////////////
void keyPressed(){
  if (key == ' ' && GameState == 3) {
    println("reset");

    // reset game state
    GameState = 1;
    Win = false;
    selectedCup = -1;

    dropping = false;
    shuffling = false;
    shuffledOnce = false;
    allAtTargets = false;

    // reset cup locations array
    Spot[0] = 80;
    Spot[1] = 180;
    Spot[2] = 280;

    // reset cups
    for (int i = 0; i < Cups.length; i++) {
      Cups[i].pos.x = Spot[i];
      Cups[i].pos.y = 200;
      Cups[i].vel.set(0, 0);
      Cups[i].acc.set(0, 0);
      Cups[i].targetX = Spot[i];
      Cups[i].targetY = 200;
      Cups[i].lift = false;
    }
    // reset raised cup
    Cups[1].pos.y = 100;

    // reset dealer hands
    handR = new DealerHandR(160, 2);
    handL = new DealerHandL(170, 1.5);
  }
}
//////////////////////////////////////////////////////////////////////////////////
//The visual part
void draw() {
  fill(64,64,64);
  rect(0,0,400,400);
  
  //table////////////////////////////////////
  image(table,0,0);
  
  //ball///////////////////////////////////////////
  fill(224,190,16);
  image(Ball,Cups[1].pos.x +20,240);
  
  ////////////Dealer////////////////////////////
  if ((GameState==1)||(GameState==2)){
    image(Dealer,0,0);
  }
  if ((GameState==3)&&(!Win)){
    image(Dealer2,0,0);
  }
 if ((GameState==3)&&(Win)){
    image(Dealerbreak,10,10,350,350);
  }
  if ((GameState==1)||(GameState==2)){
    handR.update();
  }
  if (!Win){
    handL.update();
  }
  
  ////////////Cups///////////////////////////
  allAtTargets = true;

  //loop to manage all 3 cups
  for (int i=0; i< Cups.length; i++) {
    Index =i; //something to help with troubleshooting
    Cups[i].updateMotion();
    Cups[i].display();
  }
  if (shuffling && allAtTargets) {
    shuffling = false;
  }
  if (GameState == 3 && selectedCup != -1) {
    Cup c = Cups[selectedCup];
    float cupWidth = 50;
    float handX = c.pos.x + cupWidth / 2;
    float handY = c.pos.y + 10;

    fill(255);           
    image(HandRLift,handX-50, handY-100);
  }
}
