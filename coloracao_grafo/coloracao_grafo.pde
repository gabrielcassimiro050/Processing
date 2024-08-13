Grafo grafo;
int nVertices = 5;

void mouseReleased(){
  setup();
}

void setup(){
  size(750, 750);
  grafo = new Grafo(nVertices);
  
}

void draw(){
  background(#050F34);
  grafo.show();
}
