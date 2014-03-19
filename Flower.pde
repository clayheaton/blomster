class Flower {
  PVector position;
  float w, h;

  float flowerScale;

  String chromosome;

  Bloom bloom;
  Stem stem;

  float bloomH;
  color bloomC, bloomCM, bloomColor3;
  int   bloomStyle, bloomVariant, bloomPetalCount;
  float bloomVariantTwo;

  color   stemC;
  PVector stemAnchor;
  int     stemShape, stemVariation, stemLeavesNum, stemLeafType, stemLeafPattern, stemLeafHighlight;
  float   stemWidth;

  Flower(PVector tempPos, float tempW, float tempH, float _flowerScale) {
    position    = tempPos;
    w           = tempW;
    h           = tempH;
    flowerScale = _flowerScale;
    chromosome  = pool.buildChromosome();    
    finishFlowerSetup();
  } 

  // Alternate constructor for seeding the flower with a gene (for the GA algorithm)
  Flower(PVector tempPos, float tempW, float tempH, float _flowerScale, String _chromosome) {
    position    = tempPos;
    w           = tempW;
    h           = tempH;
    flowerScale = _flowerScale;
    chromosome  = _chromosome;    
    finishFlowerSetup();
  } 


  void finishFlowerSetup() {
    bloomSetup();
    stemSetup();

    // Create the bloom object
    bloom   = new Bloom(position, w, bloomH, bloomC, bloomCM, bloomColor3, bloomStyle, bloomVariant, flowerScale, bloomPetalCount, bloomVariantTwo);

    // Create the stem object
    stem = new Stem(position, w, h, 
    bloom.bloomCenter, 
    stemAnchor, stemC, 
    stemShape, stemWidth, 
    stemVariation, 
    stemLeavesNum, 
    stemLeafType, 
    stemLeafPattern, 
    flowerScale, 
    stemLeafHighlight);
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
    bloomH          = pool.bloomHeightVal(chromosome, h);
    bloomC          = pool.bloomColorMajorVal(chromosome);
    bloomCM         = pool.bloomColorMinorVal(chromosome);
    bloomColor3     = pool.bloomColorThreeVal(chromosome);
    bloomStyle      = pool.bloomStyleVal(chromosome);
    bloomVariant    = pool.bloomVariantVal(chromosome);
    bloomPetalCount = pool.bloomPetalCountVal(chromosome);
    bloomVariantTwo = pool.bloomVariantTwoVal(chromosome);
  }

  void stemSetup() {
    // Create the Stem
    stemC = pool.stemColorFill(chromosome);

    // TODO: provide variety here
    stemAnchor    = new PVector(w * 0.5 + random(-w/stemBaseVarianceFactor, w/stemBaseVarianceFactor), h);
    stemShape     = pool.stemShape(chromosome);
    stemWidth     = pool.stemWidthVal(chromosome);
    stemVariation = pool.stemVariationVal(chromosome);
    stemLeavesNum = pool.stemLeavesNumVal(chromosome);
    stemLeafType  = pool.leafTypeVal(chromosome);
    stemLeafPattern = pool.leafPatternVal(chromosome);
    stemLeafHighlight = pool.leafHighlightVal(chromosome);
  }
}

