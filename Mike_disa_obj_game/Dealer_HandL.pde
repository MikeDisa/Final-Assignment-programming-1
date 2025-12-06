//Look familiar? yeah I gutted the train class from train_whistle example
class DealerHandL {
  PVector position;
  PVector velocity;
  int direction;
  
  DealerHandL(float x, float speed) {
    position = new PVector(x,180);
    velocity = new PVector(0,speed);
    direction = 1;
  }
  void update() {
    //check if the train is at the edge of the screen, if so reverse train direction
    bounce();
    //increase train position in the direction we want
    moveHandL();
    //draw the train:
    drawHandL();
    }
    
     void moveHandL() {
    position.add(velocity.mult(direction));
  }
  
  void bounce() {
    if ( (position.y) >= 240 || position.y < 140) {
      direction = direction * -1;
    }
  }
  void drawHandL(){
    fill(255,255,255);
    image(HandL,position.x +100, position.y-200);
  }
  }
