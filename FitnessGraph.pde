class FitnessGraph {
  int yBottom, h;

  FitnessGraph(int _yBottom, int _h) {
    yBottom = _yBottom;
    h       = _h;
  } 

  void display() {
    pushMatrix();
    translate(0, yBottom-h);

    fill(0);
    noStroke();
    textFont(titleFont);
    textAlign(LEFT);
    text("A Genetic Algorithm of Flowers", 3, -6);

    textFont(graphFont);
    textAlign(RIGHT);
    text("100% fitness", width*0.9, -1);
    text("0% fitness", width*0.9, 10 + h);

    float pY = map(mendel.tempMostFitPerc, 0, 1, h, 0);
    textAlign(LEFT);
    text(nf(mendel.tempMostFitPerc * 100, 2, 1) + "%", width*0.9 + 5, pY + 3);

    strokeWeight(1);
    fill(240);
    noStroke();
    rect(0, 0, width*0.9, h);
    noFill();

    // Convergence Goal line
    stroke(108, 169, 5);
    strokeWeight(1);
    float goalY = map(convergenceValue, 0, 1, h, 0);
    line(0, goalY, width*0.94, goalY);
    noStroke();
    fill(108, 169, 5);
    textAlign(CENTER);
    text(nf(convergenceValue*100, 2, 1) + "%", width*0.955, goalY + 4);
    text("Convergence at", width*0.955, goalY - 10);
    noFill();



    stroke(200);
    line(0, h/2.0, width*0.9, h/2.0);
    stroke(100, 149, 237); 
    strokeWeight(2);
    float xPos = width * 0.9 - mendel.mostFitScores.size() - 1;
    boolean start = true;
    beginShape();

    float yVal = 0;
    int genCount = 0;
    for (float f: mendel.mostFitScores) {
      xPos += 1;
      genCount += 1;
      if (xPos < 0) {
        continue;
      }
      yVal = map(f, 0, 1, h, 0);
      if (start) {
        curveVertex(xPos, yVal);
        start = false;
      }
      curveVertex(xPos, yVal);

      if (genCount == 1 || genCount % 50 == 0) {
        textAlign(CENTER);
        noStroke();
        fill(180);
        if (genCount == 1) {
          textAlign(RIGHT);
          text("Generation 1", xPos, h-5);
        } 
        else if (genCount % 100 == 0) {
          text(genCount, xPos, h-5);
        } 
        else {
          text(".", xPos, h-5);
        }
        noFill();
        stroke(100, 149, 237);
      }
    }
    curveVertex(xPos, yVal);
    endShape();
    noStroke();
    fill(255, 0, 0);
    ellipse(xPos, yVal, 5, 5);
    popMatrix();
  }
}

