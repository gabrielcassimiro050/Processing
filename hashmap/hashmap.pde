HashMap<String, Integer> grid;

float offsetX, offsetY;
float tileSize = 10;
int diffX, diffY;

PVector previousMouse;
float zoom = 1;

int colors[] = {255, 0, #00FF00, #FF0000, #0000FF, #FFE51F};

void drag(float _offsetX, float _offsetY) {
  offsetX += _offsetX;
  offsetY += _offsetY;
  diffX -= (mouseX - pmouseX) / zoom;
  diffY -= (mouseY - pmouseY) / zoom;
}

void showGrid() {
  
  float effectiveTileSize = tileSize * zoom;

  int startX = floor((diffX - width/2) / effectiveTileSize) - 1;
  int fimX = ceil((diffX + width/2) / effectiveTileSize) + 1;
  int startY = floor((diffY - height/2) / effectiveTileSize) - 1;
  int fimY = ceil((diffY + height/2) / effectiveTileSize) + 1;

  for (int x = startX; x <= fimX; x++) {
    for (int y = startY; y <= fimY; y++) {
      float screenX = x * effectiveTileSize - diffX + width/2;
      float screenY = y * effectiveTileSize - diffY + height/2;

      
      String key = x + "," + y;
      int value = grid.containsKey(key) ? grid.get(key) : 0;

      
      fill(colors[value]);
      rect(screenX, screenY, effectiveTileSize, effectiveTileSize);
    }
  }
}

void mousePressed() {
  previousMouse = new PVector(mouseX, mouseY);
}

void mouseWheel(MouseEvent event) {
  float scroll = event.getCount()/10.0;
  if (zoom+scroll > .2 && zoom+scroll < 1.8) zoom += scroll;
}

void mouseReleased(){
  float inWorldX = (mouseX-width/2.0+diffX)/zoom;
  float inWorldY = (mouseY-height/2.0+diffY)/zoom;
  
  int x = floor(inWorldX/tileSize);
  int y = floor(inWorldY/tileSize);
  
  String key = x+","+y;
  grid.put(key, (grid.containsKey(key) ? (grid.get(key)+1+colors.length)%colors.length : 1));
}

void setup() {
  size(750, 750);
  grid = new HashMap<String, Integer>();
  previousMouse = new PVector(mouseX, mouseY);
}

void draw() {
  background(#072450);
  showGrid();

  if (mousePressed) drag((previousMouse.x-mouseX)/10.0, (previousMouse.y-mouseY)/10.0);
}
