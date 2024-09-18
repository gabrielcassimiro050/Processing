class Segmento {
  PVector pos;
  Segmento origem;
  float tamanho;

  Segmento(float x, float y, float tamanho) {
    pos = new PVector(x, y);
    this.tamanho = tamanho;
    origem = null;
  }

  Segmento(Segmento origem, float tamanho) {
    pos = new PVector(origem.pos.x, origem.pos.y);
    this.tamanho = tamanho;
    this.origem = origem;
  }

  void update() {
    float area = tamanho/2.0+origem.tamanho/2.0;
    if (dist(origem.pos, pos) > area) {
      float a = PVector.sub(pos, origem.pos).heading();
      pos = new PVector(origem.pos.x+cos(a)*area, origem.pos.y+sin(a)*area);
    }
  }

  void show() {
    noFill();
    stroke(255);
    strokeWeight(tamanho/9.5);
    ellipse(pos.x, pos.y, tamanho, tamanho);

    stroke(#F7AE5F);
    strokeWeight(tamanho/10.0);
    ellipse(pos.x, pos.y, tamanho, tamanho);

    float spacing = 360/4.0;

    
  }
}
