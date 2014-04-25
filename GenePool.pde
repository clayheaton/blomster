// Goal is to have 20 variations on each gene

class GenePool {
  String allelePool;
  HashMap<String, Integer> geneMap;

  FloatList bloomHeightValues;
  ArrayList<IAAColor> bloomColorValues;
  ArrayList<IAAColor> stemColorValues;
  ArrayList<IAAColor> bloomColorThreeValues;
  IntList stemShapeValues;
  FloatList stemWidthValues;
  IntList stemVariationValues;
  IntList stemLeavesNumValues;
  IntList leafTypeValues;
  IntList leafPatternValues;
  IntList bloomStyleValues;
  IntList bloomVariantValues;
  IntList bloomPetalCountValues;
  FloatList bloomVariantTwoValues;

  GenePool() {
    allelePool = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    geneMap                = new HashMap<String, Integer>();
    bloomHeightValues      = new FloatList();
    bloomColorValues       = new ArrayList<IAAColor>();
    bloomColorThreeValues  = new ArrayList<IAAColor>();
    stemColorValues        = new ArrayList<IAAColor>();
    stemShapeValues        = new IntList();
    stemWidthValues        = new FloatList();
    stemVariationValues    = new IntList();
    stemLeavesNumValues    = new IntList();
    leafTypeValues         = new IntList();
    leafPatternValues      = new IntList();
    bloomStyleValues       = new IntList();
    bloomVariantValues     = new IntList();
    bloomPetalCountValues  = new IntList();
    bloomVariantTwoValues  = new FloatList();

    setupGenes();
  }


  // SCORING GENES *******************

  int fitness(String chromToScore, String target) {
    // Take the negative of the absolute value of the difference
    // for each chromosome and sum them

    int score        = 0;
    int countCorrect = 0;

    for (int i = 0; i < target.length(); i++) {
      int scoreVal  = allelePool.indexOf(chromToScore.charAt(i));
      int targetVal = allelePool.indexOf(target.charAt(i));

      if (scoreVal != targetVal) {
        // penalty for being wrong.
        // score -= 8;
      } 
      else {
        score += 1;//100;
        countCorrect += 1; // Not used
      }

      // score -= abs(scoreVal - targetVal);
    }

    return score;// + countCorrect;
  }

  // MUTATING GENES ******************
  char mutationOf(char gene, int genePosition) {

    // Here's how they map
    //  0: bloom height
    //  1: bloom color major
    //  2: bloom color minor
    //  3: stem color
    //  4: stem shape
    //  5: stem width
    //  6: stem variation
    //  7: stem leaves num
    //  8: leaf type num
    //  9: leaf pattern num
    // 10: leaf highlight color
    // 11: bloom style
    // 12: bloom variant
    // 13: bloom color three
    // 14: bloom petal count
    // 15: bloom variant two

    String newGene;

    switch(genePosition) {
    case 0:
      newGene = chooseBloomHeight();
      break;
    case 1:
      newGene = chooseBloomColorMajor();
      break;
    case 2:
      newGene = chooseBloomColorMinor();
      break;
    case 3:
      newGene = chooseStemColor();
      break;
    case 4:
      newGene = chooseStemShape();
      break;
    case 5:
      newGene = chooseStemWidth();
      break;
    case 6:
      newGene = chooseStemVariation();
      break;
    case 7:
      newGene = chooseStemLeavesNum();
      break;
    case 8:
      newGene = chooseLeafTypeNum();
      break;
    case 9:
      newGene = chooseLeafPatternNum();
      break;
    case 10:
      newGene = chooseLeafHighlightColor();
      break;
    case 11:
      newGene = chooseBloomStyle();
      break;
    case 12:
      newGene = chooseBloomVariant();
      break;
    case 13:
      newGene = chooseBloomColorThree();
      break;
    case 14:
      newGene = chooseBloomPetalCount();
      break;
    case 15:
      newGene = chooseBloomVariantTwo();
      break;
    default:
      println("MUTATION ERROR");
      return gene;
    }
    char newGeneAsChar = newGene.charAt(0);
    return newGeneAsChar;
  }


  // ESTABLISHING GENES **************

