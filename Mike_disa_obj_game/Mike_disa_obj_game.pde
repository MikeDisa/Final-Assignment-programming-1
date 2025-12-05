int GameState = 1; //Game state tracker. 1=Start, 2=in Progress, 3=end
int Index = 0;
int Moves = 5; //the number of times the cups will be shuffled

//Activate object array
Cup[] Cup = new Cup[3];

//Activate location tracking array
int[] Spot = new int[3];

boolean dropping = false; //tracks first falling cup
boolean shuffling = false; //triggers when cups try to move

boolean shuffledOnce = false; //should stop stuff from getting stuck
boolean allAtTargets = false;
////////////////////////////////////////////////////////////////////////
//Standard procedure
void setup() {
  size(400, 400);
  
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
}
}

//////////////////////////////////////////////////////////////////////////////////
//The visual part
void draw() {
  fill(198,198,198);
  rect(0,0,400,400);
  
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
