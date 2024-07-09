// Definição da classe Grafo
class Grafo {
  int numVertices;
  int[][] matrizAdj;

  PVector[] posicoes; // Posições das partículas (nós do grafo)
  PVector[] velocidades; // Velocidades das partículas

  float raio = 10; // Raio dos nós
  float k = 0.001; // Constante da mola para a atração
  float c = 10000; // Constante de repulsão

  // Construtor da classe Grafo
  Grafo(int numVertices) {
    this.numVertices = numVertices;
    matrizAdj = new int[numVertices][numVertices];
    posicoes = new PVector[numVertices];
    velocidades = new PVector[numVertices];
    inicializarPosicoes();
  }

  Grafo(int[][] adj) {
    this.numVertices = adj.length;
    matrizAdj = adj;
    posicoes = new PVector[numVertices];
    velocidades = new PVector[numVertices];
    inicializarPosicoes();
  }


  int[] dijkstra(int origem) {

    int anterior[] = new int[numVertices];
    int dist[] = new int[numVertices];

    for (int i = 0; i < numVertices; ++i) {
      dist[i] = 100000000;
      anterior[i] = -1;
    }

    dist[origem] = 0;
    int[] visitados = new int[numVertices];

    int t = 0;
    do {
      for (int i = 0; i < numVertices; ++i) {
        int u = -1;
        int udist = 1000000000;
        t = 0;

        visitados[i] = -1;

        for (int j = 0; j < numVertices; ++j) {
          if (dist[i] < udist) {
            udist = dist[i];
            u = i;
          }
        }

        for (int j = 0; j < numVertices; ++j) {
          if (matrizAdj[u][j]!=0) {
            int alt = dist[u] + matrizAdj[u][j];
            if (alt < dist[j]) {
              dist[j] = alt;
              anterior[j] = u;
            }
          }
        }
      }


      for (int i = 0; i < numVertices; ++i) {
        if (visitados[i] == -1) {
          ++t;
        }
      }
    } while (t < numVertices);
    return anterior;
  }

  int[] find(int[] map, int destino) {
    int[] aux = new int[numVertices];
    
    int atual = destino, j = 0;
    do{
      aux[j] = atual;
      atual = map[atual];
      ++j;
    }while(atual != -1);
    
    return aux;
  }

  // Adiciona uma aresta entre dois vértices
  void adicionarAresta(int i, int j) {
    matrizAdj[i][j] = 1;
    matrizAdj[j][i] = 1; // Para grafos não direcionados
  }

  // Adiciona uma aresta entre dois vértices
  void adicionarAresta(int i, int j, int peso) {
    matrizAdj[i][j] = peso;
    matrizAdj[j][i] = peso; // Para grafos não direcionados
  }

  // Inicializa as posições das partículas em um círculo
  void inicializarPosicoes() {
    float angulo = TWO_PI / (numVertices - 1);
    float raioCirculo = min(width, height) / 3;
    for (int i = 1; i < numVertices; i++) {
      float x = width / 2 + raioCirculo * cos((i - 1) * angulo);
      float y = height / 2 + raioCirculo * sin((i - 1) * angulo);
      posicoes[i] = new PVector(x, y);
      velocidades[i] = new PVector(0, 0);
    }
    // Posição fixa do vértice 0
    posicoes[0] = new PVector(width / 2, height / 2);
    velocidades[0] = new PVector(0, 0);
  }

  // Atualiza as posições das partículas
  void atualizar() {
    for (int i = 1; i < numVertices; i++) {
      PVector forca = new PVector(0, 0);

      // Força de repulsão
      for (int j = 0; j < numVertices; j++) {
        if (i != j) {
          PVector direcao = PVector.sub(posicoes[i], posicoes[j]);
          float distancia = direcao.mag();
          if (distancia > 0) {
            direcao.normalize();
            float forcaRepulsao = c / (distancia * distancia);
            direcao.mult(forcaRepulsao);
            forca.add(direcao);
          }
        }
      }

      // Força de atração
      for (int j = 0; j < numVertices; j++) {
        if (matrizAdj[i][j] > 0) {
          PVector direcao = PVector.sub(posicoes[j], posicoes[i]);
          float distancia = direcao.mag();
          direcao.normalize();
          float forcaAtracao = k * (distancia - raio);
          direcao.mult(forcaAtracao);
          forca.add(direcao);
        }
      }

      velocidades[i].add(forca);
      posicoes[i].add(velocidades[i]);

      // Reduz a velocidade para estabilizar a simulação
      velocidades[i].mult(0.5);

      // Mantém as partículas dentro da tela
      if (posicoes[i].x < 0 || posicoes[i].x > width) velocidades[i].x *= -1;
      if (posicoes[i].y < 0 || posicoes[i].y > height)velocidades[i].y *= -1;
    }
  }

  // Desenha o grafo
  void desenhar(int[] path) {
    textAlign(CENTER);
    // Desenha as arestas
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < numVertices; i++) {
      for (int j = 0; j < numVertices; j++) {
        stroke(0);
        for(int k = 0; k < numVertices; ++k){
          if(k+1 < numVertices && path[k] == i && path[k + 1] == j){
            stroke(#FF0000);
          }
        }
        strokeWeight(matrizAdj[i][j]);
        if (matrizAdj[i][j] > 0) line(posicoes[i].x, posicoes[i].y, posicoes[j].x, posicoes[j].y);
      }
    }

    // Desenha os nós
    fill(255);
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < numVertices; i++) {
      fill(255);
      ellipse(posicoes[i].x, posicoes[i].y, raio * 2, raio * 2);
      fill(0);
      text(str(i), posicoes[i].x, posicoes[i].y+4);
    }
  }
}
