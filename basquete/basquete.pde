import java.util.LinkedList;

LinkedList<bola> bolas;
PImage bola_png;
boolean click;

void setup() {
  size(500, 500);
  bolas = new LinkedList<bola>();
  bola_png = loadImage("bola_basquete.png");
  bolas.add(new bola(width/2, 0));
}

void mouseReleased() {
  click = true;
}

void draw() {
  background(#0C1440);
  for (int i = 0; i < bolas.size(); ++i) {
    bolas.get(i).show();
    bolas.get(i).update();
  }
  if (click) {
    bolas.add(new bola(mouseX, mouseY));
    click = false;
  }
}
