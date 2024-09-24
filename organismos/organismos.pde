ArrayList<Food> food;
ArrayList<Organismo> organisms;
int nFood = 350;
int time;

float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void setFood() {
  food = new ArrayList<Food>();
  for (int i = 0; i < nFood; ++i) {
    food.add(new Food(random(20, width-20), random(20, height-20)));
  }
}

void growFood(){
  int randomFood = round(random(10, nFood));
  for(int i = 0; i < randomFood; ++i) food.add(new Food(random(20, width-20), random(20, height-20)));
}

void showFood() {
  for (int i = 0; i < food.size(); ++i) food.get(i).show();
}

void updateFood() {
  for (int i = 0; i < food.size(); ++i) food.get(i).update();
}

void setOrganisms(int nOrganisms) {
  organisms = new ArrayList<Organismo>();
  for (int i = 0; i < nOrganisms; ++i) {
    organisms.add(new Organismo(random(20, width-20), random(20, height-20)));
  }
}

void showOrganisms() {
  for (int i = 0; i < organisms.size(); ++i) {
    Organismo o = organisms.get(i);
    if (o.alive) o.show();
  }
}

void updateOrganisms() {
  for (int i = 0; i < organisms.size(); ++i) {
    Organismo o = organisms.get(i);
    if (o.alive) o.update();
    else organisms.remove(i);
  }
}

void mouseReleased(){
  setup();
}

void setup() {
  size(1200, 500);
  setFood();
  setOrganisms(50);
  time = 0;
}

void draw() {
  background(#11343E);
  showOrganisms();
  updateOrganisms();
  showFood();
  updateFood();
  if (time%100==0) growFood();
  surface.setTitle("População: "+organisms.size());
  
  if(organisms.size()<=1) setup();
  ++time;
}
