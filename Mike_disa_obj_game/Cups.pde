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
  image(CupSprite,pos.x, pos.y, 50, 100);
}
}
