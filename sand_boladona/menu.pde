class menu {
  PImage background = loadImage("menu_background.png");
  int nElements;
  PImage[] elements;

  void show() {
    image(background, 0, height-(floor*(height/(float)cols)), width, floor*(height/cols));
    for (int i = 0; i < nElements; ++i) {
      pushMatrix();
      translate(0, height-(floor*(height/(float)cols)));
      textFont(pixelFont);
      text(i+1+".", buttonSize/2+width/nElements*i-15, 5+10);
      image(elements[i], buttonSize/2+width/nElements*i, 5, buttonSize, buttonSize);
      popMatrix();
    }
  }
  
}
