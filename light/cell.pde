class cell{
  PVector pos;
  color c;
  float diff;
  
  cell(PVector pos, color c){
    this.pos = pos;
    this.c = c;
    this.diff = sqrt(pow(red(c)-red(spectrum), 2)+pow(green(c)-green(spectrum),2)+pow(blue(c)-blue(spectrum),2));
  }
  void show(){
    noStroke();
    fill(c);
    text(diff, pos.x-20, pos.y-20);
    ellipse(pos.x, pos.y, 10, 10);
  }
}
