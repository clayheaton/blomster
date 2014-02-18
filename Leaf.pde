class Leaf {
  PVector attachPt, attachPt2;
  boolean left; // if not left, then right
  int     leafType;
  Leaf(PVector _attachPt, PVector _attachPt2, boolean _left, int _leafType) {
    attachPt = _attachPt;
    attachPt2 = _attachPt2;
    left     = _left;
    leafType = _leafType;
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
    default:
      println("implement leaf");
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

    vertex(-1 * dir * 15, -2);
    vertex(-1 * dir * 30, 0);
    vertex(-1 * dir * 15, 2);

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

    vertex(-1 * dir * 15, -7);
    vertex(-1 * dir * 30, -3.5);
    vertex(-1 * dir * 35, 0);
    vertex(-1 * dir * 30, 3.5);
    vertex(-1 * dir * 15, 7);

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
      curveVertex(anchor2.x, anchor2.y);
    } 
    else {
      vertex(anchor1.x, anchor1.y);
      curveVertex(anchor1.x, anchor1.y);
    }

    curveVertex(-1 * dir * 15, -10);
    curveVertex(-1 * dir * 30, -5);
    curveVertex(-1 * dir * 35, 0);
    curveVertex(-1 * dir * 30, 5);
    curveVertex(-1 * dir * 15, 7);

    if (left) {
      curveVertex(anchor1.x, anchor1.y);
      vertex(anchor1.x, anchor1.y);
    } 
    else {
      curveVertex(anchor2.x, anchor2.y);
      vertex(anchor2.x, anchor2.y);
    }
    println("rounded leaf");

    endShape();
  }
}

