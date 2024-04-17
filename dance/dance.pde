ArrayList<arrow> arrows;
arrow[] displayArrows;
int nImgs = 5;
PImage arrowImg[];

boolean[] directions = {false, false, false, false, false};
boolean game;
boolean error;

int[] newArrows = {0, 3, 4, 1, 1, 0, 1, 0, 4, 2, 2, 0, 2, 3, 4, 3, 2, 2, 2, 0, 4, 1, 0, 2, 3, 3, 4, 1, 2, 1, 3, 1, 0, 1, 4, 2, 1, 3, 1, 3, 0, 1, 3, 4, 0, 3, 3, 4, 3, 3, 0, 3, 2, 4, 1, 2, 3, 3, 0, 4, 1, 4, 3, 4, 1, 0, 0, 0, 2, 4, 3, 4, 3, 3, 4, 0, 0, 4, 2, 1, 2, 3, 4, 0, 0, 4, 3, 2, 0, 4, 1, 1, 3, 3, 1, 0, 1, 4, 2, 4, 4, 2, 1, 4, 2, 2, 0, 1, 2, 4, 1, 1, 4, 0, 2, 1, 1, 2, 4, 0, 1, 2, 0, 3, 0, 1, 4, 1, 0, 0, 3, 4, 0, 3, 2, 3, 2, 3, 2, 2, 0, 3, 1, 4, 2, 4, 1, 3, 2, 2, 4, 1, 1, 3, 3, 3, 1, 0, 0, 4, 1, 0, 4, 2, 4, 4, 0, 1, 3, 2, 1, 3, 1, 4, 2, 0, 3, 1, 1, 4, 3, 1, 2, 2, 0, 1, 4, 0, 3, 4, 1, 0, 0, 0};
float l = width/4;

PImage press;
float a = 0;

int score = 0;
float speed = 5;
float spacing = 50;

void keyPressed() {
  switch(key) {
  case 'a':
    directions[0] = true;
    break;
  case 's':
    directions[1] = true;
    break;
  case 'w':
    directions[2] = true;
    break;
  case 'd':
    directions[3] = true;
    break;
  default:
    game = true;
    break;
  }

  switch(keyCode) {
  case LEFT:
    directions[0] = true;
    break;
  case DOWN:
    directions[1] = true;
    break;
  case UP:
    directions[2] = true;
    break;
  case RIGHT:
    directions[3] = true;
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'a':
    directions[0] = false;
    break;
  case 's':
    directions[1] = false;
    break;
  case 'w':
    directions[2] = false;
    break;
  case 'd':
    directions[3] = false;
    break;
  }
  switch(keyCode) {
  case LEFT:
    directions[0] = false;
    break;
  case DOWN:
    directions[1] = false;
    break;
  case UP:
    directions[2] = false;
    break;
  case RIGHT:
    directions[3] = false;
    break;
  }
}

int effectiveArrows() {
  int t = 0;
  for (int i = 0; i < newArrows.length; ++i) {
    if (newArrows[i]!=4) ++t;
  }
  return t;
}
void setArrows() {
  for (int i = 0; i < newArrows.length; ++i) {
    arrows.add(new arrow(new PVector(i*l+10, -spacing*i), loadImage("arrow_"+newArrows[i]+".png"), newArrows[i], false));
  }
}

void setImages() {
  displayArrows = new arrow[nImgs];
  for (int i = 0; i < nImgs; ++i) {
    displayArrows[i] = new arrow(new PVector(i*l+10, height-150), loadImage("arrow_"+i+".png"), i, true);
  }
}

void setDisplay() {
  for (int i = 0; i < nImgs; ++i) {
    displayArrows[i].show();
  }
}

void showArrows() {
  for (int i = 0; i < newArrows.length; ++i) {
    arrow aux = arrows.get(i);
    aux.show();
  }
}

void updateArrows() {
  float maior = 0;
  int id = -1;
  for (int i = 0; i < newArrows.length; ++i) {
    arrow aux = arrows.get(i);
    //println(newArrows);
    if (aux.pos.y>maior && aux.pos.y<height && aux.type!=4) {
      maior = aux.pos.y;
      id = i;
    }
  }

  if (id!=-1) {
    //println(id);
    arrow aux = arrows.get(id);
    if (aux.update(id)) {
      ++score;
    }
  }
}
void setup() {
  size(500, 800);
  setImages();
  press = loadImage("press.png");
  arrows = new ArrayList<arrow>();
  setArrows();
}


void draw() {
  background(255);

  setDisplay();
  if (game) {
    showArrows();
    updateArrows();

    fill(0);
    text(100*score/effectiveArrows()+"%", width-100, 100);
  } else {
    image(press, 0, height/2+sin(a)*20, 256*2+sin(a)*10, 32*2+cos(a)*10);
    a+=.1;
  }
}
