import java.util.HashSet;

class Grafo {
  int n;
  HashSet<PVector> config;
  ArrayList<PVector> vPos;
  int[] c;

  Grafo(int n) {
    this.n = n;
    config = new HashSet<PVector>();
    vPos = new ArrayList<PVector>();
    c = new int[n];
    
    for (int i = 0; i < n; ++i) {
      c[i] = color(random(100, 255), random(100, 255), random(100, 255));
      vPos.add(new PVector(random(100, width-100), random(100, height-100)));
      if (random(1) > .1) {
        boolean ok = true;
        int aux = floor(random(n));
        for (PVector p : config) {
          if (((int)p.x == i && aux == (int)p.y) || ((int)p.y == i && aux == (int)p.x)) ok = false;
        }
        if (ok) {
          if (aux<i) config.add(new PVector(aux, i));
          else config.add(new PVector(i, aux));
        }
      }
    }
  }


  void show() {
    stroke(255);
    strokeWeight(1);
    for (PVector p : config) {
      line(vPos.get((int)p.x).x, vPos.get((int)p.x).y, vPos.get((int)p.y).x, vPos.get((int)p.y).y);
    }

    noStroke();
    for (int i = 0; i < n; ++i) {
      float x = vPos.get(i).x, y = vPos.get(i).y;
      int[] cores = colorirGrafo();
      fill(c[cores[i]]);
      ellipse(x, y, 10, 10);
      text(i, x+3, y-10);
    }
  }

  int[] colorirGrafo() {
    int[] cores = new int[n];
    boolean[] coresDisponiveis = new boolean[n];
    for (int i = 0; i < n; ++i) coresDisponiveis[i] = true;

    for (PVector v : config) {
      int x = (int)v.x;

      for (PVector u : config) {

        if ((int)u.x == x) {
          int y = (int)u.y;
          if (cores[y] != 0) {
            coresDisponiveis[cores[y]] = false;
          }
        }

        if ((int)u.y == x) {
          int y = (int)u.x;
          if (cores[y] != 0) {
            coresDisponiveis[cores[y]] = false;
          }
        }
      }

      for (int cor = 1; cor < n; ++cor) {
        if (coresDisponiveis[cor]) {
          cores[x] = cor;
          break;
        }
      }

      for (int i = 1; i < n; ++i) {
        coresDisponiveis[i] = true;
      }
    }
    return cores;
  }
}