  // For establishing chromosomes
  void setupGenes() {
    setupBloomHeight();
    setupBloomColor();
    setupStemColor();
    setupStemShape();
    setupStemWidth();
    setupStemVariation();
    setupStemLeavesNumber();
    setupLeafTypes();
    setupLeafPatterns();
    setupStemLeafHighlight();
    setupBloomStyle();
    setupBloomVariant();
    setupBloomPetalCount();
    setupBloomVariantTwo(); // Controls the shape of inset colors on angular petal flowers
  }

  String buildChromosome(String chromToAvoid) {
    String c       = buildChromosome();
    char[] c_array = c.toCharArray();
    
    // Avoiding color matches with genes at positions 1, 2, 3, and 10
    // in the starting pool when running in genetic mode
    int[] check = {1,2,3,10};
    
    for(int i = 0; i < check.length; i++){
      char c_i = c_array[check[i]];
      char a_i = chromToAvoid.charAt(check[i]);
      c_array[check[i]] = nonMatchingGene(c_i,a_i,check[i]);
    }
    
    String d = String.valueOf(c_array);

    return d;
  }

  // For populating the 'random' pool when starting a genetic run
  char nonMatchingGene(char gene, char geneToAvoid, int index) {
    while (gene == geneToAvoid) {
      gene = mutationOf(gene, index);
    }
    return gene;
  }


  String buildChromosome() {
    String chromosome = "";
    String c, d;

    // BLOOM HEIGHT
    c = chooseBloomHeight();
    chromosome = chromosome + c;

    // BLOOM COLOR - MAJOR
    c = chooseBloomColorMajor();
    chromosome = chromosome + c;

    // BLOOM COLOR - MINOR
    d = chooseBloomColorMinor();
    while (c.equals (d)) {
      d = chooseBloomColorMinor();
    }
    chromosome = chromosome + d;

    // STEM COLOR
    c = chooseStemColor();
    chromosome = chromosome + c;

    // STEM SHAPE
    c = chooseStemShape();
    chromosome = chromosome + c;

    // STEM WIDTH
    c = chooseStemWidth();
    chromosome = chromosome + c;

    // STEM VARIATION
    c = chooseStemVariation();
    chromosome = chromosome + c;

    // STEM LEAVES NUM
    c = chooseStemLeavesNum();
    chromosome = chromosome + c;

    // LEAF TYPE NUM
    c = chooseLeafTypeNum();
    chromosome = chromosome + c;

    // LEAF PATTERN NUM
    c = chooseLeafPatternNum();
    chromosome = chromosome + c;

    // LEAF HIGHLIGHT COLOR
    c = chooseLeafHighlightColor();
    chromosome = chromosome + c;

    // BLOOM STYLE
    c = chooseBloomStyle();
    chromosome = chromosome + c;

    // BLOOM VARIANT
    c = chooseBloomVariant();
    chromosome = chromosome + c;

    // BLOOM COLOR THREE
    c = chooseBloomColorThree();
    chromosome = chromosome + c;

    // BLOOM PETAL COUNT
    c = chooseBloomPetalCount();
    chromosome = chromosome + c;

    // BLOOM VARIANT TWO
    c = chooseBloomVariantTwo();
    chromosome = chromosome + c;

    return chromosome;
  }




  // ************************************************************
  // These functions assist with the mutation of genes
  // and are used in the construction of chromosomes.
  // They are broken out so that they can be called gene
  // by gene when a mutation happens.
  // ************************************************************

  String chooseBloomHeight() {
    int bhRand = (int)random(0, bloomHeightValues.size());
    return alleleAssignment(bhRand);
  }

  String chooseBloomColorMajor() {
    int bhColor = (int)random(0, bloomColorValues.size());
    return alleleAssignment(bhColor);
  }

  String chooseBloomColorMinor() {
    int bhColor = (int)random(0, bloomColorValues.size());
    return alleleAssignment(bhColor);
  }

  String chooseStemColor() {
    int stemColor = (int)random(0, stemColorValues.size());
    return alleleAssignment(stemColor);
  }

  String chooseStemShape() {
    int stemShapeDec = (int)random(0, 100);
    int stemShape;
    if (stemShapeDec < 34) {
      stemShape = 0;
    } 
    else if (stemShapeDec >= 34 && stemShapeDec < 67) {
      stemShape = 1;
    } 
    else {
      stemShape = 2;
    }
    return alleleAssignment(stemShape);
  }

  String chooseStemWidth() {
    int swRand = (int)random(0, stemWidthValues.size());
    return alleleAssignment(swRand);
  }

