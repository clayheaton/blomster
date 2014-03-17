import java.util.Collections;

int mode = 0; // Set to 0 for random, 1 for genetic

PFont debugFont;

float golden = 1.618;
int h = 1000;
int w = int(h * golden);

int margH = 40;
int margW = 40;

int countWide = 14;
int countHigh = 6;

float secWidth, bigSecWidth;
float secHeight, bigSecHeight;

int   stemBaseVarianceFactor = 15; // the lower, the more variance. 1 is min.

boolean debugSector = false;
boolean debugFlower = false;
boolean debugBloom  = true;
boolean debugStem   = false;

ArrayList<ArrayList>sectors;
GenePool pool;

// Gene Ranges {min,max}
float[] bloomHeightRanges = { 
  0.3, 0.6
};
float[] stemWidthRanges   = { 
  3.0, 6.0
};
int[]   stemVariationRange= {   
  1, 5
};
int[]   bloomVariantRange = {   
  1, 3
};
float[] bloomVariantTwoRange = {
  0.5, 0.8
};
int[]  bloomPetalCountRange = { 
  3, 12
};

// Do not changes these values
// They are here for reference.
final int STEM_SHAPE_STRAIGHT = 0;
final int STEM_SHAPE_ANGLES   = 1;
final int STEM_SHAPE_CURVES   = 2;

final int LEAF_TYPE_THIN      = 0;
final int LEAF_TYPE_ANGLED    = 1;
final int LEAF_TYPE_ROUNDED   = 2;
final int LEAF_TYPE_MULTI     = 4;

final int LEAF_PATTERN_NONE    = 0;
final int LEAF_PATTERN_VEINS   = 1;
final int LEAF_PATTERN_FILLED  = 2;
final int LEAF_PATTERN_CIRCLES = 3;

final int BLOOM_STYLE_DAISY    = 0;
final int BLOOM_STYLE_CUP      = 1;
final int BLOOM_STYLE_DANDY    = 2;
final int BLOOM_STYLE_ANGLED   = 3;
final int BLOOM_STYLE_CIRCLE   = 4;

public interface Genes {
  String BLOOM_HEIGHT        = "bloomHeight";
  String BLOOM_COLOR_MAJOR   = "bloomColorMajor";
  String BLOOM_COLOR_MINOR   = "bloomColorMinor";
  String BLOOM_COLOR_THREE   = "bloomColorThree";
  String BLOOM_STYLE         = "bloomStyle";
  String BLOOM_VARIANT       = "bloomVariant";
  String BLOOM_VARIANT_TWO   = "bloomVariantTwo";
  String BLOOM_PETAL_COUNT   = "bloomPetalCount";
  String STEM_COLOR          = "stemColor";
  String STEM_SHAPE          = "stemShape";     // jagged or curved
  String STEM_WIDTH          = "stemWidth";
  String STEM_VARIATION      = "stemVariation"; // number of variation points
  String STEM_THORNS         = "stemThorns";    // Does the stem have thorns or not?
  String STEM_LEAVES_NUM     = "stemLeavesNum";
  String STEM_LEAF_TYPE      = "stemLeafType";
  String STEM_LEAF_PATTERN   = "stemLeafPattern";
  String STEM_LEAF_HIGHLIGHT = "stemLeafHighlight";
}

void setup() {
  if (w % 2 != 0) w+= 1;
  size(w, h);
  pool    = new GenePool();
  sectors = new ArrayList<ArrayList>();
  //randomSeed(994142);

  debugFont = loadFont("Consolas-12.vlw");
  textFont(debugFont);

  // Establish sizes for sectors
  secWidth     =     (w - margW/2.0) / countWide;
  bigSecWidth  = 2 * secWidth;
  secHeight    =     (h - margH/2.0) / countHigh;
  bigSecHeight = 2 * secHeight;

  switch(mode) {
  case 0:
    initRandom();
    break;
  case 1:
    initGenetic();
    break;
  default:
    initRandom(); 
    break;
  }
  // initialize(); // use for random flowers

  smooth();
  frameRate(10);
  background(255);
}

void draw() {
  background(255);
  drawSectors();
  noLoop();
}

void blockBigSector(int xpos, int ypos) {
  // Mark the small sectors as dummys
  for (int i=ypos;i<ypos + 2; i++) {
    for (int j=xpos;j<xpos + 2; j++) {
      Sector s = (Sector)sectors.get(i).get(j);
      s.dummy = true;
    }
  }

  // Create the large sector
  Sector s = new Sector(xpos*secWidth + margW/4.0, ypos*secHeight + margH/4.0, bigSecWidth, bigSecHeight, 2.0);
  s.bigsec = true;
  sectors.get(ypos).add(s);
}

void initGenetic() {
  createSectors();
}

void createSectors() {
  // Create the sectors
  // The block on the left
  for (int i=0; i<countHigh;i++) {
    ArrayList<Sector>row = new ArrayList<Sector>();
    for (int j=0;j<countWide;j++) {
      Sector s = new Sector(j*secWidth + margW/4.0, i*secHeight + margH/4.0, secWidth, secHeight, 1.0);
      s.xCoord = j;
      s.yCoord = i;
      row.add(s);
    }
    sectors.add(row);
  }

  blockBigSector(9, 3);
}

void initRandom() {
  createSectors();
  makeFlowers();
}

void drawSectors() {
  for (ArrayList<Sector> a : sectors) {
    for (Sector s: a) {
      s.display();
    }
  }
}

void makeFlowers() {

  // Make flowers
  for (ArrayList<Sector> a : sectors) {
    for (Sector s : a) {
      s.makeFlower();
    }
  }
}

void mouseClicked() {
  sectors.clear();

  int newSeed = (int)random(1, 999999);
  println("seed: " + newSeed);
  randomSeed(newSeed);

  initRandom();
  loop();
}

