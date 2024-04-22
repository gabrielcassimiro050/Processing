class cPoint {
  PVector pos;
  float value;
  color c;
  PVector[] miniP;

  cPoint(float x, float y, float value) {
    pos = new PVector(x, y);
    this.value = value;
    c = (int)map(value, 0, 1, 0, 255);
    miniP = new PVector[4];
    for (int i = 0; i < 4; ++i) {
      miniP[i] = new PVector(-1, -1);
    }
  }

  boolean mini(PVector m) {
    return m.x!=-1 && m.y!=-1 ? true : false;
  }
  void show() {
    int x = (int)pos.x;
    int y = (int)pos.y;
    fill(c);
    stroke(c);
    if (value>v) {
      ellipse(pos.x*l, pos.y*h, l/10, h/10);
      /*if (withinX(x+1) && points[x+1][y].value > v) {
        line(x*l, y*h, (x+1)*l, y*h);
      }
      if (withinY(y+1) && points[x][y+1].value > v) {
        line(x*l, y*h, x*l, (y+1)*h);
      }*/
    }

    if (withinX(x+1) && value>v && points[x+1][y].value<1-v) {
      //ellipse(x*l+l*value, y*h, 2, 2);
      //line(x*l+l*value, y*h, x*l, y*h);
      miniP[2] = new PVector(x*l+l*value, y*h);
    }
    if (withinY(y+1) && value>v && points[x][y+1].value<1-v) {
      //ellipse(x*l, y*h+h*value, 2, 2);
      //line(x*l, y*h+h*value, x*l, y*h);
      miniP[3] = new PVector(x*l, y*h+h*value);
    }
    if (withinX(x-1) && value>v && points[x-1][y].value<1-v) {
      //ellipse(x*l-l*value, y*h, 2, 2);
      //line(x*l-l*value, y*h, x*l, y*h);
      miniP[0] = new PVector(x*l-l*value, y*h);
    }
    if (withinY(y-1) && value>v && points[x][y-1].value<1-v) {
      //ellipse(x*l, y*h-h*value, 2, 2);
      //line(x*l, y*h-h*value, x*l, y*h);
      miniP[1] = new PVector(x*l, y*h-h*value);
    }

    for (int i = 0; i < miniP.length; ++i) {
      if (mini(miniP[i]) && mini(miniP[(i+1+4)%4])) line(miniP[i], miniP[(i+1+4)%4]);
    }

    if (value>v) {
      if (withinY(y+1) && points[x][y+1].value>v) {
        if (mini(miniP[0]) && mini(points[x][y+1].miniP[0])) {
          line(miniP[0], points[x][y+1].miniP[0]);
        }
        if (mini(miniP[2]) && mini(points[x][y+1].miniP[2])) {
          line(miniP[2], points[x][y+1].miniP[2]);
        }
      }

      if (withinX(x+1) && points[x+1][y].value>v) {
        if (mini(miniP[1]) && mini(points[x+1][y].miniP[1])) {
          line(miniP[1], points[x+1][y].miniP[1]);
        }
        if (mini(miniP[3]) && mini(points[x+1][y].miniP[3])) {
          line(miniP[3], points[x+1][y].miniP[3]);
        }
      }

      if (withinY(y+1) && points[x][y+1].value>v) {
        if (withinX(x+1) && points[x+1][y+1].value>v) {
          if (mini(miniP[2]) && mini(points[x+1][y+1].miniP[1])) {
            line(miniP[2], points[x+1][y+1].miniP[1]);
          }
        }
        if (withinX(x-1) && points[x-1][y+1].value>v) {
          if (mini(miniP[0]) && mini(points[x-1][y+1].miniP[1])) {
            line(miniP[0], points[x-1][y+1].miniP[1]);
          }
        }
      }
      
      if (withinY(y-1) && points[x][y-1].value>v) {
        if (withinX(x+1) && points[x+1][y-1].value>v) {
          if (mini(miniP[2]) && mini(points[x+1][y-1].miniP[3])) {
            line(miniP[2], points[x+1][y-1].miniP[3]);
          }
        }
        if (withinX(x-1) && points[x-1][y-1].value>v) {
          if (mini(miniP[0]) && mini(points[x-1][y-1].miniP[3])) {
            line(miniP[0], points[x-1][y-1].miniP[3]);
          }
        }
      }
    }
    /*for (int a = -1; a <= 1; ++a) {
     for (int s = -1; s <= 1; ++s) {
     for (int i = 0; i < miniP.length; ++i) {
     if (withinX(x+a) && withinY(y+s)) {
     for (int j = 0; j < points[x+a][y+s].miniP.length; ++j) {
     PVector[] aux = points[x+a][y+s].miniP;
     if (miniP[i].x!=-1 && miniP[i].y!=-1 && aux[j].x!=-1 && aux[j].y!=-1) line(miniP[i].x, miniP[i].y, aux[j].x, aux[j].y);
     }
     }
     }
     }
     }*/
  }
}
