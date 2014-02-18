class Stem {
  PVector position, topAnchor, bottomAnchor;
  float   w, h, stemWidth;
  int     stemShape, stemVariation, stemLeavesNum, stemLeafType;
  color   mainColor;
  ArrayList<PVector>stemCenterPoints;
  ArrayList<PVector>stemPoints;
  ArrayList<Leaf> leaves;
  IntList leafAttachedLeft;  // maps to stemCenterPoints
  IntList leafAttachedRight; // maps to stemCenterPoints


  Stem(PVector _position, 
  float _w, 
  float _h, 
  PVector _topAnchor, 
  PVector _bottomAnchor, 
  color _mainColor, 
  int _stemShape, 
  float _stemWidth, 
  int _stemVariation, 
  int _stemLeavesNum, 
  int _stemLeafType) {

    w             = _w;
    h             = _h;
    position      = _position;
    topAnchor     = _topAnchor;
    bottomAnchor  = _bottomAnchor;
    mainColor     = _mainColor;
    stemShape     = _stemShape;
    stemWidth     = _stemWidth;
    stemVariation = _stemVariation;
    stemLeavesNum = _stemLeavesNum;
    stemLeafType  = _stemLeafType;


    stemPoints       = new ArrayList<PVector>();
    stemCenterPoints = new ArrayList<PVector>();
    leafAttachedLeft = new IntList();
    leafAttachedRight = new IntList();

    setupStemPoints();

    leaves           = new ArrayList<Leaf>();

    setupLeaves();
  }

  void display() {
    // Baseline setup
    noStroke();
    fill(mainColor);
    pushMatrix();
    translate(position.x, position.y);

    // If we are debugging
    debugDisplay();

    // Choose the stem draw function based on 
    // the genetic stemShape
    switch(stemShape) {
    case STEM_SHAPE_STRAIGHT:
      drawStemStraight();
      break;
    case STEM_SHAPE_ANGLES:
      drawStemAngled();
      break;
    case STEM_SHAPE_CURVES: 
      drawStemCurved();
      break;
    default:
      println("Stem Problem");
    }
    
    for(Leaf l : leaves){
     l.display(); 
    }

    // Pop back to the regular space
    popMatrix();
  }

  void drawStemStraight() {
    beginShape();
    vertex(topAnchor.x - stemWidth/2, topAnchor.y);
    vertex(topAnchor.x + stemWidth/2, topAnchor.y);
    vertex(bottomAnchor.x + stemWidth/2, bottomAnchor.y);
    vertex(bottomAnchor.x - stemWidth/2, bottomAnchor.y);
    endShape();
  }

  void drawStemAngled() { 
    beginShape();
    for (int i=0; i<stemPoints.size();i++) {
      PVector p = stemPoints.get(i);
      vertex(p.x, p.y);
    }
    endShape();
  }

  void drawStemCurved() {
    beginShape();
    vertex(bottomAnchor.x - stemWidth/2.0, bottomAnchor.y);
    for (int i=0; i<stemPoints.size();i++) {
      PVector p = stemPoints.get(i);
      curveVertex(p.x, p.y);
    }
    vertex(bottomAnchor.x + stemWidth/2.0, bottomAnchor.y);
    endShape();
  }

  void debugDisplay() {
    if (debugStem) {
      beginShape();
      vertex(topAnchor.x - stemWidth/2, topAnchor.y);
      vertex(topAnchor.x + stemWidth/2, topAnchor.y);
      vertex(bottomAnchor.x + stemWidth/2, bottomAnchor.y);
      vertex(bottomAnchor.x - stemWidth/2, bottomAnchor.y);
      endShape();
    }
  }

  // Set up stem points for stems that are not straight.
  // The stemVariation is not expressed for flowers with 
  // the trait of STEM_SHAPE_STRAIGHT
  void setupStemPoints() {
    float numer = (float)stemVariation + 1.0;

    // LERP along the line
    float lerpPercent = (100/numer) / 100;

    // These represent the midpoints -- and leaf attach points, for the stem
    // ArrayList<PVector>tempStemPoints = new ArrayList<PVector>();
    for (int i = 1; i <= stemVariation; i++) {
      float r = random(-0.05, 0.05);
      stemCenterPoints.add( PVector.lerp(bottomAnchor, topAnchor, lerpPercent * i + r));

      // Set up the leaf attachment ArrayLists with 0 as values indicating no leaf attached
      leafAttachedLeft.append(0);
      leafAttachedRight.append(0);
    }


    // Take the temp points and create a round-trip arraylist
    // that will be used to create the stem.
    PVector bt = bottomAnchor.get();
    float baseFactor = random(0, stemWidth);
    bt.sub(stemWidth/2.0 - baseFactor, 0, 0);
    stemPoints.add(bt.get());

    // This list stores the random offsets that are used at the
    // variation points. It later is reversed and applied to the
    // points descending the other side of the stem, so that the
    // width of the stem remains constant in its variance.
    FloatList randomOffsets = new FloatList();

    for (PVector p : stemCenterPoints) {
      float r = random(-stemWidth/2.0, stemWidth/2.0); // Change for random variation
      randomOffsets.append(r);
      PVector t = new PVector(p.x - stemWidth/2 + r, p.y);
      stemPoints.add(t); // RANDOMIZE THIS
    }

    PVector tt = topAnchor.get();
    tt.sub(stemWidth/2.0, 0, 0);
    stemPoints.add(tt.get());
    tt.add(stemWidth, 0, 0);
    stemPoints.add(tt.get());

    ArrayList<PVector> reversedCenterPoints = new ArrayList<PVector>(stemCenterPoints);
    Collections.reverse(reversedCenterPoints);

    FloatList reversedRandom = new FloatList();

    for (int i=randomOffsets.size() - 1; i >=0; i--) {
      reversedRandom.append(randomOffsets.get(i));
    }

    for (int i=0; i < reversedCenterPoints.size(); i++) {
      PVector t = new PVector(reversedCenterPoints.get(i).x + stemWidth/2 + reversedRandom.get(i), reversedCenterPoints.get(i).y);
      stemPoints.add(t); // RANDOMIZE THIS
    }

    bt.add(stemWidth + baseFactor, 0, 0);
    stemPoints.add(bt.get());
  }

  void setupLeaves() {
    // println("# leaves: " + stemLeavesNum + ", type: " + stemLeafType);
    float r = random(0, 100);
    boolean left = false;
    if (r > 50) {
      left = true;
    }

    // Not assigned any leaves
    if (stemLeavesNum == 0) return;

    for (int i = 0; i < stemLeavesNum; i++) {
      int idx = (int)random(0, stemCenterPoints.size());
      
      PVector pt2;
      
      float stemAnchorPerc = 0.1;
      
      if(stemCenterPoints.size() == 1){
        pt2 = PVector.lerp(stemCenterPoints.get(0),bottomAnchor,stemAnchorPerc);
      } else if(idx == 0) {
        pt2 = PVector.lerp(stemCenterPoints.get(0),bottomAnchor,stemAnchorPerc);
      } else {
        pt2 = PVector.lerp(stemCenterPoints.get(idx),stemCenterPoints.get(idx - 1), stemAnchorPerc); 
      }
      
      boolean leftBlocked = false;
      boolean rightBlocked = false;

      // Check if the sides are blocked at this node
      if (left) {
        if (leafAttachedLeft.get(idx) == 1) {
          left = false; 
          leftBlocked = true;
        }
      } 
      if (!left) {
        if (leafAttachedRight.get(idx) == 1) {
          left = true;
          rightBlocked = true;
        }
      }
      
      // picked a bad node... TODO figure out how to try another
      if(leftBlocked && rightBlocked){
       continue; 
      }
      
      if(left){
        Leaf l = new Leaf(stemCenterPoints.get(idx), pt2, true, stemLeafType);
        leaves.add(l);
        leafAttachedLeft.set(idx,1);
        
      } else {
        Leaf l = new Leaf(pt2, stemCenterPoints.get(idx), false, stemLeafType);
        leaves.add(l);
        leafAttachedRight.set(idx,1);
      }
      
    }
  }
}

