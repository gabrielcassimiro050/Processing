player player;
ArrayList<bullet> bullets;
float speed = 1, maxSpeed = 25, friction = .9, frictionAux;
float recoilPower = 5;
float dashPower = 15;
float charge = 0, maxCharge = 150, chargeRate = .1;
float time, frame = 1;


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
  }
  switch(keyCode){
    case SHIFT:
      player.vel.mult(dashPower);
      player.vel.limit(maxSpeed);
      break;
  }
}

void mouseReleased(){
  bullets.add(new bullet(bullets.size(), player.pos.x, player.pos.y, cos(atan2(mouseY - player.pos.y, mouseX - player.pos.x)), sin(atan2(mouseY - player.pos.y, mouseX - player.pos.x)),5+charge));
  player.recoil = new PVector(-cos(atan2(mouseY - player.pos.y, mouseX - player.pos.x))*recoilPower*(charge/2.0), -sin(atan2(mouseY - player.pos.y, mouseX - player.pos.x))*recoilPower*(charge/2.0));
}

void updateBullets(){
  for(bullet b : bullets){
    if(b!=null) b.update();
  }
}

void showBullets(){
  for(bullet b : bullets){
    if(b!=null) b.show();
  }
}

void setup() {
  size(750, 750);
  frictionAux = friction;
  player = new player(width/2.0, height/2.0);
  bullets = new ArrayList<bullet>();
}

void draw() {
  background(#030A1A);
  player.show();
  showBullets();
  if(time%frame==0){ 
    player.update();
    updateBullets();
  }
  if(mousePressed){
    
    if(charge<=maxCharge) charge+=chargeRate;
    println("charging: "+ charge);
  }else{
    charge = 0;
  }
  ++time;
}
