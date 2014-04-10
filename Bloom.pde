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
    minorVariantTwoVal = random(bloomVariantTwo*0.6, bloomVariantTwo); // randomness to phenotype

    if (petalCount == 11) {
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

  void customVertex(float x, float y, boolean curved, int curveType) {
    // 1 for single curveVertex()
    // 2 for double curveVertex()  useful for start and end points in a shape
    // ignored by regular vertices
    if (!curved) {
      vertex(x, y);
    } 
    else if (curveType == 1) {
      curveVertex(x, y);
    } 
    else if (curveType == 2) {
      curveVertex(x, y);
      curveVertex(x, y);
    }
  }


  void displayCupStyle() {
    if (bloomVariant == 1) {
      drawCup(mainColor, 1.0, 0);  
      drawCup(secColor, 0.5, w/32.0);
    } 
    else {

      boolean useCurve = false;
      if (bloomVariant == 2) useCurve = true;

      float unit  = w/(9.5 * secScale);
      float dist1 = 1 * unit * secScale;
      float dist2 = 2 * unit * secScale;
      float dist3 = 3 * unit * secScale;
      float dist4 = 4 * unit * secScale;

      float splayAngle = radians(random(0, 5));
      float overallRotate = radians(random(-5, 5));

      pushMatrix();
      translate(bloomCenter.x, bloomCenter.y+(dist1/1.2));
      // Overall rotation
      rotate(overallRotate);

      // BG Left - back
      rotate(-splayAngle);
      fill(mainColor);
      beginShape();
      customVertex(0, 0, useCurve, 2);
      customVertex(-dist1, -dist2, useCurve, 1);
      customVertex(0, -dist4 * 0.9, useCurve, 1);
      customVertex(dist1/4, -dist2 * 0.8, useCurve, 1);
      customVertex(0, 0, useCurve, 2);
      endShape();

      // BG RIGHT - back
      rotate(splayAngle * 2);
      fill(mainColor);
      beginShape();
      customVertex(0, 0, useCurve, 2);
      customVertex(dist1, -dist2, useCurve, 1);
      customVertex(0, -dist4 * 0.9, useCurve, 1);
      customVertex(-dist1/4, -dist2 * 0.8, useCurve, 1);
      customVertex(0, 0, useCurve, 2);
      endShape();

      if (useCurve) {
        stroke(bloomColorThree, 200);
        strokeWeight(secScale);
      }

      PVector stPos = new PVector(0, 0);
      PVector dest  = new PVector(0, -dist4 * 0.9 * random(0.85, 0.95));
      PVector lerPos = PVector.lerp(stPos, dest, 0.1);

      // BG Left - highlight
      rotate(-splayAngle * 2);
      fill(secColor);
      beginShape();
      customVertex(lerPos.x, lerPos.y, useCurve, 2);
      customVertex(-dist1/2, -dist2, useCurve, 1);
      customVertex(0, -dist4 * 0.9 * random(0.85, 0.95), useCurve, 1);
      customVertex(lerPos.x, lerPos.y, useCurve, 2);
      endShape();

      // BG Right - highlight
      rotate(splayAngle * 2);
      fill(secColor);
      beginShape();
      customVertex(lerPos.x, lerPos.y, useCurve, 2);
      customVertex(dist1/2, -dist2, useCurve, 1);
      customVertex(0, -dist4 * 0.9 * random(0.85, 0.95), useCurve, 1);
      customVertex(lerPos.x, lerPos.y, useCurve, 2);
      endShape();

      noStroke();

      boolean leftFront = false;
      if (random(1) < 0.5) leftFront = true;

      rotate(-splayAngle);

      float frontRotIn = radians(random(-10, 15));

      if (leftFront) {
        cupLeftPetal(-frontRotIn, useCurve);
        cupRightPetal(frontRotIn, useCurve);
      } 
      else {
        cupRightPetal(frontRotIn, useCurve);
        cupLeftPetal(-frontRotIn, useCurve);
      }

      popMatrix();
    }
  }

  void cupLeftPetal(float angle, boolean useCurve) {

    rotate(angle);

    float unit  = w/(9.5 * secScale);
    float dist1 = 1 * unit * secScale;
    float dist2 = 2 * unit * secScale;
    float dist3 = 3 * unit * secScale;
    float dist4 = 4 * unit * secScale;
    fill(mainColor);

    PVector stPos = new PVector(0, 0);
    PVector dest  = new PVector(-(dist1 + dist2)/2, -(dist3 + dist4)/2);
    PVector lerPos = PVector.lerp(stPos, dest, 0.1);

    beginShape();
    customVertex(0, 0, useCurve, 2);
    customVertex(0, -(dist1 + dist2)/2, useCurve, 1);
    customVertex(-(dist1 + dist2)/2, -(dist3 + dist4)/2, useCurve, 1);
    customVertex(-(dist1 + dist2)/2, -dist1, useCurve, 1);
    customVertex(0, 0, useCurve, 2);
    endShape();

    if (useCurve) {
      stroke(bloomColorThree, 150);
      strokeWeight(secScale);
    }

    fill(secColor, 150);
    beginShape();
    customVertex(lerPos.x, lerPos.y, useCurve, 2);
    customVertex(-dist1 * random(0.25, 0.35), random(0.85, 0.95) * -(dist1 + dist2)/2, useCurve, 1);
    customVertex(-(dist1 + dist2)/2 * random(0.85, 0.95), -(dist3 + dist4)/2 * random(0.85, 0.95), useCurve, 1);
    customVertex(-(dist1 + dist2)/2 * random(0.65, 0.75), -dist1 * random(1.1, 1.25), useCurve, 1);
    customVertex(lerPos.x, lerPos.y, useCurve, 2);
    endShape();
    rotate(-angle);
    noStroke();
  }

  void cupRightPetal(float angle, boolean useCurve) {
    rotate(angle);
    float unit = w/(9.5 * secScale);
    float dist1 = 1 * unit * secScale;
    float dist2 = 2 * unit * secScale;
    float dist3 = 3 * unit * secScale;
    float dist4 = 4 * unit * secScale;
    fill(mainColor);

    PVector stPos = new PVector(0, 0);
    PVector dest  = new PVector((dist1 + dist2)/2, -(dist3 + dist4)/2);
    PVector lerPos = PVector.lerp(stPos, dest, 0.1);


    beginShape();
    customVertex(0, 0, useCurve, 2);
    customVertex(0, -(dist1 + dist2)/2, useCurve, 1);
    customVertex((dist1 + dist2)/2, -(dist3 + dist4)/2, useCurve, 1);
    customVertex((dist1 + dist2)/2, -dist1, useCurve, 1);
    customVertex(0, 0, useCurve, 2);
    endShape();

    if (useCurve) {
      stroke(bloomColorThree, 150);
      strokeWeight(secScale);
    }

    fill(secColor, 150);
    beginShape();
    customVertex(lerPos.x, lerPos.y, useCurve, 2);
    customVertex(dist1 * random(0.25, 0.35), random(0.85, 0.95) * -(dist1 + dist2)/2, useCurve, 1);
    customVertex((dist1 + dist2)/2 * random(0.85, 0.95), -(dist3 + dist4)/2 * random(0.85, 0.95), useCurve, 1);
    customVertex((dist1 + dist2)/2 * random(0.65, 0.75), -dist1 * random(1.1, 1.25), useCurve, 1);
    customVertex(lerPos.x, lerPos.y, useCurve, 2);
    endShape();
    rotate(-angle);

    noStroke();
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








  void displayAngledStyle() {
    pushMatrix();
    translate(bloomCenter.x,bloomCenter.y);
    rotate(random(radians(-8),radians(8)));

    // Problem displaying 7 -- so fix
    if (petalCount == 7) {
      petalCount = 6;
    }

    fill(mainColor);
    stroke(255);
    strokeWeight(0.5*secScale);

    float unit = w/15.0;
    float vertUnit = w/20.0;

    beginShape();
    curveVertex(0, 0);
    curveVertex(0, 0);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0 - unit*2, 0 - vertUnit*3);

    curveVertex(0 - unit*4, 0 - vertUnit*3);
    curveVertex(0 - unit, 0);
    curveVertex(0, 0);
    curveVertex(0, 0);
    endShape();


    beginShape();
    curveVertex(0, 0);
    curveVertex(0, 0);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0 + unit*2, 0 - vertUnit*3);

    curveVertex(0 + unit*4, 0 - vertUnit*3);
    curveVertex(0 + unit, 0);
    curveVertex(0, 0);
    curveVertex(0, 0);

    endShape();

    // Part jutting up from the middle
    fill(secColor);

    beginShape();
    curveVertex(0, 0 - vertUnit);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0 - unit*2, 0 - vertUnit*3);
    curveVertex(0 - unit*2, 0 - vertUnit*5);
    curveVertex(0, 0 - vertUnit*3);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0, 0 - vertUnit);
    endShape();

    beginShape();
    curveVertex(0, 0 - vertUnit);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0 + unit*2, 0 - vertUnit*3);
    curveVertex(0 + unit*2, 0 - vertUnit*5);
    curveVertex(0, 0 - vertUnit*3);
    curveVertex(0, 0 - vertUnit);
    curveVertex(0, 0 - vertUnit);
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

    PVector p1 = new PVector(0, 0 - vertUnit);
    PVector p2 = new PVector(0 - unit*2, 0 - vertUnit*3);
    PVector p3 = new PVector(0, 0 - vertUnit*4);
    PVector p4 = new PVector(0 + unit*2, 0 - vertUnit*3);

    PVector p1_2 = PVector.lerp(p1, p2, 0.3);
    PVector p1_3 = PVector.lerp(p1, p3, 0.4);
    PVector p1_4 = PVector.lerp(p1, p4, 0.3);

    beginShape();
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1_2.x, p1_2.y);
    curveVertex(p1_3.x, p1_3.y);
    curveVertex(p1_4.x, p1_4.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    endShape();

    // Left highlight point
    p1 = p2;
    p2 = new PVector(0 - unit*4, 0 - vertUnit*3);
    p3 = new PVector(0 - unit*2, 0 - vertUnit*5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.4);
    p1_4 = new PVector(p1_2.x, p1_3.y);

    beginShape();
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1_2.x, p1_2.y);
    curveVertex(p1_4.x, p1_4.y);
    curveVertex(p1_3.x, p1_3.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    endShape();

    // Right highlight point
    p1 = new PVector(0 + unit*2, 0 - vertUnit*3);
    p2 = new PVector(0 + unit*4, 0 - vertUnit*3);
    p3 = new PVector(0 + unit*2, 0 - vertUnit*5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.4);
    p1_4 = new PVector(p1_2.x, p1_3.y);

    beginShape();
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1_2.x, p1_2.y);
    curveVertex(p1_4.x, p1_4.y);
    curveVertex(p1_3.x, p1_3.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    endShape();

    p1 = new PVector(0, 0 - vertUnit*3);
    p2 = new PVector(0 - unit*2, 0 - vertUnit*5);
    p4 = new PVector(0 + unit*2, 0 - vertUnit*5);
    p3 = PVector.lerp(p2, p4, .5);

    p1_2 = PVector.lerp(p1, p2, 0.3);
    p1_3 = PVector.lerp(p1, p3, 0.9);
    p1_4 = PVector.lerp(p1, p4, 0.3);

    beginShape();
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1_2.x, p1_2.y);
    curveVertex(p1_3.x, p1_3.y);
    curveVertex(p1_4.x, p1_4.y);
    curveVertex(p1.x, p1.y);
    curveVertex(p1.x, p1.y);
    endShape();
    popMatrix();
  }












  void displayDandyStyle() {

    float sizeAdj = 4.5;
    
    fill(255);
    stroke(255);
    strokeWeight(1*secScale);
    ellipse(bloomCenter.x, bloomCenter.y, 3*secScale, 3*secScale);

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
    
    fill(secColor);
    stroke(secColor,200);
    strokeWeight(1*secScale);
    ellipse(bloomCenter.x, bloomCenter.y, 2*secScale, 2*secScale);
    
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
    float halfAngle  = (petalAngle / 2);

    float halfAngleSub = halfAngle * 0.5;

    float angleOffset = random(-halfAngle/2, halfAngle/2);


    // Draw the petals
    for (int i = 0; i < petalCount; i++) {

      // All variants do this part
      fill(mainColor);
      noStroke();
      float thisAngle = petalAngle * i + angleOffset;
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
      } 
      else if (bloomVariant == 1) {
      }

      if (bloomVariant == 2) {
        outerX   = bloomCenter.x + sin(radians(thisAngle))*outerRadius/1.8;
        outerY   = bloomCenter.y + cos(radians(thisAngle))*outerRadius/1.8;

        PVector innerUp     = new PVector(innerUpX, innerUpY);
        PVector sm_innerUp  = PVector.lerp(bloomCenter, innerUp, minorVariantTwoVal);
        float   sm_innerUpX = sm_innerUp.x;
        float   sm_innerUpY = sm_innerUp.y; 

        PVector outerUp     = new PVector(outerUpX, outerUpY);
        PVector sm_outerUp  = PVector.lerp(bloomCenter, outerUp, minorVariantTwoVal);
        float   sm_outerUpX = sm_outerUp.x;
        float   sm_outerUpY = sm_outerUp.y;

        PVector outer    = new PVector(outerX, outerY);
        PVector sm_outer = PVector.lerp(bloomCenter, outer, min(bloomVariantTwo, 0.8));

        float sm_outerX   = sm_outer.x;
        float sm_outerY   = sm_outer.y;

        PVector outerDown    = new PVector(outerDownX, outerDownY);
        PVector sm_outerDown = PVector.lerp(bloomCenter, outerDown, minorVariantTwoVal);

        float sm_outerDownX = sm_outerDown.x;
        float sm_outerDownY = sm_outerDown.y;

        PVector innerDown    = new PVector(innerDownX, innerDownY);
        PVector sm_innerDown = PVector.lerp(bloomCenter, innerDown, minorVariantTwoVal);

        float sm_innerDownX = sm_innerDown.x;
        float sm_innerDownY = sm_innerDown.y;


        // TODO return stroke color to here?
        stroke(mainColor); 
        strokeWeight(1 * secScale);//(0.5*secScale);

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

        // Small foreground markings
        fill(secColor);

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
        // Only bloomVariants 1 and 3 are drawn here.
        strokeWeight(1 * secScale);
        if (bloomVariant == 1) {
          noStroke();
        } 
        else {
          stroke(255, 200);
        }

        beginShape();

        if (bloomVariant == 1) {
          vertex(bloomCenter.x, bloomCenter.y);
          curveVertex(bloomCenter.x, bloomCenter.y);
        } 
        else {
          curveVertex(bloomCenter.x, bloomCenter.y);
          curveVertex(bloomCenter.x, bloomCenter.y);
        }

        curveVertex(innerUpX, innerUpY);
        curveVertex(outerX, outerY);
        curveVertex(innerDownX, innerDownY);


        if (bloomVariant == 1) {
          curveVertex(bloomCenter.x, bloomCenter.y);
          vertex(bloomCenter.x, bloomCenter.y);
        } 
        else {
          curveVertex(bloomCenter.x, bloomCenter.y);
          curveVertex(bloomCenter.x, bloomCenter.y);
        }

        endShape();
      }
    }

    noStroke();


    if (bloomVariant == 2) {
      fill(bloomColorThree, 200);
      ellipse(bloomCenter.x, bloomCenter.y, w/10.0, w/10.0);
    } 
    else {
      fill(secColor);
      ellipse(bloomCenter.x, bloomCenter.y, w/6.0, w/6.0);
    }
  }