  String chooseStemVariation() {
    int stemVariation = (int)random(0, stemVariationValues.size());
    return alleleAssignment(stemVariation);
  }

  String chooseStemLeavesNum() {
    int stemLeavesNum = (int)random(1, stemLeavesNumValues.size());
    return alleleAssignment(stemLeavesNum);
  }

  String chooseLeafTypeNum() {
    int leafTypeNum = (int)random(0, leafTypeValues.size());
    return alleleAssignment(leafTypeNum);
  }

  String chooseLeafPatternNum() {
    int leafPatternNum = (int)random(0, leafPatternValues.size());
    return alleleAssignment(leafPatternNum);
  }

  String chooseLeafHighlightColor() {
    int leafHighlightColor = (int)random(0, stemColorValues.size());
    return alleleAssignment(leafHighlightColor);
  }

  String chooseBloomStyle() {
    int bloomStyle = (int)random(0, bloomStyleValues.size());
    return alleleAssignment(bloomStyle);
  }

  String chooseBloomVariant() {
    int bloomVariant = (int)random(0, bloomVariantValues.size());
    return alleleAssignment(bloomVariant);
  }

  String chooseBloomColorThree() {
    int bhColorThree = (int)random(0, bloomColorThreeValues.size());
    return alleleAssignment(bhColorThree);
  }

  String chooseBloomPetalCount() {
    int blPetCt = (int)random(0, bloomPetalCountValues.size());
    return alleleAssignment(blPetCt);
  }

  String chooseBloomVariantTwo() {
    int blVar2 = (int)random(0, bloomVariantTwoValues.size());
    return alleleAssignment(blVar2);
  }


  // **********************************************************************
  // END OF MUTATION SUPPORTING FUNCTIONS
  // **********************************************************************




  String alleleAssignment(int number) {
    String allele     = Character.toString(allelePool.charAt(number));
    return allele;
  }

  int alleleIndexForGene(String chromosome, String chromCode) {
    char c = chromosome.charAt(geneMap.get(chromCode));
    return allelePool.indexOf(c);
  }


