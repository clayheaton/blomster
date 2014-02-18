// Goal is to have 20 variations on each gene

class GenePool {
  String allelePool;
  HashMap<String, Integer> geneMap;

  FloatList bloomHeightValues;
  ArrayList<IAAColor> bloomColorValues;
  ArrayList<IAAColor> stemColorValues;
  IntList stemShapeValues;
  FloatList stemWidthValues;
  IntList stemVariationValues;
  IntList stemLeavesNumValues;
  IntList leafTypeValues;

  GenePool() {
    allelePool = "ABCDEFGHIJKLMNOPQRST";
    geneMap           = new HashMap<String, Integer>();
    bloomHeightValues = new FloatList();
    bloomColorValues  = new ArrayList<IAAColor>();
    stemColorValues   = new ArrayList<IAAColor>();
    stemShapeValues   = new IntList();
    stemWidthValues   = new FloatList();
    stemVariationValues = new IntList();
    stemLeavesNumValues = new IntList();
    leafTypeValues    = new IntList();

    setupGenes();
  }

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
  }

  String buildChromosome() {
    // for each gene, get a random number between 0 and 19,
    // then get the allele for that number and add it to this string
    String chromosome = "";

    // bloomHeight
    int bhRand = (int)random(0, 19);
    chromosome = chromosome + alleleAssignment(bhRand);

    // bloomColorMajor
    int bhColor = (int)random(0, 19);
    chromosome = chromosome + alleleAssignment(bhColor);

    // bloomColorMinor
    int bhColorM = (int)random(0, 19);
    chromosome   = chromosome + alleleAssignment(bhColorM);

    // stemColor
    int stemColor = (int)random(0, 19);
    chromosome = chromosome + alleleAssignment(stemColor);

    // stemShape
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
    chromosome = chromosome + alleleAssignment(stemShape);

    // stemWidth
    int swRand = (int)random(0, 19);
    chromosome = chromosome + alleleAssignment(swRand);

    // stemVariation 
    int maxIndex = stemVariationValues.size(); // POSSIBLE BUG: might need to -1 on maxIndex
    int stemVariation = (int)random(0, maxIndex);
    chromosome = chromosome + alleleAssignment(stemVariation);

    // stem leaves number
    maxIndex = stemLeavesNumValues.size();
    int stemLeavesNum = (int)random(0, maxIndex);
    chromosome = chromosome + alleleAssignment(stemLeavesNum);
    
    // Leaf types
    maxIndex = leafTypeValues.size();
    int leafTypeNum = (int)random(0,maxIndex);
    chromosome = chromosome + alleleAssignment(leafTypeNum);

    return chromosome;
  }


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

  void setupBloomColor() {
    geneMap.put(Genes.BLOOM_COLOR_MAJOR, 1);
    geneMap.put(Genes.BLOOM_COLOR_MINOR, 2);

    bloomColorValues.add(new IAAColor(color( 231, 0, 56 )));
    bloomColorValues.add(new IAAColor(color( 231, 229, 46 )));
    bloomColorValues.add(new IAAColor(color(  95, 67, 178 )));
    bloomColorValues.add(new IAAColor(color( 203, 195, 244 )));
    bloomColorValues.add(new IAAColor(color( 252, 78, 4 )));
    bloomColorValues.add(new IAAColor(color( 51, 153, 255 )));
    bloomColorValues.add(new IAAColor(color( 190, 74, 248 )));
    bloomColorValues.add(new IAAColor(color( 251, 216, 46 )));
    bloomColorValues.add(new IAAColor(color(  81, 117, 209 )));
    bloomColorValues.add(new IAAColor(color(  36, 55, 130 )));
    bloomColorValues.add(new IAAColor(color(  97, 4, 103 )));
    bloomColorValues.add(new IAAColor(color( 118, 192, 216 )));
    bloomColorValues.add(new IAAColor(color( 248, 109, 9 )));
    bloomColorValues.add(new IAAColor(color( 207, 0, 3 )));
    bloomColorValues.add(new IAAColor(color( 236, 12, 2 )));
    bloomColorValues.add(new IAAColor(color( 146, 211, 153 )));
    bloomColorValues.add(new IAAColor(color(   2, 173, 175 )));
    bloomColorValues.add(new IAAColor(color( 251, 67, 212 )));
    bloomColorValues.add(new IAAColor(color(  67, 187, 251 )));
    bloomColorValues.add(new IAAColor(color( 237, 176, 176 )));
  }

  // Stem color

  color stemColorFill(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_COLOR);
    return stemColorValues.get(index).getColor();
  }

  void setupStemColor() {
    geneMap.put(Genes.STEM_COLOR, 3);

    stemColorValues.add(new IAAColor(color( 92, 142, 92 )));
    stemColorValues.add(new IAAColor(color( 153, 255, 153 )));
    stemColorValues.add(new IAAColor(color( 102, 255, 102 )));
    stemColorValues.add(new IAAColor(color( 51, 255, 51 )));
    stemColorValues.add(new IAAColor(color( 144, 169, 0 )));
    stemColorValues.add(new IAAColor(color( 153, 204, 153 )));
    stemColorValues.add(new IAAColor(color( 102, 204, 102 )));
    stemColorValues.add(new IAAColor(color( 154, 204, 52 )));
    stemColorValues.add(new IAAColor(color( 0, 204, 0 )));
    stemColorValues.add(new IAAColor(color( 153, 153, 102 )));
    stemColorValues.add(new IAAColor(color( 51, 153, 51 )));
    stemColorValues.add(new IAAColor(color( 86, 197, 86 )));
    stemColorValues.add(new IAAColor(color( 51, 102, 51 )));
    stemColorValues.add(new IAAColor(color( 0, 102, 0 )));
    stemColorValues.add(new IAAColor(color( 0, 76, 0 )));
    stemColorValues.add(new IAAColor(color( 59, 76, 0 )));
    stemColorValues.add(new IAAColor(color( 82, 128, 41 )));
    stemColorValues.add(new IAAColor(color( 180, 185, 69 )));
    stemColorValues.add(new IAAColor(color( 180, 148, 69 )));
    stemColorValues.add(new IAAColor(color( 132, 95, 95 )));
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
    numValues = min(numValues,3); // TODO: Possibly change
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
    leafTypeValues.append(LEAF_TYPE_MULTI);
  }

  int leafTypeVal(String chrom) {
    int index = alleleIndexForGene(chrom, Genes.STEM_LEAF_TYPE);
    return leafTypeValues.get(index);
  }
}

