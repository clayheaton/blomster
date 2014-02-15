class Sector {
  PVector position;
  float wSec, hSec;
  boolean dummy, bigsec, flowerMade;
  
  color fillColor;

  Flower flower;

  Sector(float xPosTemp, float yPosTemp, float wTemp, float hTemp) {
    position = new PVector(xPosTemp, yPosTemp);
    wSec = wTemp;
    hSec = hTemp;
    dummy = false;
    bigsec = false;
    flowerMade = false;
  }

  void makeFlower() {
    flowerMade = false;
    flower = new Flower(position, wSec, hSec); 
    flowerMade = true;
  }

  void display() {
    debugDisplay();
    if(!dummy){
      flower.display();
    }
  }

  void debugDisplay() {
    // Debugging assists at the SECTOR LEVEL ONLY
    if (debugSector) {
      noFill();
      if (bigsec) {
        fill(240);
      }

      if (!dummy) {
        stroke(200);
        strokeWeight(1);
        pushMatrix();
        translate(position.x, position.y);
        rect(0, 0, wSec, hSec);
        popMatrix();
      }
    }
  }
}

