int size = 300;
int nPlants = 20;
int auxNPlants = nPlants;
int[][]grid;
int vertical = -1; //-1,1
int horizontal = 0; //-1,1
sPlant[] plants;

class sPlant{
  int index;
  int xB, yB;
  int xP, yP;
  int nP;
  int maxNP;
  int nBranches;
  int maxNBranches;
  float growth;
  float fruitRate;
  color cor;
  color fruitColor;
  boolean dividir;
  boolean isBranch;
  boolean hasFruit;
  void grow(){
    //delay(10);
    if(nP<=maxNP && random(1)<growth){
      float l = width/(float)size;
      float h = height/(float)size;
      int aux = 0;
      do{
        xP = (xP+(retornaValor()+horizontal)%2+size)%size;
        yP = (yP+(retornaValor()+vertical)%2+size)%size;
      }while(grid[xP][yP]!=0);
      noStroke();
      rect(l*xP, h*yP, l, h);
      fill(cor);
      if(hasFruit){
        if(random(1)<fruitRate){
          fill(fruitColor);
        }
      }
      grid[xP][yP] = 1;
      nP++;
    }
  }
  
  void divide(){
    if(dividir && nBranches<maxNBranches && random(1)<.01){ 
      boolean auxDividir = true;
      plants = (sPlant[])expand(plants, plants.length+1);
      if(isBranch){
        auxDividir = false;
      }
      plants[plants.length-1] = criaPlanta(plants.length-1, xP, yP, growth, maxNP, cor, auxDividir, 0, 1, true, hasFruit, fruitRate, fruitColor);
      ++nPlants;
      ++nBranches;
    }
  }
}
int vizinhos(int x, int y){
  int aux = 0;
  for(int i = -1; i < 2; ++i){
    for(int j = -1; j < 2; ++j){
      if(grid[(x+i+size)%size][(y+j+size)%size] == 1){
        aux++;
      }
    }
  }
  return aux;
}
int retornaValor() {
  float aux = random(1);
  return aux>.33 ? aux>.66 ? 1 : -1 : 0;
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

void limpaGrid(){
  float l = width/(float)size;
  float h = height/(float)size;
  for (int x = 0; x < size; ++x) {
    for (int y = 0; y < size; ++y) {
      noStroke();
      rect(l*x, h*y, l, h);
      fill(255);
    }
  }
}


void mostrarGrid() {
  float l = width/(float)size;
  float h = height/(float)size;
  for(int i = 0; i < nPlants; ++i){
     noStroke(); 
     rect(l*plants[i].xB, h*plants[i].yB, l, h);
     fill(plants[i].cor);
  }
}



sPlant criaPlanta(int i, int xB, int yB, float growth, int maxNP, color cor, boolean dividir, int nBranches, int maxNBranches, boolean isBranch, boolean hasFruit, float fruitRate, color fruitColor){
  sPlant plant = new sPlant();
  plant.index = i;
  plant.xB = xB;
  plant.yB = yB;
  plant.xP = plant.xB;
  plant.yP = plant.yB;
  plant.growth = growth;
  plant.maxNP = maxNP;
  plant.cor = cor;
  plant.nBranches = nBranches;
  plant.maxNBranches = maxNBranches;
  plant.dividir = dividir;
  plant.isBranch = isBranch;
  plant.hasFruit = hasFruit;
  plant.fruitRate = fruitRate;
  plant.fruitColor = fruitColor;
  grid[plant.xB][plant.yB] = 1;
  return plant;
}

void setup(){
  //size(500,500);
  fullScreen();
  limpaGrid();
  nPlants = auxNPlants;
  plants = new sPlant[0];
  grid = criarGrid();
  plants = new sPlant[nPlants];
  for(int i = 0; i < nPlants; ++i){
    plants[i] = criaPlanta(i, (int)random(size), size-1, random(1), (int)random(50), color(0, random(100,250),50), true, 0, (int)random(15), false, random(1)>.9 ? true : false, random(1), color(random(100, 200), random(50, 100), random(100, 200)));
  }
}

void draw(){
  mostrarGrid();
  for(int i = 0; i < nPlants; ++i){
    plants[i].grow();
    plants[i].divide();
  }
  if(mousePressed) setup();
}
