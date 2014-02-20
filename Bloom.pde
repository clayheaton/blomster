class Bloom {
  PVector position, bloomCenter;
  float w, h;
  color mainColor, secColor;
  int bloomStyle, bloomVariant;

  Bloom(PVector tempPosition, float tempW, float tempH, color _c, color _cm, int _bloomStyle, int _bloomVariant) {
    position = tempPosition;
    w = tempW;
    h = tempH;
    bloomCenter = new PVector(w * 0.5, h * 0.75);
    mainColor = _c;
    secColor  = _cm;
    bloomStyle = _bloomStyle;
    bloomVariant = _bloomVariant;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    switch(bloomStyle) {
    case BLOOM_STYLE_CUP:
      displayCupStyle();
      break;
    default:
      debugDisplay();
    }
    popMatrix();
  }

  void displayCupStyle() {
     drawCup(mainColor,1.0, 0);  
     drawCup(secColor ,0.5, w/32.0);
  }
  
  void drawCup(color c, float scale, float yOffset){
    fill(c);
    
    float dist1 = (w/8)  * scale;
    float dist2 = (w/5)  * scale;
    float dist3 = (w/12) * scale;
    float dist4 = (w/16) * scale;
    
    
    beginShape();
      curveVertex( bloomCenter.x,         bloomCenter.y + dist1 + yOffset );
      curveVertex( bloomCenter.x,         bloomCenter.y + dist1 + yOffset  );
      curveVertex( bloomCenter.x + dist1, bloomCenter.y + dist4 + yOffset  );
      curveVertex( bloomCenter.x + dist2, bloomCenter.y - dist1 + yOffset  );
      curveVertex( bloomCenter.x + dist3, bloomCenter.y - dist4 + yOffset  );
      curveVertex( bloomCenter.x,         bloomCenter.y - dist1 + yOffset  );
      curveVertex( bloomCenter.x - dist3, bloomCenter.y - dist4 + yOffset  );
      curveVertex( bloomCenter.x - dist2, bloomCenter.y - dist1 + yOffset  );
      curveVertex( bloomCenter.x - dist1, bloomCenter.y + dist4 + yOffset  );
      curveVertex( bloomCenter.x,         bloomCenter.y + dist1 + yOffset  );
      curveVertex( bloomCenter.x,         bloomCenter.y + dist1 + yOffset  );
    endShape();
  }

  void debugDisplay() {
    if (debugBloom) {
      fill(mainColor);
      noStroke();
      ellipse(bloomCenter.x, bloomCenter.y, w/4, w/4);
      fill(secColor);
      ellipse(bloomCenter.x, bloomCenter.y, w/6, w/6);
    }
  }
}

