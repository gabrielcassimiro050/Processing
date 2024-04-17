planet planets[];
planet moons[];
planet sun;
boolean right, left, up, down;
float scl = 1;
int nPlanets = 3;
int nMoons = 2;
float offsetX = 0;
float offsetY = 0;

planet defPlanet(float x, float y, float s, color c, float sd, int id, boolean orbit, boolean isSun, planet obj) {
  planet aux = new planet();
  aux.pos = new PVector(x+sd, y+sd);
  aux.posSCL = new PVector(x*scl, y*scl);
  aux.s = s;
  aux.c = c;
  aux.a = 0;
  aux.idMoon = id;
  if (!isSun) {
    aux.speed = 1/dist(aux.pos.x, aux.pos.y, obj.pos.x, obj.pos.y)*scl/10;
  } else {
    aux.speed = 0;
  }
  aux.orbit = orbit;
  return aux;
}

planet[] defPlanets() {
  planet[] aux = new planet[nPlanets];
  for (int i = 0; i < aux.length; ++i) {
    aux[i] = defPlanet(random((i!=0 ? aux[i-1].pos.x : 0), 50+(i!=0 ? abs(aux[i-1].pos.x-sun.pos.x) : sun.s*2))*2, random((i!=0 ? aux[i-1].pos.y : 0), 50+(i!=0 ? abs(aux[i-1].pos.y-sun.pos.y)  : sun.s*2)), random(10, 30), color(random(0, 255), random(0, 255), random(0, 255)), (i-1>=0 ? dist(sun.pos.x, sun.pos.y, aux[i-1].pos.x, aux[i-1].pos.y) : 0), -1, true, false, sun);
  }
  return aux;
}

void showPlanets() {
  for (int i = 0; i < planets.length; ++i) {
    planets[i].show();
  }
}

void updatePlanets() {
  for (int i = 0; i < planets.length; ++i) {
    planets[i].update(sun);
  }
}

void updateMoon(planet moon, planet home) {
  pushMatrix();
  translate(sun.pos.x, sun.pos.y);
  moon.update(home);
  popMatrix();
}
void updateMoons() {
  for (int i = 0; i < nMoons; ++i) {
    updateMoon(moons[i], planets[moons[i].idMoon]);
  }
}

planet[] defMoons() {
  planet[] aux = new planet[nMoons];
  for (int i = 0; i < aux.length; ++i) {
    aux[i] = new planet();
    aux[i].idMoon = ceil(random(-.5, nPlanets-1));
    aux[i] = defMoon(planets[aux[i].idMoon], aux[i].idMoon);
  }
  return aux;
}
planet defMoon(planet home, int id) {
  planet moon = new planet();
  pushMatrix();
  translate(home.pos.x, home.pos.y);
  moon = defPlanet(random(planets[id].s, 40), random(planets[id].s, 40), home.s*random(0,.5), 100, 0, id, true, true, planets[id]);
  popMatrix();
  return moon;
}


void mouseWheel(MouseEvent event) {
  if (scl+event.getCount()/(50.0/scl)>=0) {
    scl+=event.getCount()/(50.0/scl);
    println(scl);
  }
}

void setup() {
  size(500, 500);

  smooth();
  sun = defPlanet(width/2, height/2, 100, color(255,247,237), 0, -1, false, true, null);
  planets = defPlanets();
  moons = defMoons();
  //translate(sun.pos.x, sun.pos.y);
}
void keyPressed()
{
  if (key=='a' || keyCode==LEFT)
    left=true;
  if (key=='d' || keyCode==RIGHT)
    right=true;
  if (key=='w' || keyCode==UP)
    up=true;
  if (key=='s' || keyCode==DOWN)
    down=true;
}
void keyReleased()
{
  if (key=='a' || keyCode==LEFT)
    left=false;
  if (key=='d' || keyCode==RIGHT)
    right=false;
  if (key=='w' || keyCode==UP)
    up=false;
  if (key=='s' || keyCode==DOWN)
    down=false;
  if(keyCode==TAB){
    scl = 1;
    offsetX = 0;
    offsetY = 0;
  }
}
void draw() {
  background(0);

  sun.show();
  updatePlanets();
  updateMoons();

  mouseWheel();
  if (mousePressed) {
    scl = 1;
    setup();
  }

  if (right) offsetX-=5*scl;
  if (left) offsetX+=5*scl;
  if (up) offsetY+=5*scl;
  if (down)offsetY-=5*scl;
}
