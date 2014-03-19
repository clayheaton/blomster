class Mendel {

  int generation, genSize;
  String target;

  ArrayList<String> currentGen;
  ArrayList<String> breedingPool;
  ArrayList<String> nextGen;
  ArrayList<String> mostFit;
  FloatList         mostFitScores;
  IntList           scores;
  FloatList         scorePercentages;
  FloatList         fitnessPercentages;

  int               maxPossibleScore;

  float             mutationRate;

  float             tempMostFitPerc;
  String            tempMostFit;
  int               tempBreedingPoolSize;

  Mendel(int _genSize, String _target) {
    generation    = 1;
    genSize       = _genSize;
    target        = _target;
    currentGen    = new ArrayList<String>();
    breedingPool  = new ArrayList<String>();
    nextGen       = new ArrayList<String>();
    mostFit       = new ArrayList<String>();
    mostFitScores = new FloatList();
    scores        = new IntList();
    scorePercentages = new FloatList();
    fitnessPercentages = new FloatList();
    mutationRate     = 0.005;
    tempMostFitPerc  = 0.0;
    tempMostFit      = "";
    tempBreedingPoolSize = 0;
    maxPossibleScore = pool.fitness(target, target);
  }

  // INITIALIZATION AND SCORING

  int fitness(String chromToScore) {
    return pool.fitness(chromToScore, target);
  }

  void createInitialPopulation() {
    for (int i = 0; i < genSize; i++) {
      String chrom = pool.buildChromosome();
      currentGen.add(chrom);
    }
  }

  // DISPLAY
  void display() {
    textFont(mendelFont);
    textAlign(LEFT);
    
    pushMatrix();
    translate(700, 600);
    
    // Draw the most fit flower
    Sector s = new Sector(-secWidth,-50,secWidth,secHeight,1);
    s.makeFlowerWithChromosome(tempMostFit);
    s.display();
    
    fill(255, 0, 0);
    text(target, 0, 0);
    fill(0);
    text(tempMostFit, 0, 30);
    text("Generation: ", 0, 60);
    text(generation, 160, 60);
    text("Peak fitness: ", 0, 90);
    text(tempMostFitPerc, 170, 90);
    text("Breeding Pool Size: ", 0, 120);
    text(tempBreedingPoolSize, 270, 120);
    popMatrix();
  }

  // BREEDING ALGORITHMS

  void breed(int numGenerations) {
    for (int i = 0; i < numGenerations; i++) {
      scorePopulation();
      buildBreedingPool();
      tempBreedingPoolSize = breedingPool.size();
      makeBabies();
      cleanUp();
    }
  }

  void scorePopulation() {
    int totalScore = 0;

    for (String s: currentGen) {
      int score = fitness(s);
      totalScore += score;
      scores.append(score);
    } 

    float maxPerc = 0.0;
    float maxFitnessPerc = 0.0;
    int   maxIndx = -1;

    for (int i = 0; i < scores.size(); i++) {
      // For calculating the breeding pool...
      float perc = (float)scores.get(i)/(float)totalScore;
      scorePercentages.append(perc);

      float fitnessPerc = (float)scores.get(i)/(float)maxPossibleScore;
      fitnessPercentages.append(fitnessPerc);

      if (perc > maxPerc) {
        maxPerc = perc;
        maxIndx = i;
      }

      if (fitnessPerc > maxFitnessPerc) {
        maxFitnessPerc = fitnessPerc;
      }
    }

    // Append the most fit to the mostFit ArrayList
    String fittest = currentGen.get(maxIndx); // Copy here, so as not to change a reference
    mostFit.add(fittest);
    mostFitScores.append(maxFitnessPerc);

    tempMostFitPerc = maxFitnessPerc;
    tempMostFit     = currentGen.get(maxIndx);
  }

  void buildBreedingPool() {
    // Optionally use Monte Carlo method here 
    // See p. 406 of Nature of Code
    for (int i = 0; i < currentGen.size(); i++) {
      int fitness = int(scorePercentages.get(i) * 100);
      for (int j = 0; j < fitness; j++) {
        breedingPool.add(currentGen.get(i));
      }
    }
  }

  void makeBabies() {
    while (nextGen.size () < currentGen.size()) {
      int a = int(random(breedingPool.size()));
      int b = int(random(breedingPool.size()));
      String parentA = breedingPool.get(a);
      String parentB = breedingPool.get(b);
      String child   = crossover(parentA, parentB);
      nextGen.add(child);
    }
  }

  String crossover(String parentA, String parentB) {

    // Version where the child has a 50% chance,
    // for each gene, of getting it from parentA
    // or parentB
    String child = "";
    for (int i = 0; i < parentA.length(); i++) {
      String gene;
      if (random(1) > 0.5) {
        gene = Character.toString(parentA.charAt(i));
      } 
      else {
        gene = Character.toString(parentB.charAt(i));
      } 
      child = child + gene;
    }

    // Version where a random midpoint is chosen
    // and the child gets the genes prior to the
    // midpoint from parentA and after the midpoint
    // from parentB. 
    /*
    String child = "";
     int midpoint = int(random(parentA.length()));
     for (int i = 0; i < parentA.length(); i++) {
     String allele;
     if (i > midpoint) {
     allele = Character.toString(parentA.charAt(i));
     } 
     else {
     allele = Character.toString(parentB.charAt(i));
     }
     child = child + allele;
     } */

    // Perform mutation
    child = mutate(child);

    return child;
  }

  String mutate(String chrom) {
    boolean changeMade = false;
    char[] chromChars = chrom.toCharArray();

    /*
    // Inject the chance for a greater mutation
     float locMutationRate = mutationRate;
     if(random(1) < mutationRate / 10){
     println("Greater mutation.");
     mutationRate = 0.9; 
     }
     */

    for (int i = 0; i < chromChars.length; i++) {
      if (random(1) < mutationRate) {
        changeMade = true; 
        // Perform the mutation
        char newGene = pool.mutationOf(chromChars[i], i);
        chromChars[i] = newGene;
      }
    }

    if (changeMade == true) {
      return String.valueOf(chromChars);
    }
    // No change was made
    return chrom;
  }

  void cleanUp() {
    generation += 1;
    ArrayList<String> newCurrentGen = new ArrayList<String>();

    // Copy each string, just to be certain we protect them
    for (String s: nextGen) {
      String newMember = s;
      newCurrentGen.add(s);
    }

    currentGen.clear();
    breedingPool.clear();
    nextGen.clear();
    scores.clear();
    scorePercentages.clear();

    // Set up the new currentGen
    currentGen = newCurrentGen;
  }
}

