int Spot1 = 200;
int Spot2 = 100;
int Spot3 = 300;

//Activate object array
Cup[] Cup = new Cup[3];

//Standard procedure
void setup(){
  size(400,400);
  for (int i = 0; i< Cup.length; i++){
  Cup[i] = new Cup();
  }
}

//The visual part
void draw(){
  
  Cup[1].display();
}


// Create cup object
class Cup {
  
  Cup(){
    
  }
  
  void display() {
    fill(0,0,255);
    rect(200,200,50,100);
  }
}
