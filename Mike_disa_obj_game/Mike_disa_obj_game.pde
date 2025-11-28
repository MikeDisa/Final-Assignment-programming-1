

//Activate object
Cup cup1;

//Standard procedure
void setup(){
  size(400,400);
  cup1 = new Cup();
}

//The visual part
void draw(){
  
  cup1.display();
}


// Create cup object
class Cup {
  
  Cup(){
    
  }
  
  void display() {
    fill(0,0,255);
    rect(200,200,200,200);
  }
}