  // Bloom Height
  float bloomHeightVal(String chrom, float h) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_HEIGHT);
    return bloomHeightValues.get(index) * h;
  }

  void setupBloomHeight() {
    // Index 0 in allelePool
    geneMap.put(Genes.BLOOM_HEIGHT, 0);


    float range = bloomHeightRanges[1] - bloomHeightRanges[0];
    float increment = range / 19;
    bloomHeightValues.append(bloomHeightRanges[0]);
    for (int i=0; i<18; i++) {
      float newVal = bloomHeightValues.get(i) + increment;
      bloomHeightValues.append(newVal);
    }
    bloomHeightValues.append(bloomHeightRanges[1]);
  }

  // Bloom Color
  color bloomColorMajorVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_COLOR_MAJOR);
    return bloomColorValues.get(index).getColor();
  }

  color bloomColorMinorVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_COLOR_MINOR);
    return bloomColorValues.get(index).getColor();
  }

  color bloomColorThreeVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_COLOR_THREE);
    return bloomColorThreeValues.get(index).getColor();
  }

  void setupBloomColor() {
    geneMap.put(Genes.BLOOM_COLOR_MAJOR, 1);
    geneMap.put(Genes.BLOOM_COLOR_MINOR, 2);

    bloomColorValues.add(new IAAColor(color(  97, 4, 103 )));
    bloomColorValues.add(new IAAColor(color(  95, 67, 158 )));
    bloomColorValues.add(new IAAColor(color( 127, 0, 255 )));
    bloomColorValues.add(new IAAColor(color( 190, 74, 248 )));
    bloomColorValues.add(new IAAColor(color( 203, 135, 255 ))); // mauve
    bloomColorValues.add(new IAAColor(color( 251, 67, 212 )));
    bloomColorValues.add(new IAAColor(color( 185, 16, 109 )));
    bloomColorValues.add(new IAAColor(color( 186, 12, 60 )));
    bloomColorValues.add(new IAAColor(color( 217, 0, 3 )));
    bloomColorValues.add(new IAAColor(color( 231, 0, 56 )));
    bloomColorValues.add(new IAAColor(color( 252, 78, 4 )));
    bloomColorValues.add(new IAAColor(color( 248, 149, 9 )));  
    bloomColorValues.add(new IAAColor(color( 251, 216, 46 ))); // gold
    bloomColorValues.add(new IAAColor(color( 235, 238, 22 ))); // yellow
    
    bloomColorValues.add(new IAAColor(color( 150, 170, 255 )));
    bloomColorValues.add(new IAAColor(color( 118, 192, 216 ))); 
    bloomColorValues.add(new IAAColor(color(   2, 173, 175 )));
    bloomColorValues.add(new IAAColor(color(  67, 187, 251 )));
    bloomColorValues.add(new IAAColor(color( 51, 153, 255 ))); // blue
    bloomColorValues.add(new IAAColor(color(  81, 117, 209 )));
    bloomColorValues.add(new IAAColor(color(  26, 106, 234 )));
    bloomColorValues.add(new IAAColor(color(  36, 55, 130 )));

    geneMap.put(Genes.BLOOM_COLOR_THREE, 13);
    bloomColorThreeValues.add(new IAAColor(color(0)));
    bloomColorThreeValues.add(new IAAColor(color(255)));
  }

  // Stem color

  color stemColorFill(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_COLOR);
    return stemColorValues.get(index).getColor();
  }

  void setupStemColor() {
    geneMap.put(Genes.STEM_COLOR, 3);

    stemColorValues.add(new IAAColor(color( 0, 76, 0 )));
    stemColorValues.add(new IAAColor(color( 0, 96, 0 )));
    stemColorValues.add(new IAAColor(color( 1, 112, 25 )));
    stemColorValues.add(new IAAColor(color( 51, 102, 51 )));
    stemColorValues.add(new IAAColor(color( 72, 142, 72 )));
    stemColorValues.add(new IAAColor(color( 59, 76, 0 )));
    stemColorValues.add(new IAAColor(color( 66, 90, 0 )));
    stemColorValues.add(new IAAColor(color( 79, 115, 27 )));
    stemColorValues.add(new IAAColor(color( 82, 128, 41 )));
    stemColorValues.add(new IAAColor(color( 108, 165, 5)));
    stemColorValues.add(new IAAColor(color( 124, 169, 0 )));
    stemColorValues.add(new IAAColor(color( 154, 204, 52 )));
    stemColorValues.add(new IAAColor(color( 120, 195, 29 )));
    stemColorValues.add(new IAAColor(color( 144, 229, 59 )));
    stemColorValues.add(new IAAColor(color( 84, 212, 84 )));
    stemColorValues.add(new IAAColor(color( 86, 197, 86 )));
    stemColorValues.add(new IAAColor(color( 51, 153, 51 )));
    stemColorValues.add(new IAAColor(color( 47, 171, 47 )));
    stemColorValues.add(new IAAColor(color(   2, 165, 57 )));
    stemColorValues.add(new IAAColor(color( 0, 204, 0 )));
  }

  // Stem Shape
  void setupStemShape() {
    geneMap.put(Genes.STEM_SHAPE, 4);
    stemShapeValues.append(STEM_SHAPE_STRAIGHT); // straight
    stemShapeValues.append(STEM_SHAPE_ANGLES); // angles
    stemShapeValues.append(STEM_SHAPE_CURVES); // curves
  }

  int stemShape(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_SHAPE);
    return stemShapeValues.get(index);
  }


  // Stem Width
  void setupStemWidth() {
    // Index 5 in allelePool
    geneMap.put(Genes.STEM_WIDTH, 5);

    float range = stemWidthRanges[1] - stemWidthRanges[0];
    float increment = range / 19;
    stemWidthValues.append(stemWidthRanges[0]);
    for (int i=0; i<18; i++) {
      float newVal = stemWidthValues.get(i) + increment;
      stemWidthValues.append(newVal);
    }
    stemWidthValues.append(stemWidthRanges[1]);
  }

  float stemWidthVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_WIDTH);
    return stemWidthValues.get(index);
  }

  // Stem Variation
  void setupStemVariation() {
    // Index 6 in allelePool
    geneMap.put(Genes.STEM_VARIATION, 6);
    int numValues = stemVariationRange[1] - stemVariationRange[0];
    for (int i = 0; i < numValues + 1; i++) {
      stemVariationValues.append(stemVariationRange[0] + i);
    }
  }

  int stemVariationVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_VARIATION);
    return stemVariationValues.get(index);
  }

  // Stem Leaves Number
  void setupStemLeavesNumber() {
    // Index 7 in allelePool
    geneMap.put(Genes.STEM_LEAVES_NUM, 7);
    int numValues = stemVariationRange[1] - stemVariationRange[0];
    numValues = min(numValues, 3); // TODO: Possibly change
    stemLeavesNumValues.append(0);
    for (int i = 0; i < numValues + 1; i++) {
      stemLeavesNumValues.append(stemVariationRange[0] + i);
    }
  }

  int stemLeavesNumVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_LEAVES_NUM);
    return stemLeavesNumValues.get(index);
  }

  // Leaf Types
  void setupLeafTypes() {
    // Index 8 in allelePool
    geneMap.put(Genes.STEM_LEAF_TYPE, 8);
    leafTypeValues.append(LEAF_TYPE_THIN); // straight
    leafTypeValues.append(LEAF_TYPE_ANGLED); // angles
    leafTypeValues.append(LEAF_TYPE_ROUNDED); // curves
    leafTypeValues.append(LEAF_TYPE_OVAL); // curves
    leafTypeValues.append(LEAF_TYPE_MULTI);
  }

  int leafTypeVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_LEAF_TYPE);
    return leafTypeValues.get(index);
  }

  // Leaf Patterns
  void setupLeafPatterns() {
    // Index 9 in allelePool
    geneMap.put(Genes.STEM_LEAF_PATTERN, 9);
    leafPatternValues.append(LEAF_PATTERN_NONE); 
    leafPatternValues.append(LEAF_PATTERN_VEINS);
    leafPatternValues.append(LEAF_PATTERN_FILLED);
    leafPatternValues.append(LEAF_PATTERN_CIRCLES);
  }

  int leafPatternVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_LEAF_PATTERN);
    return leafPatternValues.get(index);
  }

  // Stem Leaf Highlight -- alt green shades.
  void setupStemLeafHighlight() {
    geneMap.put(Genes.STEM_LEAF_HIGHLIGHT, 10);
  }

  color leafHighlightVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_LEAF_HIGHLIGHT);
    return stemColorValues.get(index).getColor();
  }

  // Bloom Style
  void setupBloomStyle() {
    geneMap.put(Genes.BLOOM_STYLE, 11);
    bloomStyleValues.append(BLOOM_STYLE_DAISY);
    bloomStyleValues.append(BLOOM_STYLE_CUP);
    bloomStyleValues.append(BLOOM_STYLE_DANDY);
    bloomStyleValues.append(BLOOM_STYLE_ANGLED);
    bloomStyleValues.append(BLOOM_STYLE_CIRCLE);
  }

  int bloomStyleVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_STYLE);
    return bloomStyleValues.get(index);
  }

  // Bloom Variant
  void setupBloomVariant() {
    geneMap.put(Genes.BLOOM_VARIANT, 12);
    int numValues = bloomVariantRange[1] - bloomVariantRange[0];

    for (int i = 0; i < numValues + 1; i++) {
      bloomVariantValues.append(bloomVariantRange[0] + i);
    }
  }

  int bloomVariantVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_VARIANT);
    return bloomVariantValues.get(index);
  }

  // GENE 13 IS BLOOM_COLOR_THREE

  // Bloom Petal Count
  void setupBloomPetalCount() {
    geneMap.put(Genes.BLOOM_PETAL_COUNT, 14);
    int numValues = bloomPetalCountRange[1] - bloomPetalCountRange[0];

    for (int i = 0; i < numValues + 1; i++) {
      bloomPetalCountValues.append(bloomPetalCountRange[0] + i);
    }
  }

  int bloomPetalCountVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_PETAL_COUNT);
    return bloomPetalCountValues.get(index);
  }

  // Bloom Variant Two
  void setupBloomVariantTwo() {
    geneMap.put(Genes.BLOOM_VARIANT_TWO, 15);
    float range = bloomVariantTwoRange[1] - bloomVariantTwoRange[0];
    float increment = range / 10.0;
    bloomVariantTwoValues.append(bloomVariantTwoRange[0]);
    for (int i=0; i<9; i++) {
      float newVal = bloomVariantTwoValues.get(i) + increment;
      bloomVariantTwoValues.append(newVal);
    }
    bloomVariantTwoValues.append(bloomVariantTwoRange[1]);
    // println("bloomVariantTwoValues: " + bloomVariantTwoValues);
  }

  float bloomVariantTwoVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.BLOOM_VARIANT_TWO);
    return bloomVariantTwoValues.get(index);
  }
}

