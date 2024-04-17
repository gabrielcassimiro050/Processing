int grid[][];
int n = 10000;
int qs = 5;
int nPoints = 1000;
boolean mouseRelease = false;
boolean plus, minus;
double inicio, fim;

void showGrid(float idX, float idY) {
  float l = width/(float)n;
  float h = height/(float)n;

  for (int x = floor(idX*qs); x < (idX+1)*qs; x++) {
    for (int y = floor(idY*qs); y < (idY+1)*qs; y++) {
      noStroke();
      noFill();
      if (grid[x][y] == 1) fill(0);
      //else fill(map((idX+idY+2)%2, 0, 1, 50, 150));
      rect(x*l, y*h, l, h);
    }
  }
  //showGrid(i);
}

void checarGuadrante() {
  //- -  x y
  //- +  x y
  //+ -  x y
  //+ +  x y
  inicio = millis();
  fim = 0;
  for (int i = 0; i < floor(n/qs)+1; ++i) {
    for (int j = 0; j < floor(n/qs)+1; ++j) {
      if ((i+1)*qs<=n && (j+1)*qs<=n) {
        for (int x = i*qs; x < (i+1)*qs; x++) {
          boolean found = false;
          for (int y = j*qs; y < (j+1)*qs; y++) {
            //println(x+" "+y);
            if (grid[x][y]== 1) {
              showGrid(i, j);
              found = true;
            }
            if (found)break;
          }
          if (found)break;
        }
      }
    }
    //showGrid(i);
    fim = millis();
  }
  println("quadrante: " + (fim-inicio));
}

void clearGrid() {
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      grid[x][y] = 0;
    }
  }
}

void randomPoints() {
  for (int i = 0; i < nPoints; ++i) {
    grid[(int)random(n)][(int)random(n)] = 1;
  }
}

void mostrarGrid() {
  float l = width/(float)n;
  float h = height/(float)n;
  inicio = millis();
  fim = 0;
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      noStroke();
      noFill();
      if (grid[x][y]==1) fill(0);
      //else fill(255);
      rect(x*l, y*h, l, h);
    }
  }
  fim = millis();

  println("normal: " + (fim-inicio));
}


int returnValue() {
  float aux = random(1);
  return aux>.33 ? (aux>.66 ? -1 : 0) : 1;
}
void update() {
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      if (grid[x][y] == 1 && random(1)>.5) {
        int auxX = (x+returnValue()+n)%n;
        int auxY = (y+returnValue()+n)%n;
        while (grid[auxX][auxY]!=0) {
          auxX = (x+returnValue()+n)%n;
          auxY = (y+returnValue()+n)%n;
        }
        grid[x][y] = 0;
        grid[auxX][auxY] = 1;
      }
    }
  }
}

void mouseReleased() {
  if (!mouseRelease) mouseRelease = true;
}



void setup() {
  size(500, 500);
  background(255);
  grid = new int[n][n];
  //clearGrid();
  randomPoints();
}


void keyPressed() {
  println(key);
  if (key=='=') ++qs;
  if (key=='-') --qs;
}

void draw() {
  background(255);

  update();
  checarGuadrante();
  //mostrarGrid();

  println("qs:"+qs);
  if (mouseRelease) setup();
  if (mouseRelease) mouseRelease = false;
}
