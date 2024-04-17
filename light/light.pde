cell cells[];
int nCells = 100;
color spectrum = color(150, 50, 50);
int t = 0;
//int nT = 50;

boolean firstMousePress = false;
HScrollbar r, b, g, nT;


void mousePressed() {
  if (!firstMousePress) {
    firstMousePress = true;
  }
}

color randomColor(float max, float min) {
  return color(random(min, max), random(min, max), random(min, max));
}

cell[] setCells() {
  cell[] aux = new cell[nCells];
  for (int i = 0; i < nCells; ++i) {
    aux[i] = new cell(new PVector(random(width), random(height)), randomColor(255, 100));
  }
  return aux;
}

cell[] setNewGen() {
  cell[] aux = new cell[nCells];
  ArrayList<Integer> colors = new ArrayList<Integer>();
  int total = 255;

  for (int j = 0; j < nCells; ++j) {
    float value = (-4/255)*pow(cells[j].diff, 2)+4*cells[j].diff;
    println(cells[j].diff/total*100);
    for (int i = 0; i < value/total*100; i++) {
      colors.add(color(red(cells[j].c)+random(-10, 10), green(cells[j].c)+random(-10, 10), blue(cells[j].c)+random(-10, 10)));
    }
  }

  for (int i = 0; i < nCells; ++i) {
    aux[i] = new cell(new PVector(random(width), random(height)), colors.get((int)random(colors.size())));
  }
  return aux;
}

void showCells() {
  for (int i = 0; i < nCells; ++i) {
    cells[i].show();
  }
}
void setup() {
  size(500, 500);
  cells = setCells();
  r = new HScrollbar(0, 8, width/3, 16, 255);
  g = new HScrollbar(0, 30, width/3, 16, 255);
  b = new HScrollbar(0, 52, width/3, 16, 255);
  nT = new HScrollbar(0, 74, width/3, 16, 100);
}

void draw() {
  background(255);
  showCells();
  fill(spectrum);
  ellipse(mouseX, mouseY, 10, 10);
  r.update();
  g.update();
  b.update();
  nT.update();
  r.display();
  g.display();
  b.display();
  nT.display();
  text("R", width/3+20, 12);
  text("G", width/3+20, 34);
  text("B", width/3+20, 56);
  text("Delay", width/3+20, 78);
  spectrum = color(r.getPos(), g.getPos(), b.getPos());
  //if(mousePressed)
  if (t%(int)nT.getPos()==0) {
    cells = setNewGen();
  }

  if (firstMousePress) {
    firstMousePress = false;
  }
  ++t;
}
