cPoint points[];
int nPoints = 100;
int rez = 150;
//int rows = 100, cols = 100;

float speed = 5;
float friction = .5;

void setValues() {
  float l = width/(float)rez;
  float h = height/(float)rez;
  for (int x = 0; x < rez; ++x) {
    for (int y = 0; y < rez; ++y) {
      float md = sqrt(width*width+height*height);
      for (int i = 0; i < nPoints; ++i) {
        if (dist(points[i].pos.x, points[i].pos.y, x*l, y*h) < md) {
          md = dist(points[i].pos.x, points[i].pos.y, x*l, y*h);
        }
      }
      noStroke();
      fill(255*md/100);
      rect(x*l, y*h, l, h);
    }
  }
}



float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void setAround(int i) {
  //println(i);
  for (int j = 0; j < nPoints; ++j) {
    if (i!=j && points[j].c == 0) {
      float d = dist(points[i].pos, points[j].pos);
      if (d<random(10, 150)) points[j].c = lerpColor(points[i].c, color(red(points[i].c), green(points[i].c)+random(-100, 50), blue(points[i].c)), d/100);
    }
  }
}

int setRandom() {
  int rPoint = floor(random(0, nPoints));
  while (points[rPoint].c!=0) rPoint = floor(random(0, nPoints));
  float r = random(1);
  points[rPoint].c = color(0, 200, 0);
  return rPoint;
}


void showPoints() {
  for (int i = 0; i < nPoints; ++i) {
    points[i].show();
  }
}

void setPoints() {
  points = new cPoint[nPoints];
  for (int i = 0; i < nPoints; ++i) {
    points[i] = new cPoint();
    points[i].pos = new PVector(random(width), random(height));
    points[i].vel = new PVector(random(speed), random(speed));
    points[i].c = 255;
  }
}

void setup() {
  size(1000, 500);
  setPoints();
}

void draw() {
  for (int i = 0; i < nPoints; ++i) {
    points[i].update();
  }
  setValues();
  //showPoints();
  if (mousePressed) setup();
}
