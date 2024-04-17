pixel[][] pixs;
menu menu;
int cols = 500, rows = 500;
int pixType = 1;
int qs = 10;
int brush = 1;
int floor = 15*cols/100;
PFont pixelFont;
float buttonSize = 50;
float l;
float h;
color bg = 200;

String[] elementsName = {"Sand", "Water", "Stone", "Gas"};

pixel[][] criarPixs() {
  pixel[][] aux = new pixel[rows][cols];
  for (int x = 0; x < rows; ++x) {
    for (int y = 0; y < cols; ++y) {
      aux[x][y] = new pixel();
      aux[x][y].type = 0;
      aux[x][y].c = 0;
    }
  }
  return aux;
}

pixel[][] updatePixs() {
  pixel[][] aux = criarPixs();
  for (int x = 0; x < rows; ++x) {
    for (int y = 0; y < cols-floor; ++y) {
      pixs[x][y].update(aux, x, y);
    }
  }
  return aux;
}

boolean isWithinX(int x) {
  if (x>=0 && x<rows) return true;
  else return false;
}

boolean isWithinY(int y) {
  if (y>=0 && y<cols-floor) return true;
  else return false;
}

void showQuad(float idX, float idY) {
  for (int x = floor(idX*qs); x < (idX+1)*qs; x++) {
    for (int y = floor(idY*qs); y < (idY+1)*qs; y++) {
      noStroke();
      noFill();
      color aux = pixs[x][y].c;
      if (isWithinY(y-1) && pixs[x][y].isLiquid) {
        if (pixs[x][y-1].type == 0) {
          fill(lerpColor(aux, 255, 1));
        } else {
          fill(aux);
        }
      } else if (pixs[x][y].c!=0) {
        fill(pixs[x][y].c);
      }
      rect(x*l, y*h, l, h);
    }
  }
  //showpixs(i);
}
void checarGuadrante() {
  //- -  x y
  //- +  x y
  //+ -  x y
  //+ +  x y
  for (int i = 0; i < floor(rows/qs)+1; ++i) {
    for (int j = 0; j < floor(cols/qs)+1; ++j) {
      if ((i+1)*qs<=rows && (j+1)*qs<=cols) {
        for (int x = i*qs; x < (i+1)*qs; x++) {
          boolean found = false;
          for (int y = j*qs; y < (j+1)*qs; y++) {
            //println(x+" "+y);
            if (pixs[x][y].type != 0) {
              //println("ok");
              showQuad(i, j);
              found = true;
            }
            if (found)break;
          }
          if (found)break;
        }
      }
    }
  }
}

void showpixs() {
  int t = 0;
  for (int x = 0; x < rows; ++x) {
    for (int y = 0; y < rows; ++y) {
      if (pixs[x][y].type==2) ++t;
    }
  }
  println(t);
}



void keyPressed() {
  switch(key) {
  case '1':
    println(key);
    pixType = 1;
    break;
  case '2':
    println(key);
    pixType = 2;
    break;
  case '3':
    println(key);
    pixType = 3;
    break;
  case '4':
    println(key);
    pixType = 4;
    break;
  }
}

void mouseReleased() {
  int my = floor(mouseY/h);
  if (my > cols-floor) {
    float mxMenu = mouseX;
    int nElements =  menu.nElements;
    for (int i = 0; i <= nElements; ++i) {
      pushMatrix();
      translate(0, height-(floor*(height/(float)cols)));
      if (mxMenu >= buttonSize/2+width/nElements*i && mxMenu <= buttonSize/2+width/nElements*(i+1)) {
        pixType = i+1;
        //println("ok");
      }
      popMatrix();
    }
  }
}

void mouseWheel(MouseEvent event) {
  int value = event.getCount()*-1;
  if (brush+value > 0 && brush+value <= 50) {
    brush+=value;
  }
}

void setup() {
  size(500, 500);
  //fullScreen();
  l = width/(float)rows;
  h = height/(float)cols;
  pixs = criarPixs();
  menu = new menu();
  menu.nElements = 4;
  pixelFont = createFont("Minecraft.ttf", 10);
  menu.elements = new PImage[menu.nElements];
  for (int i = 0; i < menu.nElements; ++i) {
    menu.elements[i] = loadImage("element_"+i+".png");
  }
}

