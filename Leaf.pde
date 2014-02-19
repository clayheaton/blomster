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
    // rect(0, 0, -1 * dir * 30, 7);

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
    vertex(-1 * dir * 35 * leafScale,  0 * leafScale);
    vertex(-1 * dir * 30 * leafScale,  5 * leafScale);
    vertex(-1 * dir * 25 * leafScale,  3 * leafScale);
    vertex(-1 * dir * 20 * leafScale,  7 * leafScale);
    vertex(-1 * dir * 15 * leafScale,  5 * leafScale);
    vertex(-1 * dir * 10 * leafScale,  8 * leafScale);
    vertex(-1 * dir *  5 * leafScale,  3 * leafScale);
    
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

    beginShape();
    if (left) {
      vertex(anchor2.x, anchor2.y);
    } 
    else {
      vertex(anchor1.x, anchor1.y);
    }

         vertex(-1 * dir *  4 * leafScale,  -3  * leafScale);
    curveVertex(-1 * dir *  4 * leafScale,  -3  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale,  -8  * leafScale);
    curveVertex(-1 * dir * 15 * leafScale,  -5  * leafScale);
    curveVertex(-1 * dir * 20 * leafScale,   0  * leafScale);
    curveVertex(-1 * dir * 15 * leafScale,   5  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale,   8  * leafScale);
    curveVertex(-1 * dir *  4 * leafScale,   3  * leafScale);
         vertex(-1 * dir *  4 * leafScale,   3  * leafScale);

    if (left) {
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      vertex(anchor2.x, anchor2.y);
    }
    // println("rounded leaf");

    endShape();
    
    // Highlight color
    fill(highlightColor,128);
    beginShape();
    curveVertex(-1 * dir * 7 * leafScale,  0  * leafScale);
    curveVertex(-1 * dir * 7 * leafScale,  0  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale,  -4  * leafScale);
    curveVertex(-1 * dir * 14 * leafScale,  0  * leafScale);
    curveVertex(-1 * dir * 10 * leafScale,  4  * leafScale);
    curveVertex(-1 * dir * 7 * leafScale,  0  * leafScale);
    endShape();
    fill(mainColor);

  }
  
  void displayMultiLeaf(){
    float rot = random(-0.1, 0.2);
    int dir = 1;

    PVector anchor1 = new PVector(0, 0);
    PVector anchor2 = PVector.sub(attachPt, attachPt2);

    if (!left) {
      dir = -1;
    }

    rotate(dir * rot);

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
    
    vertex(-1 * dir * 15  * leafScale,  starty);
    vertex(-1 * dir * 20  * leafScale,      -6 * leafScale);
    vertex(-1 * dir * 25  * leafScale,       0 * leafScale);
    vertex(-1 * dir * 20  * leafScale,       6 * leafScale);
    vertex(-1 * dir * 15  * leafScale,    endy);
    
    if (left) {
      curveVertex(anchor1.x, anchor1.y);
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      curveVertex(anchor2.x, anchor2.y);
      vertex(anchor2.x, anchor2.y);
    }
    // println("rounded leaf");

    endShape();
  }
}

