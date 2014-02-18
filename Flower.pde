class Flower {
  PVector position;
  float w, h;

  String chromosome;

  Bloom bloom;
  Stem stem;

  float bloomH;
  color bloomC, bloomCM;
  
  color   stemC;
  PVector stemAnchor;
  int     stemShape, stemVariation, stemLeavesNum, stemLeafType;
  float   stemWidth;

  Flower(PVector tempPos, float tempW, float tempH) {
    position = tempPos;
    w = tempW;
    h = tempH;

    chromosome = pool.buildChromosome();
    // println("flower chromosome:" + chromosome);

    bloomSetup();
    stemSetup();
    
    // Create the bloom object
    bloom   = new Bloom(position, w, bloomH, bloomC, bloomCM);
    
    // Create the stem object
    stem = new Stem(position, w, h, 
                    bloom.bloomCenter, 
                    stemAnchor, stemC, 
                    stemShape, stemWidth,
                    stemVariation,
                    stemLeavesNum,
                    stemLeafType);
  } 

  void display() {
    debugDisplay();
    stem.display();
    bloom.display();
  }

  void debugDisplay() {
    if (debugFlower) {
      fill(230);
      noStroke();
      ellipse(position.x + w/2, position.y + h/2, w/2, w/2);
    }
  }

  void bloomSetup() {
    // Bloom Height
    bloomH = pool.bloomHeightVal(chromosome, h);

    // Bloom Color Major
    bloomC = pool.bloomColorMajorVal(chromosome);

    // Bloom Color Minor
    bloomCM = pool.bloomColorMinorVal(chromosome);
  }

  void stemSetup() {
    // Create the Stem
    stemC = pool.stemColorFill(chromosome);
    
    // TODO: provide variety here
    stemAnchor    = new PVector(w * 0.5 + random(-w/stemBaseVarianceFactor,w/stemBaseVarianceFactor), h);
    stemShape     = pool.stemShape(chromosome);
    stemWidth     = pool.stemWidthVal(chromosome);
    stemVariation = pool.stemVariationVal(chromosome);
    stemLeavesNum = pool.stemLeavesNumVal(chromosome);
    stemLeafType  = pool.leafTypeVal(chromosome);
  }
}

