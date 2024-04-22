cPoint[][] points;
int rows = 100, cols = 50;
float l, h;
float seed = random(100);
float scl = .1;
float v = .5;


boolean withinX(int x){ return x>=0 && x<=rows ? true : false;}
boolean withinY(int y){ return y>=0 && y<=cols ? true : false;}

cPoint[][] setPoints() {
  cPoint[][] aux = new cPoint[rows+1][cols+1];
  for (int x = 0; x <= rows; ++x) {
    for (int y = 0; y <= cols; ++y) {
      aux[x][y] = new cPoint(x, y, noise(x*scl, y*scl, seed));
    }
  }
  return aux;
}

void line(PVector x, PVector y){
  line(x.x, x.y, y.x, y.y);
}

void showPoints(cPoint[][] p) {
  for (int x = 0; x < p.length; ++x) {
    for (int y = 0; y < p[x].length; ++y) {
      p[x][y].show();
    }
  }
}

void setup() {
  size(1000, 500);
  l = width/(float)rows;
  h = height/(float)cols;
  seed = random(100);
  points = setPoints();
}

void draw() {
  background(0);
  showPoints(points);
  if(mousePressed) setup();
}
