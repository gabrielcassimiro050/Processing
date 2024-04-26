ArrayList<particle> particles;
float friction = .99;

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
        PVector d = new PVector(p1.p.x-p2.p.x, p1.p.y-p2.p.y);
        PVector dAux = new PVector(d.x, d.y);
        if (d.x>.5*width) d.x -=width;
        if (d.x<-.5*width) d.x +=width;
        if (d.y>.5*height) d.y -=height;
        if (d.y<-.5*height) d.y +=height;

        if (p1!=p2 && d.mag()!=0 && d.mag()<dA) {
          if (dAux.x<.5*width && dAux.x>-.5*width && dAux.y<.5*height && dAux.y>-.5*height && line) {
            color cAux = lerpColor(p1.c, p2.c, .5);
            fill(cAux);
            strokeWeight(.2);
            stroke(cAux);
            line((p1.p.x+p2.p.x)/2, (p1.p.y+p2.p.y)/2, p1.p.x, p1.p.y);
            line((p1.p.x+p2.p.x)/2, (p1.p.y+p2.p.y)/2, p2.p.x, p2.p.y);
            ellipse((p1.p.x+p2.p.x)/2, (p1.p.y+p2.p.y)/2, 1, 1);
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
  size(1000, 500);
  particles = new ArrayList<particle>();
  //setParticles(0, 100, #FF0000);
  setParticles(1, 250, #FFFFFF);
  setParticles(2, 10, #14377E);
  setParticles(3, 10, #00F000);
}

void draw() {
  background(#040E24);
  showParticles();
  setForces(1, 1, 75, -.01, false);
  setForces(1, 1, 25, .1, false);
  setForces(1, 2, 100, -.5, true);
  setForces(2, 1, 50, .01, true);

  if (mousePressed) setup();
}
