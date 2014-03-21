// blomster (flowers) v. 1.0
// A Genetic Algorithm of Flowers
// Clay Heaton - 2014

// The best way to experience this sketch is to first
// put it into random mode (first parameter below) and 
// launch it. The flowers you see are randomly generated.
// Click the mouse to regenerate them and get a sense
// of the variety.

// You then can put it back into genetic mode and 
// launch the sketch to see the population of random
// flowers evolve towards the target. The most fit
// flower in each generation is shown to the left 
// and the target is shown to the right. When the
// genetic algorithm converges, the screen will 
// show a selection of the most fit flowers in the
// generations of the evolution. The earliest 
// generations are represented in the upper-left
// and the later generations are represented in 
// the lower-right.

// Thanks to Daniel Shiffman and The Nature of Code
// http://natureofcode.com/

// Press p to capture a .pdf of the screen,
// which will be saved in your sketch's file.

import java.util.Collections;
import processing.pdf.*;

/* ************************************* */
/* TWEAK TO AFFECT THE GENETIC ALGORITHM */
/* ************************************* */
// Set to 0 for random, 1 for genetic
int mode               = 1;

// For starting the genetic algorithm
// Higher numbers converge more quickly
int populationSize     = 30;   

// Stop after this many and display as if converged
int numGenerations     = 50000;

// Consider converged when this fitness is reached
float convergenceValue = 0.95;

// The percentage chance that a gene will mutate following crossover
float mutationRate     = 0.015;

// You can seed this with a VALID chromosome
// Or leave as "" to start with a random chromosome.
String targetChromosome = "BLMEBNEDCAPACBCF";

// If this is set to true, then the target chromosome
// above always should evolve in the same manner because
// the random number generator always should return the
// same sequence of numbers. 
boolean seedRandomNumberGenerator = false;
/* ************************************* */
/* ************************************* */




/* ************************************* */
/* ************* WARNING *************** */
/* ************************************* */
// Editing most of the values below here or on 
// other tabs may lead to unexpected results
/* ************************************* */
/* ************************************* */


// Change the window size by setting the window height
// Optimized for 800, but will work with larger sizes,
// And down to height of 700 or so without many problems.
int windowHeight = 800;
boolean record = false;

Sector bigSector;
Mendel mendel;
FitnessGraph fitGraph;
boolean converged = false;

// Used to advance a frame without breeding for PDF export
boolean dontBreed = false;

PFont debugFont, mendelFont, graphFont, titleFont;

float golden = 1.618;
int   h      = windowHeight;
int   w      = int(h * golden);

int margH = 40;
int margW = 40;

int countWide = 14; // optimized for 14
int countHigh = 6;  // optimized for 6

float secWidth, bigSecWidth;
float secHeight, bigSecHeight;

int   stemBaseVarianceFactor = 15; // the lower, the more variance. 1 is min.

boolean debugSector = false;
boolean debugFlower = false;
boolean debugBloom  = false;
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
  String STEM_THORNS         = "stemThorns";    // Does the stem have thorns or not? NOT IN USE
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

  if (seedRandomNumberGenerator) randomSeed(565299);


  debugFont  = createFont("Consolas", 12);
  mendelFont = createFont("Inconsolata", 20); //loadFont("CourierNewPS-BoldMT-24.vlw");
  graphFont  = createFont("OpenSans", 12);
  titleFont  = createFont("HighTowerText", 24);


  /*
  debugFont  = loadFont("Consolas-12.vlw");
   mendelFont = loadFont("Inconsolata-20.vlw"); //loadFont("CourierNewPS-BoldMT-24.vlw");
   graphFont  = loadFont("OpenSans-12.vlw");
   titleFont  = loadFont("HighTowerText-Reg-24.vlw");
   */


  textFont(debugFont);

  // Establish sizes for sectors
  secWidth     =     (w - margW/2.0) / countWide;
  bigSecWidth  = 2 * secWidth;
  secHeight    =     (h - margH/2.0) / countHigh;
  bigSecHeight = 2 * secHeight;

  println("secWidth: " + secWidth + ", secHeight: " + secHeight);

  switch(mode) {
  case 0:
    initRandom();
    break;
  case 1:
    initGenetic(targetChromosome);
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
  if (record) {
    beginRecord(PDF, "print-####.pdf");
  }

  background(255);
  drawSectors();


  if (!converged && (mode == 1 && mendel.tempMostFitPerc < convergenceValue)) {
    mendel.breed(1); 
    mendel.display();
    fitGraph.display();
  }

  // Breeding algorithm has run the max # of times.
  if (mode == 1 && mendel.generation > numGenerations) {
    converged = true;
  }

  // Genetic algorithm has converged to the specified fitness level
  // or has already run the max number of allowed times per user parameter.
  if ((converged && !dontBreed)|| (!dontBreed && mode == 1 && mendel.tempMostFitPerc > convergenceValue)) {
    converged = true;
    int pool  = mendel.mostFit.size();

    int sectorsToFill = 0;
    for (ArrayList<Sector> al: sectors) {
      for (Sector s: al) {
        if (!s.dummy && !s.bigsec) {
          sectorsToFill += 1;
        }
      }
    }

    int skip_n        = max((int)(pool / sectorsToFill), 1);
    int indexOfFlower = 0;

    for (ArrayList<Sector> al: sectors) {
      for (Sector s: al) {
        if (!s.dummy && !s.bigsec && !s.flowerMade) {
          if (indexOfFlower > (mendel.mostFit.size() - 1)) {
            break;
          }
          s.makeFlowerWithChromosome(mendel.mostFit.get(indexOfFlower));
          indexOfFlower += skip_n;
        }
      }
    }
  }

  if (converged) {
    background(255);
    drawSectors();
    dontBreed = true;
    noLoop();
  }

  if (mode == 0) {
    noLoop();
  }

  if (record) {
    record = false;
    endRecord();
  }
}










void initGenetic(String target) {
  createSectors();

  if (target.equals("")) {
    // blank, so create random big flower 
    bigSector.makeFlower();
    // then assign its genome to the targetChromosome
    targetChromosome = bigSector.flower.chromosome;
  } 
  else {
    bigSector.makeFlowerWithChromosome(targetChromosome);
  }

  mendel = new Mendel(populationSize, targetChromosome);
  mendel.createInitialPopulation();
  // mendel.breed(numGenerations);

  fitGraph = new FitnessGraph(300, 100);
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

void blockBigSector(int xpos, int ypos) {
  // Mark the small sectors as dummys
  for (int i=ypos;i<ypos + 2; i++) {
    for (int j=xpos;j<xpos + 2; j++) {
      Sector s = (Sector)sectors.get(i).get(j);
      s.dummy = true;
    }
  }

  // Create the large sector
  bigSector = new Sector(xpos*secWidth + margW/4.0, ypos*secHeight + margH/4.0, bigSecWidth, bigSecHeight, 2.0);
  bigSector.bigsec  = true;
  sectors.get(ypos).add(bigSector);
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
  // Add check to make sure we don't make a flower if it already is made
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
  randomSeed(newSeed);

  if (mode == 0) {
    initRandom();
  } 
  else if (mode == 1) {
    targetChromosome = pool.buildChromosome();
    converged = false;
    dontBreed = false;
    initGenetic(targetChromosome);
  }
  loop();
}

void keyPressed() {
  if (key == 'p') {
    record = !record;
    loop();
  }
}

