player player;
ArrayList<bullet> bullets;
ArrayList<enemy> enemies;

float speed = 1, maxSpeed = 25, friction = .9, frictionAux;
float recoilPower = 5;
float dashPower = 15;
float charge = 0, maxCharge = 15, chargeRate = .3;
float time, frame = 1;

boolean game;

float dist(PVector p1, PVector p2) {
  return dist(p1.x, p1.y, p2.x, p2.y);
}

final int FOLLOWER = 1, CHARGER = 2, SNIPER = 3;

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

void updateEnemies() {
  ArrayList<enemy> aux = new ArrayList<enemy>();
  for (int i = 0; i < enemies.size(); ++i) {
    enemy e = enemies.get(i);
    if (e!=null && !e.dead) {
      e.update();
      aux.add(e);
    }
  }
  enemies = aux;
}

void showEnemies() {
  for (enemy e : enemies) {
    if (e!=null) e.show();
  }
}

void addEnemy(int type, int n) {
  for (int i = 0; i < n; ++i) {
    switch(type) {
    case FOLLOWER:
      enemies.add(new follower(random(width), random(height)));
      break;
    case CHARGER:
      enemies.add(new charger(random(100)+(random(1)<.5 ? width : -width), random(100)+(random(1)<.5 ? height : -height)));
      break;
    case SNIPER:
      enemies.add(new sniper(random(width), random(height)));
      break;
    }
  }
}
void setup() {
  size(1200, 750);
  game = true;
  frictionAux = .9;
  friction = .9;
  player = new player(width/2.0, height/2.0);
  bullets = new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  addEnemy(SNIPER, 1);
  addEnemy(CHARGER, 1);
  addEnemy(FOLLOWER, 1);
}

void draw() {
  if (game) {
    background(#030A1A);
    player.show();
    showBullets();
    showEnemies();
    if (time%frame==0) {
      player.update();
      updateBullets();
      updateEnemies();
    }
    if (mousePressed) {
      if (charge<=maxCharge) charge+=chargeRate;
      //println("charging: "+ charge);
    } else {
      charge = 0;
    }

    ++time;
  } else {
    fill(255);
    textSize(50);
    text("GAME OVER", width/2.0-100, height/2.0);
  }
}
