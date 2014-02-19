class Flower {
  PVector position;
  float w, h;
  
  float flowerScale;

  String chromosome;

  Bloom bloom;
  Stem stem;

  float bloomH;
  color bloomC, bloomCM;
  int   bloomStyle, bloomVariant;
  
  color   stemC;
  PVector stemAnchor;
  int     stemShape, stemVariation, stemLeavesNum, stemLeafType, stemLeafPattern, stemLeafHighlight;
  float   stemWidth;

  Flower(PVector tempPos, float tempW, float tempH, float _flowerScale) {
    position = tempPos;
    w = tempW;
    h = tempH;
    flowerScale = _flowerScale;

    chromosome = pool.buildChromosome();
    // println("flower chromosome:" + chromosome);

    bloomSetup();
    stemSetup();
    
    // Create the bloom object
    bloom   = new Bloom(position, w, bloomH, bloomC, bloomCM, bloomStyle, bloomVariant);
    
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
    bloomH = pool.bloomHeightVal(chromosome, h);

    // Bloom Color Major
    bloomC = pool.bloomColorMajorVal(chromosome);

    // Bloom Color Minor
    bloomCM = pool.bloomColorMinorVal(chromosome);
    
    bloomStyle = pool.bloomStyleVal(chromosome);
    
    bloomVariant = pool.bloomVariantVal(chromosome);
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
    stemLeafPattern = pool.leafPatternVal(chromosome);
    stemLeafHighlight = pool.leafHighlightVal(chromosome);
  }
}

