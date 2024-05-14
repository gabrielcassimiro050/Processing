grid grid;
int r = 250, c = 250;
float l, h;
float scl = .01, seed;
int range = 5;





void setup() {
  size(500, 500);
  l = width/(float)r;
  h = height/(float)c;
  
  seed = random(1000);
  grid = new grid();
  grid.set();
}

void draw() {
  background(#020415);
  grid.show();
  if (mousePressed) setup();
}