void displayCircleStyle() {
    pushMatrix();
    translate(bloomCenter.x,bloomCenter.y);
    rotate(random(radians(-8),radians(8)));
    fill(mainColor);
    PVector orig = new PVector(0,0);

    int lowerPetalCount = 5;
    if(bloomVariant == 3){
     lowerPetalCount = 10; 
    }

    int   newPetalCount = (int)map(petalCount, bloomPetalCountRange[0], bloomPetalCountRange[1], lowerPetalCount, 18);

    float outerRadius = w/4.5;
    float innerRadius = outerRadius*0.8;    
    float petalAngle  = 360/newPetalCount;
    float halfAngle   = (petalAngle / 2);

    ArrayList<PVector> outerPoints = new ArrayList<PVector>();
    ArrayList<PVector> innerPoints = new ArrayList<PVector>();

    // Get outer points, then get inner points. curveVertex alternate between them
    for (int i = 0; i < newPetalCount; i++) {
      float angle = petalAngle * i;
      float ptX   = 0 + sin(radians(angle))*outerRadius;
      float ptY   = 0 + cos(radians(angle))*outerRadius;
      PVector p = new PVector(ptX, ptY);
      outerPoints.add(p);
    }

    float angle1 = 0;
    float ptX1   = 0 + sin(radians(angle1))*outerRadius;
    float ptY1   = 0 + cos(radians(angle1))*outerRadius;
    PVector p1 = new PVector(ptX1, ptY1);
    outerPoints.add(p1);


    // Inner points
    for (int i = 0; i < newPetalCount; i++) {
      float angle = petalAngle * i + halfAngle;
      float ptX   = 0 + sin(radians(angle))*innerRadius;
      float ptY   = 0 + cos(radians(angle))*innerRadius;
      PVector p = new PVector(ptX, ptY);
      innerPoints.add(p);
    }

    float ptX   = 0 + sin(radians(halfAngle))*innerRadius;
    float ptY   = 0 + cos(radians(halfAngle))*innerRadius;
    PVector p2 = new PVector(ptX, ptY);
    innerPoints.add(p2);

    PVector firstPoint = new PVector(0, 0);

    beginShape();

    for (int i = 0; i < outerPoints.size(); i++) {
      if (i == 0) {
        firstPoint = outerPoints.get(i);
        curveVertex(firstPoint.x, firstPoint.y);
      }
      PVector outPoint = outerPoints.get(i);
      PVector inPoint  = innerPoints.get(i);

      curveVertex(outPoint.x, outPoint.y);
      curveVertex(inPoint.x, inPoint.y);
    }

    // curveVertex(firstPoint.x,firstPoint.y);
    endShape();

    if (bloomVariant == 1) {
      float div  = 7.2;
      float max  = 8.0;
      float step = 0.2;

      // Color will lerp by this amount
      float numSteps   = (max - div) / step;
      float lerpAmount = (100 / numSteps) * 0.01;

      float currentLerp = lerpAmount;
      float reverseLerp = 1 - lerpAmount;

      noStroke();

      float newOuterRadius = outerRadius / div;
      float newInnerRadius = innerRadius / div;

      while (div <= max) {
        color thisFill = lerpColor(mainColor, secColor, currentLerp);
        fill(thisFill);

        PVector outer = new PVector();
        PVector inner = new PVector();

        beginShape();
        for (int i = 0; i < outerPoints.size(); i++) {
          PVector thisOuter = outerPoints.get(i);
          PVector thisInner = innerPoints.get(i);
          outer = PVector.lerp(orig, thisOuter, reverseLerp);
          inner = PVector.lerp(orig, thisInner, reverseLerp);     

          if (i == 0) {
            curveVertex(outer.x, outer.y);
          }   
          curveVertex(outer.x, outer.y);
          curveVertex(inner.x, inner.y);
        }
        endShape();


        div += step;
        newOuterRadius = newOuterRadius * reverseLerp;
        newInnerRadius = newInnerRadius * reverseLerp;
        currentLerp += lerpAmount;
        reverseLerp -= lerpAmount;
      }
    }

    if (bloomVariant == 2) {
      float div  = 7.2;
      float max  = 8.0;
      float step = 0.2;

      // Color will lerp by this amount
      float numSteps   = (max - div) / step;
      float lerpAmount = (100 / numSteps) * 0.01;

      float currentLerp = lerpAmount;
      float reverseLerp = 1 - lerpAmount;

      stroke(255);
      strokeWeight(2 * secScale);

      fill(secColor);

      beginShape();
      for (int i = 0; i < outerPoints.size(); i++) {
        PVector thisOuter = outerPoints.get(i);
        PVector thisInner = innerPoints.get(i);
        PVector outer = PVector.lerp(orig, thisOuter, 0.6);
        PVector inner = PVector.lerp(orig, thisInner, 0.6);     

        if (i == 0) {
          curveVertex(outer.x, outer.y);
        }   
        curveVertex(outer.x, outer.y);
        curveVertex(inner.x, inner.y);
      }
      endShape();

      fill(0, 200);
      noStroke();
      ellipse(0, 0, 7*secScale, 7*secScale);
    }

    // These look sort of like sunflowers
    if (bloomVariant == 3) {
      int spiralCount   = 18; // Should be 20 degrees per
      int angleSpacing  = 360 / spiralCount; // Must divide to an integer
      int spiralRings   =  7;
      float ringSpacing =  (w/(45.5 * secScale)) * secScale;
      float nodeDiam    =  (w/(75.8 * secScale)) * secScale;

      int rotDir = 1;
      if (bloomVariantTwo > (bloomVariantTwoRange[1] - bloomVariantTwoRange[0])/2.0) {
        rotDir = -1;
      }

      noStroke();
      fill(secColor,150);
      float sp = ringSpacing*spiralRings*2;
      ellipse(0, 0, sp, sp);



      fill(bloomColorThree);
      for (int r = 0; r < spiralRings; r++) {
        pushMatrix();
        translate(0, 0);
        // Nest this inside for each ring
        for (int i = 0; i < spiralCount; i ++) {
          float nodeAngle = i * angleSpacing + (r*angleSpacing/3) * rotDir;
          float nodeCenterX = sin(radians(nodeAngle))*(ringSpacing*r);
          float nodeCenterY = cos(radians(nodeAngle))*(ringSpacing*r);
          pushMatrix();
          translate(nodeCenterX, nodeCenterY);
          rotate(radians(nodeAngle));
          ellipse(0, 0, nodeDiam, nodeDiam*2);
          popMatrix();
        }
        popMatrix();
      }
    }
    popMatrix();
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

