class pixel {
  color c;
  int type;
  int speed;
  float agitation;
  float consistancy;
  boolean hasGravity;
  boolean isSolid;
  boolean isLiquid;
  boolean isGas;
  boolean isWet;
  boolean overlays;
  boolean isAbsorvant;
  boolean isFalling;




  void gas(pixel[][] aux, int x, int y) {
    if (random(1)<agitation) {
      float r = random(1);
      int auxX = r>.5 ?  1 :-1;

      if (isWithinY(y-speed) && pixs[x][y-speed].type==0 && aux[x][y-speed].type == 0) {
        aux[x][y-speed] = pixs[x][y];
        aux[x][y] = new pixel();
        aux[x][y].c = bg;
      } else if (isWithinX(auxX+x) && pixs[x+auxX][y].type == 0 && aux[x+auxX][y].type == 0) {
        aux[x+auxX][y] = pixs[x][y];
        aux[x][y] = new pixel();
        aux[x][y].c = bg;
      } else {
        aux[x][y] = pixs[x][y];
      }




      /*random() if (isWithinY(y-speed) && pixs[x][y-speed].type==0 && aux[x][y-speed].type == 0) {
       aux[x][y-speed] = pixs[x][y];
       aux[x][y] = new pixel();
       aux[x][y].c = bg;
       } else if (isWithinX(auxX+x) && pixs[x+auxX][y].type == 0 && aux[x+auxX][y].type == 0) {
       aux[x+auxX][y] = pixs[x][y];
       aux[x][y] = new pixel();
       aux[x][y].c = bg;
       } else {
       aux[x][y] = pixs[x][y];
       }fire*/
    } else {
      aux[x][y] = pixs[x][y];
    }
  }

  void liquid(pixel[][] aux, int x, int y) {
    float r = random(1);
    int auxX = r>.5 ?  1 : -1;
    if (isWithinY(y+speed) && pixs[x][y+speed].type==0) {
      aux[x][y+speed] = pixs[x][y];
      aux[x][y] = new pixel();
      aux[x][y].c = bg;
      ++speed;
    } else if (isWithinY(y+1) && isWithinX(x+auxX) && pixs[x+auxX][y].type==0 && aux[x+auxX][y].type==0 && pixs[x][y+1].type!=0) {
      aux[x+auxX][y] = pixs[x][y];
      aux[x][y] = new pixel();
      aux[x][y].c = bg;
      speed = 1;
    } else {
      aux[x][y] = pixs[x][y];
      speed = 1;
    }
    /*if (isWithinY(y+speed) && pixs[x][y+speed].type==0 && aux[x][y+speed].type == 0) {
     aux[x][y+speed] = pixs[x][y];
     aux[x][y] = new pixel();
     aux[x][y].c = bg;
     ++speed;
     } else if (isWithinX(auxX+x) && pixs[x+auxX][y].type == 0 && aux[x+auxX][y].type == 0) {
     aux[x+auxX][y] = pixs[x][y];
     aux[x][y] = new pixel();
     aux[x][y].c = bg;
     speed = 1;
     } else {
     aux[x][y] = pixs[x][y];
     }*/
  }

  void solid(pixel[][] aux, int x, int y) {
    int auxX = random(1)>.5 ? 1 : -1;

    if (isAbsorvant) {
      for (int i = -1; i <= 1; ++i) {
        if (isWithinX(x+i) && pixs[x+i][y].isLiquid && !isWet) {
          if (pixs[x+i][y].isLiquid) {
            pixs[x+i][y] = new pixel();
            pixs[x+i][y].c = bg;
          }
          c = lerpColor(c, color(98, 93, 58), .5);
          isWet = true;
        }
      }
      for (int i = -1; i <= 1; ++i) {
        if (isWithinY(y+i) && pixs[x][y+i].isLiquid && !isWet) {
          if (pixs[x][y+i].isLiquid) {
            pixs[x][y+i] = new pixel();
            pixs[x][y+i].c = bg;
          }
          c = lerpColor(c, color(98, 93, 58), .5);
          isWet = true;
        }
      }
    }

    if (isWithinY(y+speed) && pixs[x][y+speed].isLiquid) {
      if (!isAbsorvant) {
        pixel auxPix = pixs[x][y];
        pixs[x][y] = pixs[x][y+speed];
        pixs[x][y+1] = auxPix;
      } else {
        pixs[x][y+speed] = new pixel();
        pixs[x][y+speed].c = bg;
      }
    }

    if (isWithinY(y+speed) && pixs[x][y+speed].type==0) {
      aux[x][y+speed] = pixs[x][y];
      aux[x][y] = new pixel();
      aux[x][y].c = bg;
      ++speed;
    } else if (pixs[x][y].isFalling && isWithinX(x+auxX) && isWithinY(y+speed) && pixs[x+auxX][y+speed].type==0 && pixs[x+auxX][y].type==0) {
      if (random(1)<pixs[x][y].consistancy) pixs[x][y].isFalling = false;
      aux[x+auxX][y+speed] = pixs[x][y];
      aux[x][y] = new pixel();
      aux[x][y].c = bg;
      ++speed;
    } else {
      aux[x][y] = pixs[x][y];
      speed = 1;
    }
  }


  void update(pixel[][] aux, int x, int y) {
    if (hasGravity) {
      if (isSolid) {
        solid(aux, x, y);
      }
      if (isLiquid) {
        liquid(aux, x, y);
      }
    } else if (isGas) {
      gas(aux, x, y);
    } else if (pixs[x][y].type!=0) {
      aux[x][y] = pixs[x][y];
    }
  }
}
