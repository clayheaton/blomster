import java.util.Collections;

float golden = 1.618;
int h = 800;
int w = int(h * golden);

int countWide = 14;
int countHigh = 6;

float secWidth, bigSecWidth;
float secHeight, bigSecHeight;

float stemWidthMin = 3;
float stemWidthMax = 10;
int   stemBaseVarianceFactor = 10; // the lower, the more variance. 1 is min.

boolean debugSector = false;
boolean debugFlower = false;
boolean debugBloom  = true;
boolean debugStem   = false;

ArrayList<ArrayList>sectors;
GenePool pool;

// Gene Ranges {min,max}
float[] bloomHeightRanges = { 0.3,  0.6 };
float[] stemWidthRanges   = { 4.0,  8.0 };
int[]   stemVariationRange= {   1,    7 };

// Do not changes these values
// They are here for reference.
final int STEM_SHAPE_STRAIGHT = 0;
final int STEM_SHAPE_ANGLES   = 1;
final int STEM_SHAPE_CURVES   = 2;

public interface Genes {
    String BLOOM_HEIGHT       = "bloomHeight";
    String BLOOM_COLOR_MAJOR  = "bloomColorMajor";
    String BLOOM_COLOR_MINOR  = "bloomColorMinor";
    String STEM_COLOR         = "stemColor";
    String STEM_SHAPE         = "stemShape";     // jagged or curved
    String STEM_WIDTH         = "stemWidth";
    String STEM_VARIATION     = "stemVariation"; // number of variation points
    String STEM_THORNS        = "stemThorns";    // Does the stem have thorns or not?
}

void setup() {
  if (w % 2 != 0) w+= 1;
  size(w, h);

  randomSeed(8);

  sectors = new ArrayList<ArrayList>();

  // Establish sizes for sectors
  secWidth     = float(w) / countWide;
  bigSecWidth  = 2 * float(w) / countWide;
  secHeight    = float(h) / countHigh;
  bigSecHeight = 2 * float(h) / countHigh;

  // Create the sectors
  // The block on the left
  for (int i=0; i<countHigh;i++) {
    ArrayList<Sector>row = new ArrayList<Sector>();
    for (int j=0;j<countWide;j++) {
      Sector s = new Sector(j*secWidth, i*secHeight, secWidth, secHeight);
      row.add(s);
    }
    sectors.add(row);
  }

  blockBigSector(9, 3);
  
  pool = new GenePool();
  
  makeFlowers();

  smooth();
  frameRate(1);
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
  Sector s = new Sector(xpos*secWidth, ypos*secHeight, bigSecWidth, bigSecHeight);
  s.bigsec = true;
  sectors.get(ypos).add(s);
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
  loop();
}

