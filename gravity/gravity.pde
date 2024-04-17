cPoint[] red;
cPoint[] blue;
cPoint[] green;
cPoint[] yellow;
int nR = 2000;
int nB = 20;
int nG = 10;
int nY = 0;
float s = 3;
float friction = .5; // 1 -> no friction || <1 -> more friction

int dl = 60; //initial fps

class cPoint {
  float x;
  float y;
  float s;
  float vx;
  float vy;
  color c;
}


cPoint[] createPoint(cPoint[] points, float x, float y, float s, color c, int n, boolean r) {
  points = new cPoint[0];
  points = new cPoint[n];
  for (int i = 0; i < n; ++i) {
    if (r) {
      x = random(50, width-50);
      y = random(50, height-50);
    }
    points[i] = new cPoint();
    points[i].x = x;
    points[i].y = y;
    points[i].c = c;
    points[i].s = s;
    y=height-y;
    //points[i].paint();
  }
  return points;
}

void showPoints(cPoint[] points) {
  if (points==null) return;
  for (int i = 0; i < points.length; ++i) {
    cPoint point = points[i];
    noStroke();
    fill(point.c);
    ellipse(point.x, point.y, point.s, point.s);
  }
}

void update(cPoint[] p1, cPoint[] p2, float g, float dA, boolean wrap, boolean dot, float dDot) {
  for (int i = 0; i < p1.length; ++i) {
    float fx = 0;
    float fy = 0;
    boolean wrapped = false;
    for (int j = 0; j < p2.length; ++j) {
      float d;
      float dx = p1[i].x-p2[j].x;
      float dy = p1[i].y-p2[j].y;

      if (wrap) {
        if (dx>width/2) {
          dx = width-dx;
          wrapped = true;
        }
        if (dy>height/2) {
          dy = height-dy;
          wrapped = true;
        }
      }

      d = sqrt(dx*dx + dy*dy);
      if (d>0 && d<dA) {
        float F = g/100*1/d;
        fx += (F*dx);
        fy += (F*dy);
        //println(d);
      }

      if (d<dDot && d!=0 && !wrapped && dot) {
        float auxX = (p1[i].x+p2[j].x)/2;
        float auxY = (p1[i].y+p2[j].y)/2;
        for (int a = 0; a < 5; ++a) {
          fill(255);
          rect(auxX, auxY, 1, 1);
          rect((p1[i].x-auxX)/2, (p1[i].y-auxY)/2, 1, 1);
          rect((p2[j].x-auxX)/2, (p2[j].y-auxY)/2, 1, 1);
          noFill();
        }
      }
      wrapped = false;
    }

    p1[i].vx = (p1[i].vx + fx)*friction;
    p1[i].vy = (p1[i].vy + fy)*friction;
    if (wrap) {
      p1[i].x = (p1[i].x+p1[i].vx+width)%width;
      p1[i].y = (p1[i].y+p1[i].vy+height)%height;
    } else {
      if (p1[i].x<=0 || p1[i].x>=width) p1[i].vx *= -1;
      if (p1[i].y<=0 || p1[i].y>=height) p1[i].vy *= -1;
      p1[i].x += p1[i].vx;
      p1[i].y += p1[i].vy;
    }
  }
}

void setup() {
  //size(500, 500);
  fullScreen();

  background(0);
  smooth();
  red = createPoint(red, 0, 0, s, color(229, 53, 56), nR, true);
  blue = createPoint(blue, 0, 0, s, color(53, 201, 229), nB, true);
  green = createPoint(green, 0, 0, s, color(53, 229, 84), nG, true);
  yellow = createPoint(yellow, 0, 0, s, color(229, 224, 53), nY, true);
}

void mouseWheel(MouseEvent event) {
  if (dl+event.getCount()*-5 > 0) {
    dl+=event.getCount()*-5;
  }
}
void draw() {
  frameRate(dl);
  background(0);

  //translate(width/2, height/2);
  text("Max FPS: "+dl, 10, 30);
  text("FPS: "+frameRate, 10, 50);
  //update(passive, active, force(- for attracion + for repulsion), distance, wraparound)
  //update(green, red, -100, 100, true) green will be attraced towards red when inside the 100 radius distance


  update(red, red, 10, 30, true, false, 0);
  update(red, blue, -500, 60, true, false, 0);
  update(red, green, -200, 200, true, true, 40);
  update(blue, red, 200, 50, true, false, 0);
  update(blue, blue, -89, 100, true, false, 0);
  update(green, red, 10, 20, true, false, 0);



  showPoints(red);
  showPoints(blue);
  showPoints(yellow);
  showPoints(green);
  if (mousePressed) setup();
}
