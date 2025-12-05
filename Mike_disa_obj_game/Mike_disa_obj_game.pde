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


// Create cup object
class Cup {
  //Vectors for doing motion
PVector pos;
  PVector vel;
  PVector acc;

//variables to hold movement data
  float targetX;
  float targetY;
  int index;
  
  boolean lift;
  
  Cup(int idx) {
    index = idx;

    // start each cup at its needed starting position and manages moving it
    pos = new PVector(Spot[idx], 200);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    targetX = pos.x;
    targetY = 200;
    
    lift = false;

    // middle cup starts raised at game start
    if (index == 1 && GameState == 1) {
      pos.y = 100;
    }
  }
  
  //Simplified version for vectors
  void update(int index) {
  if (GameState == 2) {
    int cupX = int(pos.x);
    int cupY = int(pos.y);
    
    // Checks if mouse is within cup hitbox 
    if (mouseX > cupX && mouseX < cupX + 50 && mouseY > cupY && mouseY < cupY + 100) {
      println("Clicked cup " + index);
      shuffling = false;

        //
        targetY = 100;
        lift = true;
        vel.y = 0;
        acc.y = 0;

        //End the game
        GameState = 3;
    }
  }
}
  

//Turns on the animation
  void updateMotion() {

    //drops the cup when game starts
    if (dropping && index == 1) {
      if (pos.y < targetY) {
        acc.y = 0.5;     //Lets the first cup drop
        vel.add(acc);
        pos.add(vel);
        if (pos.y >= targetY) {
          pos.y = targetY;
          vel.set(0, 0);
          acc.set(0, 0);
          dropping = false;
        }
      }
    }
    
    //lifts up a clicked cup
    if (GameState == 3 && lift) {
      if (pos.y > targetY) {
        acc.y = -0.5;     //lifts up the cup
        vel.add(acc);
        pos.add(vel);
        if (pos.y <= targetY) {
          pos.y = targetY;
          vel.set(0, 0);
          acc.set(0, 0);
          lift = false; 
        }
      }
    }

    //moves while shuffling
    if (shuffling) {
      float dx = targetX - pos.x;

      if (abs(dx) > 1) {
       allAtTargets = false;
        vel.x = dx * 0.2;
        pos.x += vel.x;
      } else {
        pos.x = targetX;
        vel.x = 0;
      }
    }
  }

  void display() {
  fill(0, 0, 255);
  rect(pos.x, pos.y, 50, 100);
}
}
