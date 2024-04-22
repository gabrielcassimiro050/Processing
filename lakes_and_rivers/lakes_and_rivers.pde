float[][] noise;
float scl = .02;
float l, h;
int r = 150, c = 150;
float seed = random(100);
float t = 23;
float amp = 50;

float[][] setNoise() {
  float[][] aux = new float[r][c];
  for (int x = 0; x < r; ++x) {
    for (int y = 0; y < c; ++y) {
      aux[x][y] = noise(x*scl, y*scl, seed)*amp;
    }
  }
  return aux;
}

void show() {
  for (int x = 0; x < r; ++x) {
    for (int y = 0; y < c; ++y) {
      noStroke();
      if(noise[x][y]>=t && noise[x][y]<=amp-t) fill(0, 50, 200);
      else fill(0, 200, 100);
      //fill(map(noise[x][y], 0, amp, 0, 255));
      rect(x*l, y*h, l, h);
    }
  }
}

void setup() {
  size(500, 500);
  seed = random(100);
  l = width/(float)r;
  h = height/(float)c;
  noise = setNoise();
}

void draw() {
  background(0);
  show();
  fill(255);
  text(noise[floor(mouseX/(float)l)][floor(mouseY/(float)h)], mouseX+20, mouseY-20);
  if(mousePressed) setup();
}
