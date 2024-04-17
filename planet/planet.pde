int size = 300;
int nPoints = 1;
int nM = 50000;
int[][] grid;
sPoint[] points;

class sPoint {
  int x;
  int y;
  color cor;
  void mover() {
    int auxX = (x+retornaValor()+size)%size, auxY = (y+retornaValor()+size)%size;
    float l = width/(float)size;
    float h = height/(float)size;
    for (int a = 0; a < nM; ++a) {
      if (auxY<size && auxY>0) {
        y = auxY;
      }
      x = auxX;
      grid[x][y] = 1;
      rect(x*l, y*h, l, h);
      stroke(color((-pow(y, 2)+size*y)/200, 150, 0));
      fill(color((-pow(y, 2)+size*y)/200, 150, 0));
      //println((-pow(y, 2)+size*y)/2550);
      auxX = (x+(retornaValor()+(int)random(-2, 2))%2+size)%size;
      auxY = y+(retornaValor()+(int)random(-2, 2))%2;
      if (vizinhos(x, y)>1) {
        for (int i = -1; i < 2; ++i) {
          for (int j = -1; j < 2; ++j) {
            grid[(x+i+size)%size][(y+j+size)%size] = 1;
          }
        }
      }
    }
  }
}

int retornaValor() {
  float aux = random(1);
  return aux>.33 ? aux>.66 ? 1 : -1 : 0;
}

int vizinhos(int x, int y) {
  int aux = 0;
  for (int i = -1; i < 2; ++i) {
    for (int j = -1; j < 2; ++j) {
      if (grid[(x+i+size)%size][(y+j+size)%size] == 1) {
        aux++;
      }
    }
  }
  return aux;
}

int[][] criarGrid() {
  int[][] aux = new int[size][size];
  for (int x = 0; x < size; ++x) {
    for (int y = 0; y < size; ++y) {
      aux[x][y] = 0;
    }
  }
  return aux;
}

void mostrarGrid() {
  float l = width/(float)size;
  float h = height/(float)size;
  for (int x = 0; x < size; ++x) {
    for (int y = 0; y < size; ++y) {
      rect(x*l, y*h, l, h);
      stroke(0, 100, 255);
      fill(0, 100, 255);
    }
  }
}

void setup() {
  size(1000, 500);
  grid = criarGrid();
  points = new sPoint[0];
  points = new sPoint[nPoints];
  mostrarGrid();
  for (int i = 0; i < nPoints; ++i) {
    points[i] = new sPoint();
    points[i].x = (int)random(size);
    points[i].y = (int)random(size);
    points[i].cor = color(0, 50, 0);
    grid[points[i].x][points[i].y] = 1;
    points[i].mover();
  }
}

void draw() {

  if (mousePressed) setup();
}
