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
  
  void display(){
   debugDisplay(); 
  }
  
  void debugDisplay(){
    if(debugBloom){
    pushMatrix();
      translate(position.x,position.y);
     // noFill();
     // stroke(0,0,200);
     // line(0,h,w,h);
     fill(mainColor);
     noStroke();
     ellipse(bloomCenter.x,bloomCenter.y,w/4,w/4);
     fill(secColor);
     ellipse(bloomCenter.x,bloomCenter.y,w/6,w/6);
     popMatrix();
    }
  }
}

