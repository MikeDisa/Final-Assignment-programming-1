
//Look familiar? yeah I gutted the train class from train_whistle example
class DealerHandR {
  PVector position;
  PVector velocity;
  int direction;
  
  DealerHandR(float x, float speed) {
    position = new PVector(x,180);
    velocity = new PVector(0,speed);
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
    if ( (position.y) >= 240 || position.y < 140) {
      direction = direction * -1;
    }
  }
  void drawHandR(){
    fill(255,255,255);
    rect(position.x -100, position.y, 50, 20);
  }
  }
  
