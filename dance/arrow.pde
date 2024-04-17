class arrow {
  PVector pos;
  PImage arrowImg;
  int type;

  boolean isDisplay;
  boolean isHit;

  arrow(PVector pos, PImage arrowImg, int type, boolean isDisplay) {
    this.pos = pos;
    this.arrowImg = arrowImg;
    this.type = type;
    this.isDisplay = isDisplay;
  }


  boolean update(int id) {
    boolean hit = false;
    
    if (directions[type]) {
      //if(id==4 || id==5) println(pos.x + " " +pos.y);
      //println();
      //println(displayArrows[type].pos.x + " " +displayArrows[type].pos.y);
      float d = abs(displayArrows[type].pos.y-pos.y);
      //if(id==4 || id==5) println(d);
      if (d<50) {
        arrowImg = loadImage("arrow_4.png");
        type = 4;
        //pos = displayArrows[type].pos;
        hit = true;
        isHit = true;
      }
      //directions[type] = false;
    }
    return hit;
  }

  void show() {
    float l = width/4;
    if (isDisplay) {

      if (directions[type]) {
        tint(100);
      } else {
        tint(255);
      }

      image(arrowImg, type*l+10, height-150, 100, 100);
    } else if (!isHit) {
      if (pos.y<height) {
        pos.y+=speed;
        image(arrowImg, type*l+10, pos.y, 100, 100);
      }
    }
  }
}
