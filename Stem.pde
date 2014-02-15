class Stem {
  PVector position, topAnchor, bottomAnchor;
  float   w, h, stemWidth;
  int     stemShape, stemVariation;
  color   mainColor;
  ArrayList<PVector>stemCenterPoints;
  ArrayList<PVector>stemPoints;


  Stem(PVector _position, 
  float _w, 
  float _h, 
  PVector _topAnchor, 
  PVector _bottomAnchor, 
  color _mainColor, 
  int _stemShape, 
  float _stemWidth, 
  int _stemVariation) {

    w             = _w;
    h             = _h;
    position      = _position;
    topAnchor     = _topAnchor;
    bottomAnchor  = _bottomAnchor;
    mainColor     = _mainColor;
    stemShape     = _stemShape;
    stemWidth     = _stemWidth;
    stemVariation = _stemVariation;


    stemPoints = new ArrayList<PVector>();
    stemCenterPoints = new ArrayList<PVector>();
    setupStemPoints();
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
    }


    // Take the temp points and create a round-trip arraylist
    // that will be used to create the stem.
    PVector bt = bottomAnchor.get();
    float baseFactor = stemWidth/2;
    bt.sub(stemWidth/2.0 - baseFactor, 0, 0);
    stemPoints.add(bt.get());

    // This list stores the random offsets that are used at the
    // variation points. It later is reversed and applied to the
    // points descending the other side of the stem, so that the
    // width of the stem remains constant in its variance.
    FloatList randomOffsets = new FloatList();

    for (PVector p : stemCenterPoints) {
      float r = random(-stemWidth/3.0, stemWidth/3.0); // Change for random variation
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
}

