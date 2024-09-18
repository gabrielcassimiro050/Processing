class Organismo {
  PVector vel, acc;

  ArrayList<Float> dna;
  ArrayList<Segmento> segmentos;
  int nSegmentos;

  Organismo(int nSegmentos, float x, float y) {
    dna = new ArrayList<Float>();
    segmentos = new ArrayList<Segmento>();

    dna.add((float)nSegmentos);
    for (int i = 0; i < nSegmentos; ++i) {
      dna.add(random(1));
      float tamanho = map(dna.get(i+1), 0, 1, 5, 20);

      if (i==0) {
        segmentos.add(new Segmento(x, y, tamanho));
      } else {
        segmentos.add(new Segmento(segmentos.get(i-1), tamanho));
      }
    }

    vel = new PVector(1, 0);
  }

  void update() {

    Segmento origem = segmentos.get(0);
    PVector mouse = new PVector(mouseX, mouseY);
    if (dist(mouse, origem.pos) > origem.tamanho*2) {
      acc = PVector.sub(mouse, origem.pos);
      acc.mult(acc.mag());
      acc.normalize();
      vel.add(acc);
    } else {
      vel.mult(.6);
    }

    vel.mult(.99);
    vel.limit(10);
    origem.pos.add(vel);
    for (int i = 1; i < segmentos.size(); ++i) {
      segmentos.get(i).update();
    }
  }

  void flatDisplay() {
    for (int i = 0; i < segmentos.size(); ++i) {
      Segmento origem = null;
      Segmento s = segmentos.get(i);
      if (i!=0) origem = segmentos.get(i-1);
      s.show();

      float angle = 0;

      if (origem==null) angle = PVector.sub(new PVector(mouseX, mouseY), s.pos).heading();
      else  angle = PVector.sub(origem.pos, s.pos).heading();

      if (origem!=null) {
        line(s.pos.x+cos(radians(270)+angle)*s.tamanho, s.pos.y+sin(radians(270)+angle)*s.tamanho, origem.pos.x+cos(radians(270)+angle)*origem.tamanho, origem.pos.y+sin(radians(270)+angle)*origem.tamanho);
        line(s.pos.x+cos(radians(90)+angle)*s.tamanho, s.pos.y+sin(radians(90)+angle)*s.tamanho, origem.pos.x+cos(radians(90)+angle)*origem.tamanho, origem.pos.y+sin(radians(90)+angle)*origem.tamanho);
      }
    }
  }

  void triDisplay() {
    for (int i = 0; i < segmentos.size(); ++i) {
      Segmento origem = null;
      Segmento s = segmentos.get(i);
      if (i!=0) origem = segmentos.get(i-1);
      s.show();

      if (origem!=null) {
        /*stroke(#F7AE5F);
        strokeWeight(s.tamanho/10.0);
        
        line(s.pos.x+cos(radians(90))*s.tamanho, s.pos.y+sin(radians(90))*s.tamanho, origem.pos.x+cos(radians(90))*origem.tamanho, origem.pos.y+sin(radians(90))*origem.tamanho);
        line(s.pos.x+cos(radians(270))*s.tamanho, s.pos.y+sin(radians(270))*s.tamanho, origem.pos.x+cos(radians(270))*origem.tamanho, origem.pos.y+sin(radians(270))*origem.tamanho);
        
        line(s.pos.x+cos(radians(180))*s.tamanho, s.pos.y+sin(radians(180))*s.tamanho, origem.pos.x+cos(radians(180))*origem.tamanho, origem.pos.y+sin(radians(180))*origem.tamanho);
        line(s.pos.x+cos(radians(360))*s.tamanho, s.pos.y+sin(radians(360))*s.tamanho, origem.pos.x+cos(radians(360))*origem.tamanho, origem.pos.y+sin(radians(360))*origem.tamanho);
        */
         fill(#F7AE5F);
        
        beginShape();
        vertex(s.pos.x+cos(radians(90))*s.tamanho, s.pos.y+sin(radians(90))*s.tamanho);
        vertex(origem.pos.x+cos(radians(90))*origem.tamanho, origem.pos.y+sin(radians(90))*origem.tamanho);
        vertex(origem.pos.x+cos(radians(180))*origem.tamanho, origem.pos.y+sin(radians(180))*origem.tamanho);
        vertex(s.pos.x+cos(radians(180))*s.tamanho, s.pos.y+sin(radians(180))*s.tamanho);
        endShape();
        
       
        fill(#BF884D);
        beginShape();
        vertex(s.pos.x+cos(radians(90))*s.tamanho, s.pos.y+sin(radians(90))*s.tamanho);
        vertex(origem.pos.x+cos(radians(90))*origem.tamanho, origem.pos.y+sin(radians(90))*origem.tamanho);
        vertex(origem.pos.x+cos(radians(0))*origem.tamanho, origem.pos.y+sin(radians(0))*origem.tamanho);
        vertex(s.pos.x+cos(radians(0))*s.tamanho, s.pos.y+sin(radians(0))*s.tamanho);
        endShape();
        
        fill(#BF884D);
        beginShape();
        vertex(s.pos.x+cos(radians(270))*s.tamanho, s.pos.y+sin(radians(270))*s.tamanho);
        vertex(origem.pos.x+cos(radians(270))*origem.tamanho, origem.pos.y+sin(radians(270))*origem.tamanho);
        vertex(origem.pos.x+cos(radians(180))*origem.tamanho, origem.pos.y+sin(radians(180))*origem.tamanho);
        vertex(s.pos.x+cos(radians(180))*s.tamanho, s.pos.y+sin(radians(180))*s.tamanho);
        endShape();
        
        fill(#F7AE5F);
        beginShape();
        vertex(s.pos.x+cos(radians(270))*s.tamanho, s.pos.y+sin(radians(270))*s.tamanho);
        vertex(origem.pos.x+cos(radians(270))*origem.tamanho, origem.pos.y+sin(radians(270))*origem.tamanho);
        vertex(origem.pos.x+cos(radians(0))*origem.tamanho, origem.pos.y+sin(radians(0))*origem.tamanho);
        vertex(s.pos.x+cos(radians(0))*s.tamanho, s.pos.y+sin(radians(0))*s.tamanho);
        endShape();
        
        //line(s.pos.x+cos(radians(90))*s.tamanho, s.pos.y+sin(radians(90))*s.tamanho, s.pos.x+cos(radians(270))*s.tamanho, s.pos.y+sin(radians(270))*s.tamanho);
        //line(s.pos.x+cos(radians(180))*s.tamanho, s.pos.y+sin(radians(180))*s.tamanho, s.pos.x+cos(radians(0))*s.tamanho, s.pos.y+sin(radians(0))*s.tamanho);
        //line(s.pos.x+cos(radians(90))*s.tamanho, s.pos.y+sin(radians(90))*s.tamanho, origem.pos.x+cos(radians(180))*origem.tamanho, origem.pos.y+sin(radians(180))*origem.tamanho);
        //line(s.pos.x+cos(radians(180))*s.tamanho, s.pos.y+sin(radians(180))*s.tamanho, origem.pos.x+cos(radians(270))*origem.tamanho, origem.pos.y+sin(radians(270))*origem.tamanho);
        //line(s.pos.x+cos(radians(270))*s.tamanho, s.pos.y+sin(radians(270))*s.tamanho, origem.pos.x+cos(radians(0))*origem.tamanho, origem.pos.y+sin(radians(0))*origem.tamanho);
      }
    }
  }
  
  void show() {
    triDisplay();
  }
}
