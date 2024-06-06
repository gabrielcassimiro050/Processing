import java.util.Stack;

ArrayList<torre> torres;
torre torreSelecionada;

float altura = 25;

void showTorres() {
  for (torre t : torres) {
    t.show();
  }
}

void mouseReleased() {
  torre aux = torreSelecionada;
  for (torre t : torres) {
    float maior = 0;

    for (disco d : t.discos) {
      if (d.tamanho>maior) maior = d.tamanho;
    }

    if (t.selected) t.selected = false;

    if (mouseX >= t.pos.x-(t.discos.size()==0 ? 50 : maior/2.0) && mouseY >= t.pos.y-(t.discos.size()==0 ? 50 : altura*t.discos.size()/2.0) && mouseX <= t.pos.x+(t.discos.size()==0 ? 50 : maior/2.0) && mouseY <= t.pos.y+(t.discos.size()==0 ? 50 : altura*t.discos.size()/2.0)) {
      t.selected = true;
      if (torreSelecionada!=null && torreSelecionada.discos.size()>0) {
        if (t.discos.size()>0 && torreSelecionada.discos.peek().tamanho <= t.discos.peek().tamanho) {
          t.discos.push(torreSelecionada.discos.peek());
          torreSelecionada.discos.pop();
          t.selected = false;
        } else if (t.discos.size()<=0) {
          t.discos.push(torreSelecionada.discos.peek());
          torreSelecionada.discos.pop();
          t.selected = false;
        }
        torreSelecionada = null;
      } else {
        torreSelecionada = t;
      }
    }
  }
  if (torreSelecionada==aux) torreSelecionada = null;
}


void setup() {
  size(750, 750);
  torres = new ArrayList<torre>();

  torres.add(new torre(width/2.0, height/2.0));
  torres.add(new torre(width/4.0, height/2.0));
  torres.add(new torre(width-width/4.0, height/2.0));
  for (int i = 0; i < 5; ++i) {
    torres.get(0).addDisco(new disco(ceil(random(50, 100))));
  }
}

void draw() {
  background(#021834);
  showTorres();
}
