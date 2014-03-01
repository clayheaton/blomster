class Bloom {
  PVector position, bloomCenter;
  float w, h, secScale;
  color mainColor, secColor, bloomColorThree;
  int bloomStyle, bloomVariant, petalCount;
  float bloomVariantTwo, minorVariantTwoVal;

  Bloom(PVector tempPosition, 
  float tempW, 
  float tempH, 
  color _c, 
  color _cm, 
  color _bloomColorThree, 
  int _bloomStyle, 
  int _bloomVariant, 
  float _secScale, 
  int _petalCount,
  float _bloomVariantTwo) {
    position = tempPosition;
    w = tempW;
    h = tempH;
    bloomCenter = new PVector(w * 0.5, h * 0.75);
    mainColor = _c;
    secColor  = _cm;
    bloomColorThree = _bloomColorThree;
    bloomStyle = _bloomStyle;
    bloomVariant = _bloomVariant;
    secScale = _secScale;
    petalCount = _petalCount;
    bloomVariantTwo = _bloomVariantTwo;
    minorVariantTwoVal = random(bloomVariantTwo*0.6,bloomVariantTwo); // randomness to phenotype
    
    if(petalCount == 11){
     petalCount -=1; 
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    switch(bloomStyle) {
    case BLOOM_STYLE_CUP:
      displayCupStyle();
      break;
    case BLOOM_STYLE_CIRCLE:
      displayCircleStyle();
      break;
    case BLOOM_STYLE_DAISY:
      displayDaisyStyle();
      break;
    case BLOOM_STYLE_DANDY:
      displayDandyStyle();
      break;
    case BLOOM_STYLE_ANGLED:
      displayAngledStyle();
      break;
    default:
      debugDisplay();
    }
    popMatrix();
  }

  void displayAngledStyle() {
    fill(mainColor);
    stroke(255);
    strokeWeight(0.5*secScale);

    float unit = w/15.0;
    float vertUnit = w/20.0;

    beginShape();
    vertex(bloomCenter.x, bloomCenter.y);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    vertex(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*3);

    vertex(bloomCenter.x - unit*4, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x - unit, bloomCenter.y);
    vertex(bloomCenter.x, bloomCenter.y);

    endShape();

    beginShape();
    vertex(bloomCenter.x, bloomCenter.y);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    vertex(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*3);

    vertex(bloomCenter.x + unit*4, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x + unit, bloomCenter.y);
    vertex(bloomCenter.x, bloomCenter.y);

    endShape();

    // Part jutting up from the middle
    fill(secColor);

    beginShape();
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    vertex(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*5);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    endShape();

    beginShape();
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    vertex(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*5);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit*3);
    vertex(bloomCenter.x, bloomCenter.y - vertUnit);
    endShape();

    // Highlights - bloomColorThree and bloomVariant
    // TODO: Adjust these colors
    if (bloomVariant == 1) {
      fill(255, 0, 0);
    } 
    else if (bloomVariant == 2) {
      fill(secColor);
    } 
    else {
      fill(mainColor);
    }

    PVector p1 = new PVector(bloomCenter.x, bloomCenter.y - vertUnit);
    PVector p2 = new PVector(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*3);
    PVector p3 = new PVector(bloomCenter.x, bloomCenter.y - vertUnit*4);
    PVector p4 = new PVector(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*3);

    PVector p1_2 = PVector.lerp(p1, p2, 0.3);
    PVector p1_3 = PVector.lerp(p1, p3, 0.4);
    PVector p1_4 = PVector.lerp(p1, p4, 0.3);

    beginShape();
    vertex(p1.x, p1.y);
    vertex(p1_2.x, p1_2.y);
    vertex(p1_3.x, p1_3.y);
    vertex(p1_4.x, p1_4.y);
    vertex(p1.x, p1.y);
    endShape();

    // Left highlight point
    p1 = p2;
    p2 = new PVector(bloomCenter.x - unit*4, bloomCenter.y - vertUnit*3);
    p3 = new PVector(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.4);
    p1_4 = new PVector(p1_2.x, p1_3.y);

    beginShape();
    vertex(p1.x, p1.y);
    vertex(p1_2.x, p1_2.y);
    vertex(p1_4.x, p1_4.y);
    vertex(p1_3.x, p1_3.y);
    vertex(p1.x, p1.y);
    endShape();

    // Right highlight point
    p1 = new PVector(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*3);
    p2 = new PVector(bloomCenter.x + unit*4, bloomCenter.y - vertUnit*3);
    p3 = new PVector(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.4);
    p1_4 = new PVector(p1_2.x, p1_3.y);

    beginShape();
    vertex(p1.x, p1.y);
    vertex(p1_2.x, p1_2.y);
    vertex(p1_4.x, p1_4.y);
    vertex(p1_3.x, p1_3.y);
    vertex(p1.x, p1.y);
    endShape();

    p1 = new PVector(bloomCenter.x, bloomCenter.y - vertUnit*3);
    p2 = new PVector(bloomCenter.x - unit*2, bloomCenter.y - vertUnit*5);
    p4 = new PVector(bloomCenter.x + unit*2, bloomCenter.y - vertUnit*5);
    p3 = PVector.lerp(p2, p4, .5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.9);
    p1_4 = PVector.lerp(p1, p4, 0.3);

    beginShape();
    vertex(p1.x, p1.y);
    vertex(p1_2.x, p1_2.y);
    vertex(p1_3.x, p1_3.y);
    vertex(p1_4.x, p1_4.y);
    vertex(p1.x, p1.y);
    endShape();
  }

  void displayDandyStyle() {

    float sizeAdj = 4.5;

    fill(secColor);
    noStroke();
    ellipse(bloomCenter.x, bloomCenter.y, 7*secScale, 7*secScale);

    noFill();
    stroke(mainColor, 100);
    strokeWeight(1);

    // Movement in along rings
    for (float i = sizeAdj; i < 40.0; i += 0.1) {
      float startRadius = (w/(i))/2.0;
      float endRadius   = (w/(i - 2.2))/2.0; // this will need adjustment

      for (int j = 0; j < 20; j++) {
        float thisAngle = random(0, 360);

        // Calculate the point on the outer ring where we'll start
        float baseX = bloomCenter.x + sin(radians(thisAngle)) * startRadius;
        float baseY = bloomCenter.y + cos(radians(thisAngle)) * startRadius;
        float endX  = bloomCenter.x + sin(radians(thisAngle)) * endRadius;
        float endY  = bloomCenter.y + cos(radians(thisAngle)) * endRadius;

        line(baseX, baseY, endX, endY);
      }
    }

    // Inner rings - secondary color
    stroke(secColor, 100);
    for (float i = sizeAdj*1.5; i < 40.0; i += 0.1) {
      float startRadius = (w/(i))/2.0;
      float endRadius   = (w/(i - 2.2))/2.0; // this will need adjustment

      for (int j = 0; j < 3; j++) {
        float thisAngle = random(0, 360);

        // Calculate the point on the outer ring where we'll start
        float baseX = bloomCenter.x + sin(radians(thisAngle)) * startRadius;
        float baseY = bloomCenter.y + cos(radians(thisAngle)) * startRadius;
        float endX  = bloomCenter.x + sin(radians(thisAngle)) * endRadius;
        float endY  = bloomCenter.y + cos(radians(thisAngle)) * endRadius;

        line(baseX, baseY, endX, endY);
      }
    }
  }

  void displayDaisyStyle() {
    float outerRadius = w/2.3; // Vary these genetically?
    float innerRadius = w/(3.0);    

    if (bloomVariant == 2) {
      innerRadius = w/2;
    }

    if (bloomVariant == 3) {
      innerRadius = w/3.4;
    }


    float petalAngle = 360/petalCount;
    float halfAngle  = (petalAngle / 2) + random(-2,2);

    float halfAngleSub = halfAngle * 0.5;

    // Draw the petals
    for (int i = 0; i < petalCount; i++) {
      fill(mainColor);
      noStroke();
      float thisAngle = petalAngle * i;
      float innerUpX = bloomCenter.x + sin(radians(thisAngle + halfAngle))*innerRadius/2;
      float innerUpY = bloomCenter.y + cos(radians(thisAngle + halfAngle))*innerRadius/2;

      float outerUpX = bloomCenter.x + sin(radians(thisAngle + halfAngle))*outerRadius/2;
      float outerUpY = bloomCenter.y + cos(radians(thisAngle + halfAngle))*outerRadius/2;

      float outerX   = bloomCenter.x + sin(radians(thisAngle))*outerRadius/2;
      float outerY   = bloomCenter.y + cos(radians(thisAngle))*outerRadius/2;

      if (bloomVariant == 3) {
        outerX   = bloomCenter.x + sin(radians(thisAngle))*outerRadius/1.5;
        outerY   = bloomCenter.y + cos(radians(thisAngle))*outerRadius/1.5;
      }

      float outerDownX = bloomCenter.x + sin(radians(thisAngle - halfAngle))*outerRadius/2;
      float outerDownY = bloomCenter.y + cos(radians(thisAngle - halfAngle))*outerRadius/2;

      float innerDownX = bloomCenter.x + sin(radians(thisAngle - halfAngle))*innerRadius/2;
      float innerDownY = bloomCenter.y + cos(radians(thisAngle - halfAngle))*innerRadius/2;

      if (bloomVariant == 2) {
        outerX   = bloomCenter.x + sin(radians(thisAngle))*outerRadius/1.8;
        outerY   = bloomCenter.y + cos(radians(thisAngle))*outerRadius/1.8;

        PVector innerUp     = new PVector(innerUpX, innerUpY);
        PVector sm_innerUp  = PVector.lerp(bloomCenter,innerUp,minorVariantTwoVal);
        float   sm_innerUpX = sm_innerUp.x;
        float   sm_innerUpY = sm_innerUp.y; 

        PVector outerUp     = new PVector(outerUpX, outerUpY);
        PVector sm_outerUp  = PVector.lerp(bloomCenter,outerUp,minorVariantTwoVal);
        float   sm_outerUpX = sm_outerUp.x;
        float   sm_outerUpY = sm_outerUp.y;

        PVector outer    = new PVector(outerX, outerY);
        PVector sm_outer = PVector.lerp(bloomCenter,outer,min(bloomVariantTwo,0.8));

        float sm_outerX   = sm_outer.x;
        float sm_outerY   = sm_outer.y;
        
        PVector outerDown    = new PVector(outerDownX, outerDownY);
        PVector sm_outerDown = PVector.lerp(bloomCenter,outerDown,minorVariantTwoVal);

        float sm_outerDownX = sm_outerDown.x;
        float sm_outerDownY = sm_outerDown.y;
        
        PVector innerDown    = new PVector(innerDownX, innerDownY);
        PVector sm_innerDown = PVector.lerp(bloomCenter,innerDown,minorVariantTwoVal);

        float sm_innerDownX = sm_innerDown.x;
        float sm_innerDownY = sm_innerDown.y;

        stroke(255); 
        noStroke();
        strokeWeight(0.5*secScale);

        // Large bg petals
        beginShape();
        vertex(bloomCenter.x, bloomCenter.y);
        curveVertex(bloomCenter.x, bloomCenter.y);
        curveVertex(innerUpX, innerUpY);
        vertex(outerUpX, outerUpY);
        vertex(outerX, outerY);
        curveVertex(outerX, outerY);
        vertex(outerDownX, outerDownY);
        curveVertex(innerDownX, innerDownY);
        curveVertex(bloomCenter.x, bloomCenter.y);
        vertex(bloomCenter.x, bloomCenter.y);
        endShape();

        fill(secColor,200);
        
        beginShape();
        vertex(bloomCenter.x, bloomCenter.y);
        curveVertex(bloomCenter.x, bloomCenter.y);
        curveVertex(sm_innerUpX, sm_innerUpY);
        vertex(sm_outerUpX, sm_outerUpY);
        vertex(sm_outerX, sm_outerY);
        vertex(sm_outerDownX, sm_outerDownY);
        curveVertex(sm_innerDownX, sm_innerDownY);
        curveVertex(bloomCenter.x, bloomCenter.y);
        vertex(bloomCenter.x, bloomCenter.y);
        endShape();
      } 
      else {
        beginShape();
        vertex(bloomCenter.x, bloomCenter.y);
        curveVertex(bloomCenter.x, bloomCenter.y);
        curveVertex(innerUpX, innerUpY);
        curveVertex(outerX, outerY);
        curveVertex(innerDownX, innerDownY);
        curveVertex(bloomCenter.x, bloomCenter.y);
        vertex(bloomCenter.x, bloomCenter.y);
        endShape();
      }
    }


    if (bloomVariant == 2) {
      fill(bloomColorThree,200);
      ellipse(bloomCenter.x, bloomCenter.y, w/10.0, w/10.0);
    } 
    else {
      fill(secColor);
      ellipse(bloomCenter.x, bloomCenter.y, w/6.0, w/6.0);
    }
  }












  void displayCupStyle() {
    if (bloomVariant == 5) { // Won't happen...  maybe gradients? TODO
    } 
    else {
      drawCup(mainColor, 1.0, 0);  
      drawCup(secColor, 0.5, w/32.0);
    }
  }


  void drawCup(color c, float scale, float yOffset) {
    fill(c);

    float dist1 = (w/8)  * scale;
    float dist2 = (w/5)  * scale;
    float dist3 = (w/12) * scale;
    float dist4 = (w/16) * scale;

    float randAdjustAmt = 40.0;

    beginShape();
    // Center bottom anchor start/end point
    curveVertex( bloomCenter.x, bloomCenter.y + dist1 + yOffset  );
    curveVertex( bloomCenter.x, bloomCenter.y + dist1 + yOffset  );

    // Right-side ascending
    curveVertex( bloomCenter.x + dist1, bloomCenter.y + dist4 + yOffset  );

    float randAdjust = random(-w/randAdjustAmt, w/randAdjustAmt);
    // Top right point
    curveVertex( bloomCenter.x + dist2, bloomCenter.y - dist1 + yOffset + randAdjust );

    // First dip, right to left
    curveVertex( bloomCenter.x + dist3, bloomCenter.y - dist4 + yOffset  );

    randAdjust = random(-w/randAdjustAmt, w/randAdjustAmt);
    // Center top point
    curveVertex( bloomCenter.x, bloomCenter.y - dist1 + yOffset + randAdjust );

    // Second dip, right to left
    curveVertex( bloomCenter.x - dist3, bloomCenter.y - dist4 + yOffset  );

    randAdjust = random(-w/randAdjustAmt, w/randAdjustAmt);
    // Top left point
    curveVertex( bloomCenter.x - dist2, bloomCenter.y - dist1 + yOffset + randAdjust );


    curveVertex( bloomCenter.x - dist1, bloomCenter.y + dist4 + yOffset  );

    // Return to anchor
    curveVertex( bloomCenter.x, bloomCenter.y + dist1 + yOffset  );
    curveVertex( bloomCenter.x, bloomCenter.y + dist1 + yOffset  );
    endShape();
  }




  void displayCircleStyle() {
    fill(mainColor);
    stroke(mainColor);
    strokeWeight(1.5 * secScale);
    ellipse(bloomCenter.x, bloomCenter.y, w/4.0, w/4.0);
    noStroke();

    // Lines on the background outer circle
    if (bloomVariant == 2) {
      stroke(bloomColorThree);
      strokeWeight(1.5 * secScale);
      float radius = w/8.0;
      int   lines  = 12;
      float angle  = 360.0 / lines;
      for (int i = 0; i < lines; i++) {
        float thisAngle = i * angle;
        float ptX = bloomCenter.x + sin(radians(thisAngle))*radius;
        float ptY = bloomCenter.y + cos(radians(thisAngle))*radius;
        line(bloomCenter.x, bloomCenter.y, ptX, ptY);
      }
      noStroke();
    }

    fill(secColor);

    // Outline the center circle
    if (bloomVariant == 1) {
      stroke(bloomColorThree);
      strokeWeight(1.0 * secScale);
    } 
    else {
      stroke(secColor);
    }

    ellipse(bloomCenter.x, bloomCenter.y, w/6.0, w/6.0);
    noStroke();

    // Lines on the inner circle
    if (bloomVariant == 3) {
      stroke(bloomColorThree, 200);
      strokeWeight(1.5 * secScale);
      float radius = w/12.0;
      int   lines  = 8;
      float angle  = 360.0 / lines;
      for (int i = 0; i < lines; i++) {
        float thisAngle = i * angle;
        float ptX = bloomCenter.x + sin(radians(thisAngle))*radius;
        float ptY = bloomCenter.y + cos(radians(thisAngle))*radius;
        line(bloomCenter.x, bloomCenter.y, ptX, ptY);
      }
      noStroke();
    }
  }







  void debugDisplay() {
    if (debugBloom) {
      fill(mainColor);
      ellipse(bloomCenter.x, bloomCenter.y, w/4.0, w/4.0);
      fill(secColor);
      ellipse(bloomCenter.x, bloomCenter.y, w/6.0, w/6.0);
    }
  }
}

