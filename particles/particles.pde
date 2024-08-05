ArrayList<particle> particles;
float friction = .9;
float radius = 2;
void setParticles(int t, int n, color c) {
  for (int i = 0; i < n; ++i) {
    particles.add(new particle(random(width), random(height), t, c));
  }
}

void showParticles() {
  for (int i = 0; i < particles.size(); ++i) {
    particles.get(i).show();
  }
}

void setForces(int t1, int t2, float dA, float f, boolean line) {
  for (int i = 0; i < particles.size(); ++i) {
    for (int j = 0; j < particles.size(); ++j) {
      particle p1 = particles.get(i);
      particle p2 = particles.get(j);
      if (p1.type == t1 && p2.type==t2) {
        PVector d = PVector.sub(p1.p, p2.p);
        PVector dAux = new PVector(d.x, d.y);
        if (d.x>.5*width) d.x -= width;
        if (d.x<-.5*width) d.x += width;
        if (d.y>.5*height) d.y -= height;
        if (d.y<-.5*height) d.y += height;

        if (p1!=p2 && d.mag()!=0 && d.mag()<dA) {
          PVector pAux = new PVector(p2.p.x, p2.p.y);
          if(dAux.x>.5*width) pAux.x += width;
          if(dAux.x<-.5*width) pAux.x -= width;
          if(dAux.y>.5*height) pAux.y += height;
          if(dAux.y<-.5*height) pAux.y -= height;
          //if (dAux.x<.5*width && dAux.x>-.5*width && dAux.y<.5*height && dAux.y>-.5*height && line) {
            if(line){
            color cAux = lerpColor(p1.c, p2.c, .5);
            fill(cAux);
            strokeWeight(.2);
            stroke(cAux);
            line((p1.p.x+pAux.x)/2, (p1.p.y+pAux.y)/2, p1.p.x, p1.p.y);
            line((p1.p.x+pAux.x)/2, (p1.p.y+pAux.y)/2, pAux.x, pAux.y);
            ellipse((p1.p.x+pAux.x)/2, (p1.p.y+pAux.y)/2, 1, 1);
          //}
          }
          PVector a = new PVector(0, 0);
          a.x += d.x*f/10*1/d.mag();
          a.y += d.y*f/10*1/d.mag();
          p1.v.add(a);
          p1.v.mult(friction);
          p1.p.x = (p1.p.x+p1.v.x+width)%width;
          p1.p.y = (p1.p.y+p1.v.y+height)%height;
        }
      }
    }
  }
}
void setup() {
  //fullScreen();
  size(1000, 500);
  particles = new ArrayList<particle>();
  setParticles(0, 150, 255);
  setParticles(1, 500, #0087FA);
  setParticles(2, 50, #FF0000);
}

void draw() {
  background(#040E24);
  showParticles();
  //setForces(0, 1, 50, 1, true);
  //setForces(0, 0, 100, -2, true);
  //setForces(0, 0, 75, 10, true);
  
  //setForces(0, 1, 70, -1, true);
  //setForces(0, 1, 20, 2, true);
  
  setForces(1, 0, 75, -.1, false);
  setForces(1, 0, 15, .5, false);
  setForces(1, 1, radius, 1, false);
  setForces(0, 1, 20, -.6, true);
  setForces(1, 2, 25, .1, false);
  setForces(2, 1, 30, -.3, true);
  setForces(2, 0, 40, .5, false);
  setForces(2, 1, 25, .4, true);
  setForces(1, 2, 15, -1, false);
  if (mousePressed) setup();
}
