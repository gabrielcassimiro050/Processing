class Organismo {
  PVector posicao;
  PVector velocidade;
  float[] dna;
  float vida;    // Indica a aptidão (quanto mais saúde, melhor)
  float velocidadeMax;
  float percepcao; // Distância máxima para detectar recursos
  float tamanho;
  int sexo;

  Organismo(PVector posicao, float[] dna) {
    this.posicao = posicao.copy();
    this.dna = dna;
    this.vida = 100;

    // Fenótipo derivado do genótipo (DNA)
    this.velocidadeMax = map(dna[0], 0, 1, 2, 5);
    this.percepcao = map(dna[1], 0, 1, 50, 200);
    this.tamanho = map(dna[2], 0, 1, 4, 8);
    this.sexo = (int)(10*(dna[0] + dna[2]));
    this.velocidade = PVector.random2D();
  }

  void atualiza() {
    // Movimento simples
    posicao.add(velocidade);
    // Consume energia ao se mover
    vida -= velocidadeMax/10.0;

    // Limites da tela
    if (posicao.x > width) posicao.x = 0;
    if (posicao.x < 0) posicao.x = width;
    if (posicao.y > height) posicao.y = 0;
    if (posicao.y < 0) posicao.y = height;
  }

  void procuraComida() {
    PVector maisProximo = null;
    float dist = Float.MAX_VALUE;

    for (PVector r : comida) {
      float d = PVector.dist(posicao, r);
      if (d < dist && d < percepcao) {
        dist = d;
        maisProximo = r;
      }
    }

    if (maisProximo != null) {
      PVector desejado = PVector.sub(maisProximo, posicao);
      desejado.setMag(velocidadeMax);

      PVector direcao = PVector.sub(desejado, velocidade);
      velocidade.add(direcao);

      // Se reach o recurso, consome-o
      if (dist < tamanho) {
        vida += 20;
        comida.remove(maisProximo);
      }
    }
  }

  Organismo reproduzir() {
    // Reproduz com uma probabilidade baseada na saúde
    Organismo organismoProximo = this;
    float min = MAX_FLOAT;

    for (int i = 0; i < populacao.size(); ++i) {
      Organismo o = populacao.get(i);
      if (o!=this && dist(o.posicao, posicao) < percepcao && dist(o.posicao, posicao) < min && o.sexo%2!=sexo%2) {
        min = dist(o.posicao, posicao);
        organismoProximo = o;
      }
    }

    if (random(1) < 0.005 && vida > 50 && organismoProximo.vida > 50 && organismoProximo != this) {
      Organismo pai;
      Organismo mae;

      if (sexo == 1) {
        pai = this;
        mae = organismoProximo;
      } else {
        mae = this;
        pai = organismoProximo;
      }

      float[] dnaDominante = new float[2];
      float dnaRecessivo;

      if (random(1)<.5) {
        dnaRecessivo = pai.dna[0];
        for (int i = 1; i < 3; ++i) dnaDominante[i-1] = mae.dna[i];
      } else {
        dnaRecessivo = mae.dna[0];
        for (int i = 1; i < 3; ++i) dnaDominante[i-1] = pai.dna[i];
      }

      float[] novoDna = new float[3];

      novoDna[0] = dnaRecessivo;
      for (int i = 1; i < 3; ++i) {
        novoDna[i] = dnaDominante[i-1];
      }
      
      //arrayCopy(dna.trim(0, 1), novoDna);

      // mutacao
      for (int k = 0; k < novoDna.length; k++)
        if (random(1) < 0.001) novoDna[k] = constrain(novoDna[k] + random(-0.1, 0.1), 0, 1);

      pai.vida-=10;
      mae.vida-=10;
      return new Organismo(posicao, novoDna);
    } else {
      return null;
    }
  }

  boolean morreu() {
    return vida <= 0;
  }

  void mostra() {
    //noFill();

    //colorMode(HSB, 360, 100, 100);
    stroke(255);
    strokeWeight(.1);
    fill(lerpColor(#00FF00, #FF0000, map(velocidadeMax, 2, 5, 0, 1)), 10);
    ellipse(posicao.x, posicao.y, percepcao, percepcao);
        noStroke();
    fill(lerpColor(#00FF00, #FF0000, map(velocidadeMax, 2, 5, 0, 1)));
    ellipse(posicao.x, posicao.y, tamanho, tamanho);
    if(sexo%2==0) ellipse(posicao.x+cos(velocidade.heading())*tamanho, posicao.y+sin(velocidade.heading())*tamanho, tamanho/2.0, tamanho/2.0);
    //colorMode(RGB, 255, 255, 255);
  }

  color cor(float valor) {
    valor = constrain(valor, 0, 100);
    float matiz = map(valor, 0, 100, 0, 120);
    return color(matiz, 100, 100);
  }
}
