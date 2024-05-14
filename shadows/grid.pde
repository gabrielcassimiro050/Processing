class grid {
  float[][] values;
  

  grid() {
    values = new float[r][c];
  }
  
  int around(int x, int y) {
    int t = -1;
    for (int i = -1; i <= 1; ++i) {
      for (int j = -1; j <= 1; ++j) {
        if (x+i<r && x+i>=0 && y+j<c & y+j>=0 && values[(x+i+r)%r][(y+j+c)%c]==0) ++t;
      }
    }
    return t;
  }

  void set() {
    for (int x = 0; x < r; ++x) {
      for (int y = 0; y < c; ++y) {
        values[x][y] = round(noise(x*scl, y*scl, seed));
      }
    }
  }

  void show() {
    for (int x = 0; x < r; ++x) {
      for (int y = 0; y < c; ++y) {
        noStroke();
        if (values[x][y] == 0) {
          float t = 0;
          int totalTiles = 0;

          for (int i = 1; i <= range; ++i) {
            totalTiles+=8*i;
          }

          for (int i = -range; i <= range; ++i) {
            for (int j = -range; j <= range; ++j) {
              if (x+i<r && x+i>=0 && y+j<c & y+j>=0) t+=values[(x+i+r)%r][(y+j+c)%c];
            }
          }
          values[x][y] = t/(float)totalTiles;
        }
        fill(values[x][y]*255);
        rect(x*l, y*h, l, h);
      }
    }
  }
}
