Grafo grafo;

void setup() {
  size(800, 600);

  int n = 7;
  int[][] adj = new int[n][n];

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      adj[i][j] = random(1) > 0.5 ? int(random(1, 5)) : 0;
      adj[j][i] = adj[i][j];
    }
  }
  
  grafo = new Grafo(adj);



  for (int i = 0; i < 500; i++) grafo.atualizar();

  background(255);
  
  
  int[] map = grafo.dijkstra(2);
  int[] path = grafo.find(map, 3);
  for(int i = 0; i < path.length; ++i){
    println(path[i]);
  }
  grafo.desenhar(path);

}