void draw() {
  background(bg);
  menu.show();
  pixs = updatePixs();

  checarGuadrante();
  showpixs();
  float overX = mouseX;
  float overY = mouseY;

  fill(255);
  text(brush, width-15, 20);
  noFill();

  if (isWithinY(floor(overY/h))) {
    int nElements =  menu.nElements;
    for (int i = 0; i <= nElements; ++i) {

      if (overX >= buttonSize/2+width/nElements*i && overX <= buttonSize/2+width/nElements*(i+1)) {
        textFont(pixelFont);
        text(elementsName[i], 10, 20);
        //println(elementsName[i]);
      }
    }
  }
  if (mousePressed) {
    int mx = floor(mouseX/l);
    int my = floor(mouseY/h);
    float a = 0;
    int button= mouseButton;
    float extent = (float)brush/2;
    //extent é o raio, ele vai diminuir gradativamente até que a distancia entre ele e o mouse seja bem pequena e ao longo do caminho ele vai colocando os blocos
    /*for (int i = 0; i < extent; ++i) {
      int x = floor(cos(a)*extent);
      int y = floor(sin(a)*extent);
      if (isWithinX(mx+x) && isWithinY(my+y)) {
        pixs[x+mx][my+y].type = 3;
        pixs[x+mx][my+y].c = color(237+random(-10, 10), 226+random(-10, 10), 144+random(-10, 10));
        pixs[x+mx][my+y].hasGravity = false;
        pixs[x+mx][my+y].isLiquid = false;
        pixs[x+mx][my+y].isSolid = true;
        pixs[x+mx][my+y].isGas = false;
        pixs[x+mx][my+y].isWet = false;
        pixs[x+mx][my+y].overlays = false;
        pixs[x+mx][my+y].isAbsorvant = true;
        pixs[x+mx][my+y].isFalling = true;
        pixs[x+mx][my+y].agitation = 0;
        pixs[x+mx][my+y].consistancy = .8;
        pixs[x+mx][my+y].speed = 1;
      }
      a+=360/extent;
    }*/

    if (isWithinY(my)) {
     for (int i = mx-floor(extent); i < mx+extent; ++i) {
     for (int j = my-floor(extent); j < my+extent; ++j) {
     //println("ok");
     if (isWithinX(i) && isWithinY(j) && !pixs[i][j].overlays && button==LEFT) {
     pixs[i][j].type = pixType;
     switch(pixType) {
     case 1:
     pixs[i][j].c = color(237+random(-10, 10), 226+random(-10, 10), 144+random(-10, 10));
     pixs[i][j].hasGravity = true;
     pixs[i][j].isLiquid = false;
     pixs[i][j].isSolid = true;
     pixs[i][j].isGas = false;
     pixs[i][j].isWet = false;
     pixs[i][j].overlays = false;
     pixs[i][j].isAbsorvant = true;
     pixs[i][j].isFalling = true;
     pixs[i][j].agitation = 0;
     pixs[i][j].consistancy = .5;
     pixs[i][j].speed = 1;
     break;
     case 2:
     pixs[i][j].c = color(13, 116, 216);
     pixs[i][j].hasGravity = true;
     pixs[i][j].isLiquid = true;
     pixs[i][j].isSolid = false;
     pixs[i][j].isGas = false;
     pixs[i][j].isWet = false;
     pixs[i][j].isAbsorvant = false;
     pixs[i][j].overlays = false;
     pixs[i][j].agitation = 0;
     pixs[i][j].speed = 1;
     break;
     case 3:
     pixs[i][j].c = color(150);
     pixs[i][j].hasGravity = false;
     pixs[i][j].isLiquid = false;
     pixs[i][j].isSolid = true;
     pixs[i][j].isGas = false;
     pixs[i][j].isWet = false;
     pixs[i][j].isAbsorvant = false;
     pixs[i][j].overlays = true;
     pixs[i][j].agitation = 0;
     pixs[i][j].speed = 1;
     break;
     case 4:
     pixs[i][j].c = color(250);
     pixs[i][j].hasGravity = false;
     pixs[i][j].isLiquid = false;
     pixs[i][j].isSolid = false;
     pixs[i][j].isGas = true;
     pixs[i][j].isWet = false;
     pixs[i][j].isAbsorvant = false;
     pixs[i][j].overlays = false;
     pixs[i][j].agitation = .7;
     pixs[i][j].speed = 1;
     break;
     case 0:
     pixs[i][j].c = bg;
     break;
     }
     }
     if (isWithinX(i) && isWithinY(j) && button==RIGHT) {
     pixs[i][j] = new pixel();
     pixs[i][j].c = bg;
     }
     }
     }
     //println(mx+" "+my);
     }
  }
}
