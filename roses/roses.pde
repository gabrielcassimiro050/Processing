pix[][] pixs;
int rows = 100, cols = 100;
int nQuads = 5;
int nPixs = 50;
float l, h;



pix[][] setPixs() {
  pix[][] aux = new pix[rows][cols];
  for (int x = 0; x < rows; ++x) {
    for (int y = 0; y < cols; ++y) {
      aux[x][y] = new pix(0);
    }
  }
  return aux;
}

pix[][] updatePixs() {
  pix[][] aux = new pix[rows][cols];
  for (int x = 0; x < rows; ++x) {
    for (int y = 0; y < cols; ++y) {
      aux[x][y] = pixs[x][y];
      if (pixs[x][y].type == 1 && pixsAround(x, y) < 2) {
        int rx = random(1)>.5 ? 1 : -1, ry = random(1)>.5 ? 1 : -1;
        while (pixs[(x+rx+rows)%rows][(y+ry+cols)%cols].type!=0) {
          rx =  random(1)>.5 ? 1 : -1;
          ry =  random(1)>.5 ? 1 : -1;
        }
        aux[x][y].c = color(0,200,0);
        aux[(x+rx+rows)%rows][(y+ry+cols)%cols] = new pix(1);
        //pixs[x][y].c = color(200,0,0);
      }else if(pixs[x][y].type == 1){
        aux[x][y].c = color(200,0,0);
      }
    }
  }
  return aux;
}

int pixsAround(int x, int y) {
  int t = -1;
  for (int i = -1; i <= 1; ++i) {
    for (int j = -1; j <= 1; ++j) {
      if (pixs[(x+i+rows)%rows][(y+j+cols)%cols].type == 1) ++t;
    }
  }
  return t;
}

void setRandomPixs() {
  for (int i = 0; i < nPixs; ++i) {
    int rx = (int)random(rows), ry = (int)random(cols);
    while (pixs[rx][ry].type!=0) {
      rx = (int)random(rows);
      ry = (int)random(cols);
    }
    pixs[rx][ry] = new pix(1);
  }
}
boolean withinX(int x) {
  return x>=0 && x<rows ? true : false;
}

boolean withinY(int y) {
  return y>=0 && y<cols ? true : false;
}

void showQuad(int i, int j) {
  for (int x = floor(i*rows/nQuads); x < floor((i+1)*rows/nQuads); ++x) {
    for (int y = floor(j*cols/nQuads); y < floor((j+1)*cols/nQuads); ++y) {
      noStroke();
      fill(pixs[x][y].c);
      rect(x*l, y*h, l, h);
    }
  }
}

void checkQuad() {
  for (int i = 0; i < nQuads; ++i) {
    for (int j = 0; j < nQuads; ++j) {
      for (int x = floor(i*rows/nQuads); x < floor((i+1)*rows/nQuads); ++x) {
        for (int y = floor(j*cols/nQuads); y < floor((j+1)*cols/nQuads); ++y) {
          if (pixs[x][y].type!=0) {
            //println(x+" "+y);
            showQuad(i, j);
            break;
          }
        }
      }
    }
  }
}

void setup() {
  size(500, 500);
  l = width/(float)rows;
  h = height/(float)cols;
  pixs = setPixs();
  setRandomPixs();
}

void draw() {
  background(255);
  delay(100);
  pixs = updatePixs();
  checkQuad();
}
