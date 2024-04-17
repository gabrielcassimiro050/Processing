int size = 50;
int nBibs = 10;
int[][] grid;
sBibs[] bibs;

class sBibs {
  int index;
  int x;
  int y;
  float velocidade;
  float horizontal;
  float vertical;
  color cor;

  void mover() {
    int auxX = (x+retornaValor(horizontal)+size)%size;
    int auxY = (y+retornaValor(vertical)+size)%size;
    grid[x][y] = 0;
    while(grid[auxX][auxY]==1){
      auxX = (x+retornaValor(horizontal)+size)%size;
      auxY = (y+retornaValor(vertical)+size)%size;
    }
    x = auxX;
    y = auxY;
    grid[auxX][auxY] = 1;
  }
}

int retornaValor(float value) {
  return random(1)<value ?random(1)<.33 ? 1 : random(1)<.66 ? -1 : 0 : 0;
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
      noStroke();
      rect(l*x, h*y, l, h);
      fill(255);
      for (int i = 0; i < nBibs; ++i) {
        if (bibs[i].x==x && bibs[i].y==y) {
          fill(bibs[i].cor);
        }
      }
    }
  }
}

sBibs[] criarBibs() {
  sBibs[] auxBibs = new sBibs[nBibs];
  for (int i = 0; i < nBibs; ++i) {
    auxBibs[i] = new sBibs();
    auxBibs[i].index = i;
    auxBibs[i].x = (int)random(size);
    auxBibs[i].y = (int)random(size);
    auxBibs[i].velocidade = random(1);
    auxBibs[i].horizontal = random(1);
    auxBibs[i].vertical = random(1);
    auxBibs[i].cor = color((int)random(100,255), (int)random(100,255), (int)random(100,255));
  }
  return auxBibs;
}

void atualizarPosBibs() {
  for (int i = 0; i < nBibs; ++i) {
    grid[bibs[i].x][bibs[i].y] = 1;
  }
}

void setup() {
  size(500, 500);
  grid = criarGrid();
  bibs = criarBibs();
}

void draw() {
  mostrarGrid();
  atualizarPosBibs();
  for (int i = 0; i < nBibs; ++i) {
    bibs[i].mover();
  }
  if (mousePressed) setup();
}
