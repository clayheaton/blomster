class Sector {
  PVector position;
  float wSec, hSec;
  int xCoord, yCoord;
  float secScale;
  boolean dummy, bigsec, flowerMade;

  color fillColor;

  Flower flower;

  Sector(float xPosTemp, float yPosTemp, float wTemp, float hTemp, float _secScale) {
    position = new PVector(xPosTemp, yPosTemp);
    wSec = wTemp;
    hSec = hTemp;
    dummy = false;
    bigsec = false;
    flowerMade = false;
    secScale = _secScale;
  }

  // To create a 'fake' sector for passing
  Sector() {
  }

  void makeFlower() {
    if (dummy) {
      return;
    }
    flowerMade = false;
    flower     = new Flower(position, wSec, hSec, secScale); 
    flowerMade = true;
  }

  void makeFlowerWithChromosome(String chrom) {
    if (dummy) {
      return;
    }
    flowerMade = false;
    flower     = new Flower(position, wSec, hSec, secScale, chrom); 
    flowerMade = true;
  }

  void display() {
    debugDisplay();
    if (!dummy && flowerMade) {
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
        fill(0);
        text(String.valueOf(xCoord) + "," + String.valueOf(yCoord), position.x + 5, position.y + 0.1*hSec);
        println("\n------------ Sector " + String.valueOf(xCoord) + "," + String.valueOf(yCoord) + " ----------------");
        noFill();
        if (bigsec) {
          fill(240);
        }
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

