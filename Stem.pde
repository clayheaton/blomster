class Stem {
  PVector position, topAnchor, bottomAnchor;
  float   w, h, stemWidth, stemScale;
  int     stemShape, stemVariation, stemLeavesNum, stemLeafType, stemLeafPattern, sumLLeaves, sumRLeaves;
  color   mainColor, leafHighlightColor;
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
  int _stemLeafType, 
  int _stemLeafPattern, 
  float _stemScale, 
  color _leafHighlightColor) {

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
    stemScale     = _stemScale;
    stemLeafPattern = _stemLeafPattern;
    leafHighlightColor = _leafHighlightColor;
    sumLLeaves = 0;
    sumRLeaves = 0;

    stemWidth = stemWidth * stemScale;

    stemPoints       = new ArrayList<PVector>();
    stemCenterPoints = new ArrayList<PVector>();
    leafAttachedLeft = new IntList();
    leafAttachedRight = new IntList();

    setupStemPoints();

    stemLeavesNum = min(_stemLeavesNum, stemCenterPoints.size() * 2);

    leaves           = new ArrayList<Leaf>();

    setupLeaves();
  }

  void display() {
    // Baseline setup
    noStroke();
    fill(mainColor);
    pushMatrix();
    translate(position.x, position.y);

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

    for (Leaf l : leaves) {
      l.display();
    }

    // If we are debugging
    debugDisplay();

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
      fill(255, 0, 0);
      for (PVector v : stemCenterPoints) {
        ellipse(v.x, v.y, 3, 3);
      }
      fill(0, 0, 0);

      text(leaves.size(), 5, 0.8*h);
      fill(mainColor);
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

    // Not assigned any leaves
    if (stemLeavesNum == 0) return;

    // Loop for creating leaves
    // println("\n------- New Stem with leaves:" + stemLeavesNum + "...........");

    for (int i = 0; i < stemLeavesNum; i++) {
      float r = random(0, 100);
      boolean left = false;
      if (r > 50) {
        left = true;
      }

      if (left == true) {
        if (sumLLeaves > sumRLeaves + 1) {
          left = false;
        }
      }

      if (left == false) {
        if (sumRLeaves > sumLLeaves + 1) {
          left = true;
        }
      }


      int     idx = (int)random(0, stemCenterPoints.size());
      PVector pt2;
      boolean leftBlocked  = false;
      boolean rightBlocked = false;

      /*
      println("New leaf iteration.");
       println("Index proposed: "   + idx);
       println("leafAttachedLeft: " + leafAttachedLeft);
       println("leafAttachedRight:" + leafAttachedRight);
       */

      float stemAnchorPerc = 0.1;// * stemScale;

      if (stemCenterPoints.size() == 1 || idx == 0) {
        // There's only one center point, so lerp from it towards the bottom
        // println("pt2 assigned because either idx is 0 or there's 1 center point");
        pt2 = PVector.lerp(stemCenterPoints.get(0), bottomAnchor, stemAnchorPerc);
      } 
      else {
        // This is not at the first centerpoint; lerp towards the next point down
        // Potential problem here because the distance between center points is variable,
        // Meaning that the leaf stem will be variable in width
        pt2 = PVector.lerp(stemCenterPoints.get(idx), stemCenterPoints.get(idx - 1), stemAnchorPerc);
      }


      // Check if the sides are blocked at this node
      if (left == true) {
        // println("Checking whether left is blocked.");
        if (leafAttachedLeft.get(idx) > 0) {
          // println("Left is blocked. Trying right.");
          left = false; 
          leftBlocked = true;
        }
      } 


      if (left == false) {
        if (leafAttachedRight.get(idx) > 0) {
          // println("Right is blocked");
          if (leafAttachedLeft.get(idx) == 0) {
            left = true;
          }
          rightBlocked = true;
        }
      }

      // picked a bad node... TODO figure out how to try another
      if (leftBlocked == true && rightBlocked == true) {
        // println("Skipping leaf creation.\n");
        continue;
      }

      if (left && leftBlocked == false) { 
        // println("Left leaf to index: " + idx + ", leafAttachedLeft: " + leafAttachedLeft);
        Leaf l = new Leaf(stemCenterPoints.get(idx), pt2, true, stemLeafType, stemLeafPattern, stemScale, leafHighlightColor, mainColor);
        leaves.add(l);
        leafAttachedLeft.set(idx, 1);
        sumLLeaves += 1;
      } 
      else if (left == false && rightBlocked == false) {
        Leaf l = new Leaf(pt2, stemCenterPoints.get(idx), false, stemLeafType, stemLeafPattern, stemScale, leafHighlightColor, mainColor);
        leaves.add(l);
        leafAttachedRight.set(idx, 1);
        sumRLeaves += 1;
      }
    }
    // println("--------------------------------\n");
  }
}

