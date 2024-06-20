ArrayList<biomi> biomis;
int nBiomis = 100;
float maxSpeed = 5, maxSize = 25;

double dist(PVector p1, PVector p2){
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void addBiomi(ArrayList<biomi> b, float x, float y, color c, float radius, float range, float angle, float size) {
  b.add(new biomi(x, y, c, radius, range, angle, maxSize/size, size));
}

void showBiomis(ArrayList<biomi> bs) {
  for (biomi b : bs) {
    b.show();
  }
}

void updateBiomis(ArrayList<biomi> bs) {
  for (biomi b : bs) {
    b.update();
  }
}

void setup() {
  size(1200, 600);
  biomis = new ArrayList<biomi>();
  for (int i = 0; i < nBiomis; ++i) {
    addBiomi(biomis, random(width), random(height), color(random(50, 200), random(50, 200), random(50, 200)), random(50, 100), random(45, 90), radians(random(360)), random(5, 25));
  }
}

void draw() {
  background(#060D15);
  showBiomis(biomis);
  updateBiomis(biomis);
  
  if(mousePressed) setup();
}
