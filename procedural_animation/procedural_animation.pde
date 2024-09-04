ArrayList<Segment> segments;
ArrayList<bullet> bullets;
float a = 1, factor = 1;

PVector mouse;

player player;
float speed = 1, maxSpeed = 10, friction = .99, frictionAux = .99;
float recoilPower = 2;
float dashPower = 3;
float charge = 0, maxCharge = 15, chargeRate = .3;
float time, frame = 1;

boolean game;

void keyPressed() {
  switch(key) {
  case 'w':
    player.up = true;
    break;
  case 's':
    player.down = true;
    break;
  case 'd':
    player.right = true;
    break;
  case 'a':
    player.left = true;
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'w':
    player.up = false;
    break;
  case 's':
    player.down = false;
    break;
  case 'd':
    player.right = false;
    break;
  case 'a':
    player.left = false;
    break;
  case 'f':
    player.parry = true;
    break;
  case 'r':
    setup();
    break;
  }
  switch(keyCode) {
  case SHIFT:
    player.vel.mult(dashPower);
    player.vel.limit(maxSpeed);
    break;
  }
}

void mouseReleased() {
  bullets.add(new bullet(bullets.size(), player.pos.x, player.pos.y, cos(atan2(mouseY - player.pos.y, mouseX - player.pos.x)), sin(atan2(mouseY - player.pos.y, mouseX - player.pos.x)), 5+charge, true));
  player.recoil = new PVector(-cos(atan2(mouseY - player.pos.y, mouseX - player.pos.x))*recoilPower*(charge/2.0), -sin(atan2(mouseY - player.pos.y, mouseX - player.pos.x))*recoilPower*(charge/2.0));
}

void updateBullets() {
  for (int i = 0; i < bullets.size(); ++i) {
    bullet b = bullets.get(i);
    if (b!=null) {
      b.update();
    }
  }
}

void showBullets() {
  for (bullet b : bullets) {
    if (b!=null) b.show();
  }
}

void ellipse(PVector p1, float size) {
  ellipse(p1.x, p1.y, size, size);
}

void line(PVector p1, PVector p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}

float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

void showSegments(ArrayList<Segment> ss) {
  for (Segment s : ss) {
    ArrayList<Point> body = s.body;
    if (body.get(body.size()-1)!=null && body.size()>0) body.get(body.size()-1).show();
  }
}


void updatePoints(ArrayList<Segment> ss) {
  for (int i = 0; i < ss.size(); ++i) {
    if (ss.get(i).body.size()>0)  ss.get(i).update();
  }
}

Segment setPoints(int nPoints, float x, float y, float radius, float area) {
  ArrayList<Point> p = new ArrayList<Point>();
  
  p.add(new Point(x, y, radius, area));

  for (int i = 1; i < nPoints; ++i) {
    p.add(new Point(x, y, radius, area, p.get(i-1)));
  }
  
  Segment aux = new Segment(x, y, p);
  return aux;
}

void setup() {
  //size(1200, 500);
  fullScreen();

  segments = new ArrayList<Segment>();
  segments.add(setPoints(15, random(-width, width*2), random(-height, height*2), 20, 20));
  //points.add(setPoints(1, random(-width, width*2), random(-height, height*2), 20, 20));
  player = new player(width/2.0, height/2.0);
  bullets = new ArrayList<bullet>();
  game = true;
}

void draw() {
  background(#272d35);
  if (game) {
    mouse = new PVector(player.pos.x, player.pos.y);
    player.show();
    showBullets();
    showSegments(segments);


    if (mousePressed) {
      if (charge<=maxCharge) charge+=chargeRate;
      //println("charging: "+ charge);
    } else {
      charge = 0;
    }

    if (time%frame==0) {
      player.update();
      updateBullets();
    }

    updatePoints(segments);
  }
  ++time;
}
