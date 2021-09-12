class Leaf {
  PVector attachPt, attachPt2;
  boolean left; // if not left, then right
  float leafScale;
  int     leafType, leafPattern;
  color highlightColor, mainColor;

  Leaf(PVector _attachPt, 
  PVector _attachPt2, 
  boolean _left, 
  int _leafType, 
  int _leafPattern, 
  float _leafScale, 
  color _highlightColor, 
  color _mainColor) {

    attachPt       = _attachPt;
    attachPt2      = _attachPt2;
    left           = _left;
    leafType       = _leafType;
    leafPattern    = _leafPattern;
    leafScale      = _leafScale;
    highlightColor = _highlightColor;
    mainColor      = _mainColor;
  }

  void display() {
    // println("drawing leaf"); 
    pushMatrix();
    translate(attachPt.x, attachPt.y);

    switch(leafType) {
    case LEAF_TYPE_THIN:
      displayThinLeaf();
      break;
    case LEAF_TYPE_ANGLED:
      displayAngledLeaf();
      break;
    case LEAF_TYPE_ROUNDED:
      displayRoundedLeaf();
      break;
    case LEAF_TYPE_OVAL:
      displayOvalLeaf();
      break;
    case LEAF_TYPE_MULTI:
      displayMultiLeaf();
    default:
      // println("implement leaf");
    }

    popMatrix();
  }

  void displayThinLeaf() {
    float rot = random(-0.1, 0.2);
    int dir = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);
    fill(mainColor);
    beginShape();
    if (left) {
      vertex(anchor2.x, anchor2.y);
    } 
    else {
      vertex(anchor1.x, anchor1.y);
    }

    vertex(-1 * dir * 15 * leafScale, -2 * leafScale);
    vertex(-1 * dir * 30 * leafScale, 0 * leafScale);
    vertex(-1 * dir * 15 * leafScale, 2 * leafScale);

    if (left) {
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      vertex(anchor2.x, anchor2.y);
    }
    endShape();
  }

  void displayAngledLeaf() {
    float rot = random(-0.1, 0.2);
    int dir = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);
    // rect(0, 0, -1 * dir * 30, 7);

    fill(mainColor);
    beginShape();
    if (left) {
      vertex(anchor2.x, anchor2.y);
    } 
    else {
      vertex(anchor1.x, anchor1.y);
    }

    vertex(-1 * dir *  5 * leafScale, -3 * leafScale);
    vertex(-1 * dir * 10 * leafScale, -8 * leafScale);
    vertex(-1 * dir * 15 * leafScale, -5 * leafScale);
    vertex(-1 * dir * 20 * leafScale, -7 * leafScale);
    vertex(-1 * dir * 25 * leafScale, -3 * leafScale);
    vertex(-1 * dir * 30 * leafScale, -5 * leafScale);
    vertex(-1 * dir * 35 * leafScale, 0 * leafScale);
    vertex(-1 * dir * 30 * leafScale, 5 * leafScale);
    vertex(-1 * dir * 25 * leafScale, 3 * leafScale);
    vertex(-1 * dir * 20 * leafScale, 7 * leafScale);
    vertex(-1 * dir * 15 * leafScale, 5 * leafScale);
    vertex(-1 * dir * 10 * leafScale, 8 * leafScale);
    vertex(-1 * dir *  5 * leafScale, 3 * leafScale);

    if (left) {
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      vertex(anchor2.x, anchor2.y);
    }

    endShape();
  }

  void displayRoundedLeaf() {
    float rot = random(-0.1, 0.2);
    int dir = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);
    // rect(0, 0, -1 * dir * 30, 7);

    fill(mainColor);
    beginShape();
    if (left) {
      vertex(anchor2.x, anchor2.y);
    } 
    else {
      vertex(anchor1.x, anchor1.y);
    }

    curveVertex(-1 * dir *  4 * leafScale, -3  * leafScale);
    curveVertex(-1 * dir *  4 * leafScale, -3  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale, -8  * leafScale);
    curveVertex(-1 * dir * 15 * leafScale, -5  * leafScale);
    curveVertex(-1 * dir * 20 * leafScale, 0  * leafScale);
    curveVertex(-1 * dir * 15 * leafScale, 5  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale, 8  * leafScale);
    curveVertex(-1 * dir *  4 * leafScale, 3  * leafScale);
    curveVertex(-1 * dir *  4 * leafScale, 3  * leafScale);

    if (left) {
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      vertex(anchor2.x, anchor2.y);
    }
    // println("rounded leaf");

    endShape();

    if (leafPattern == LEAF_PATTERN_CIRCLES) {
      PVector anchorMid = PVector.lerp(anchor1, anchor2, 0.5);
      if (left) {
        float sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 11 * leafScale, anchorMid.y + (4.5*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 11 * leafScale, anchorMid.y - (1.5*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 14 * leafScale, anchorMid.y + (1.5*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 8  * leafScale, anchorMid.y + (1.5*leafScale), sz * leafScale, sz * leafScale);
      } 
      else {
        float sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 11 * leafScale, anchorMid.y + (1*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 11 * leafScale, anchorMid.y - (5*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 14 * leafScale, anchorMid.y - (2*leafScale), sz * leafScale, sz * leafScale);

        sz = random(2, 4);
        fill(highlightColor, int(random(120, 200)));
        ellipse(-1 * dir * 8  * leafScale, anchorMid.y - (2*leafScale), sz * leafScale, sz * leafScale);
      }


      noStroke();
    } 
    else if (leafPattern == LEAF_PATTERN_FILLED) {
      fill(highlightColor, int(random(120, 200)));
      beginShape();
      curveVertex(-1 * dir * 7 * leafScale, 0  * leafScale);
      curveVertex(-1 * dir * 7 * leafScale, 0  * leafScale);
      curveVertex(-1 * dir * 10 * leafScale, -4  * leafScale);
      curveVertex(-1 * dir * 14 * leafScale, 0  * leafScale);
      curveVertex(-1 * dir * 10 * leafScale, 4  * leafScale);
      curveVertex(-1 * dir * 7 * leafScale, 0  * leafScale);
      curveVertex(-1 * dir * 7 * leafScale, 0  * leafScale);
      endShape();
    } 
    else if (leafPattern == LEAF_PATTERN_VEINS) {
    } 
    else if (leafPattern == LEAF_PATTERN_NONE) {
    } 
    else {
      // This should never happen
      println("Disallowed leafPattern");
    }

    fill(mainColor);
  }

  void displayOvalLeaf() {
    float rot = random(-0.2, 0.2);
    int dir   = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);

    PVector newAnchor1 = PVector.lerp(anchor1, anchor2, 0.4);
    PVector newAnchor2 = PVector.lerp(anchor2, anchor1, 0.4);

    PVector dist  = PVector.sub(anchor1, anchor2);
    float spread = dist.mag()/1.2;
    spread = max(spread, 3);
    //println(spread);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);

    // Background Main Leaf
    fill(mainColor);
    
    // Debug
    //stroke(0);
    //strokeWeight(1);
    
    float factor = 1.2;
    beginShape();
    if (left) {
      curveVertex(anchor2.x, anchor2.y);
      curveVertex(anchor2.x, anchor2.y);
    } 
    else {
      curveVertex(anchor1.x, anchor1.y);
      curveVertex(anchor1.x, anchor1.y);
    }

    curveVertex(-1 * dir * 10 * leafScale, -spread * factor * leafScale);
    curveVertex(-1 * dir * 20 * leafScale, -spread * factor * leafScale);
    curveVertex(-1 * dir * 30 * leafScale, 0);
    curveVertex(-1 * dir * 20 * leafScale, spread * factor * leafScale);
    curveVertex(-1 * dir * 10 * leafScale, spread * factor * leafScale);


    if (left) {
      curveVertex(anchor1.x, anchor1.y);
      curveVertex(anchor1.x, anchor1.y);
    } 
    else {
      curveVertex(anchor2.x, anchor2.y);
      curveVertex(anchor2.x, anchor2.y);
    }

    endShape();
    noStroke();

    if (leafPattern == LEAF_PATTERN_FILLED) {
      // Foreground Center stripe
      fill(highlightColor, 150);
      factor = 0.4;
      beginShape();
      if (left) {
        curveVertex(newAnchor2.x, newAnchor2.y);
        curveVertex(newAnchor2.x, newAnchor2.y);
      } 
      else {
        curveVertex(newAnchor1.x, newAnchor1.y);
        curveVertex(newAnchor1.x, newAnchor1.y);
      }

      curveVertex(-1 * dir * 20 * leafScale, -spread * factor * leafScale);
      curveVertex(-1 * dir * 30 * leafScale, 0);
      curveVertex(-1 * dir * 20 * leafScale, spread * factor * leafScale);


      if (left) {
        curveVertex(newAnchor1.x, newAnchor1.y);
        curveVertex(newAnchor1.x, newAnchor1.y);
      } 
      else {
        curveVertex(newAnchor2.x, newAnchor2.y);
        curveVertex(newAnchor2.x, newAnchor2.y);
      }

      endShape(CLOSE);
    }
  }




  void displayMultiLeaf() {
    float rot = random(-0.1, 0.2);
    int dir = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);
    PVector anchorMid = PVector.lerp(anchor1, anchor2, 0.5);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);
    fill(mainColor);
    beginShape();

    float starty, endy;

    if (left) {
      vertex(anchor2.x, anchor2.y);
      starty = anchor2.y;
      endy   = anchor1.y;
    } 
    else {
      vertex(anchor1.x, anchor1.y);
      starty = anchor1.y;
      endy   = anchor2.y;
    }

    vertex(-1 * dir * 10  * leafScale, starty);
    curveVertex(-1 * dir * 10  * leafScale, (-6 * leafScale) + anchorMid.y);
    curveVertex(-1 * dir * 16  * leafScale, (-9 * leafScale) + anchorMid.y);
    curveVertex(-1 * dir * 22  * leafScale, (-6 * leafScale) + anchorMid.y);

    // Center point
    curveVertex(-1 * dir * 27  * leafScale, ( 0 * leafScale) + anchorMid.y);

    curveVertex(-1 * dir * 22  * leafScale, (6 * leafScale) + anchorMid.y);
    curveVertex(-1 * dir * 16  * leafScale, (9 * leafScale) + anchorMid.y);
    curveVertex(-1 * dir * 10  * leafScale, (6 * leafScale) + anchorMid.y);
    vertex(-1 * dir * 10  * leafScale, endy);



    if (left) {
      curveVertex(anchor1.x, anchor1.y);
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      curveVertex(anchor2.x, anchor2.y);
      vertex(anchor2.x, anchor2.y);
    }

    endShape();


    fill(highlightColor, 150);
    if (leafPattern == LEAF_PATTERN_CIRCLES) {
      ellipse(-1 * dir * 18  * leafScale, ( -4 * leafScale) + anchorMid.y, 4 * leafScale, 4 * leafScale);
      ellipse(-1 * dir * 18  * leafScale, (  4 * leafScale) + anchorMid.y, 4 * leafScale, 4 * leafScale);
      ellipse(-1 * dir * 23  * leafScale, (  0 * leafScale) + anchorMid.y, 4 * leafScale, 4 * leafScale);
    } 
    else if (leafPattern == LEAF_PATTERN_FILLED) {
      ellipse(-1 * dir * 19  * leafScale, anchorMid.y, 9 * leafScale, 6 * leafScale);
      ellipse(-1 * dir * 19  * leafScale, anchorMid.y, 6 * leafScale, 9 * leafScale);
    }
    fill(mainColor);
    noStroke();
  }
}
