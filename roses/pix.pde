class pix {
  int type;
  color c;

  pix(int type) {
    this.type = type;
    switch(type) {
    case 0:
      this.c = 255;
      break;
    case 1:
      this.c = 0;
      break;
    }
  }
}
