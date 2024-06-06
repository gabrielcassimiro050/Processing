class torre {
  PVector pos;
  boolean selected;

  Stack<disco> discos;

  torre(float x, float y) {
    pos = new PVector(x, y);
    discos = new Stack<disco>();
  }

  void addDisco(disco d) {
    discos.push(d);
  }

  void removeDisco() {
    discos.pop();
  }

  void show() {
    int i = 0;
    float maior = 0;
    for (disco d : discos) {
      if (d.tamanho>maior) maior = d.tamanho;
    }

    rectMode(CENTER);
    noStroke();

    fill(#53546C);
    rect(pos.x, pos.y-(altura*discos.size()*1.05-altura*discos.size()), 10, (discos.size()==0 ? 50 : altura*discos.size()));

    for (disco d : discos) {
      fill(lerpColor(#FFFFFF, #1190F5, d.tamanho/100.0));
      d.show(pos.x, pos.y-(i*altura-discos.size()*altura/2.0+altura/2.0));
      ++i;
    }

    noFill();
    if (selected) stroke(#FFFFFF);
    else stroke(#1190F5);
    strokeWeight(3);
    rect(pos.x, pos.y, (discos.size()==0 ? 50 : maior), (discos.size()==0 ? 50 : discos.size()*altura));
  }
}
