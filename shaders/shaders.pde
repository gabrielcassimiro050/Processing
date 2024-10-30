int time = 0;
PImage munchikin;

color randomColor() {
  return color(random(50, 200), random(50, 200), random(50, 200));
}

void blur() {
  loadPixels();
  for (int x = 0; x < width; ++x) {
    for (int y = 0; y < height; ++y) {
      int t = 0;
      int r = 0, g = 0, b = 0;
      if (x+1 < width) {
        r += pow(red(pixels[x+1+width*y]), 2);
        g += pow(green(pixels[x+1+width*y]), 2);
        b += pow(blue(pixels[x+1+width*y]), 2);
        ++t;
      }
      if (x-1 >= 0) {
        r += pow(red(pixels[x-1+width*y]), 2);
        g += pow(green(pixels[x-1+width*y]), 2);
        b += pow(blue(pixels[x-1+width*y]), 2);
        ++t;
      }
      if (y+1 < height) {
        r += pow(red(pixels[x+width*(y+1)]), 2);
        g += pow(green(pixels[x+width*(y+1)]), 2);
        b += pow(blue(pixels[x+width*(y+1)]), 2);
        ++t;
      }
      if (y-1 >= 0) {
        r += pow(red(pixels[x+width*(y-1)]), 2);
        g += pow(green(pixels[x+width*(y-1)]), 2);
        b += pow(blue(pixels[x+width*(y-1)]), 2);
        ++t;
      }
      pixels[x+width*y] = color(sqrt(r/t), sqrt(g/t), sqrt(b/t));
    }
  }
  updatePixels();
}

void blur(int nIterations) {
  for (int i = 0; i < nIterations; ++i) {
    loadPixels();
    for (int x = 0; x < width; ++x) {
      for (int y = 0; y < height; ++y) {
        int t = 0;
        int r = 0, g = 0, b = 0;
        if (x+1 < width) {
          r += pow(red(pixels[x+1+width*y]), 2);
          g += pow(green(pixels[x+1+width*y]), 2);
          b += pow(blue(pixels[x+1+width*y]), 2);
          ++t;
        }
        if (x-1 >= 0) {
          r += pow(red(pixels[x-1+width*y]), 2);
          g += pow(green(pixels[x-1+width*y]), 2);
          b += pow(blue(pixels[x-1+width*y]), 2);
          ++t;
        }
        if (y+1 < height) {
          r += pow(red(pixels[x+width*(y+1)]), 2);
          g += pow(green(pixels[x+width*(y+1)]), 2);
          b += pow(blue(pixels[x+width*(y+1)]), 2);
          ++t;
        }
        if (y-1 >= 0) {
          r += pow(red(pixels[x+width*(y-1)]), 2);
          g += pow(green(pixels[x+width*(y-1)]), 2);
          b += pow(blue(pixels[x+width*(y-1)]), 2);
          ++t;
        }
        pixels[x+width*y] = color(sqrt(r/t), sqrt(g/t), sqrt(b/t));
      }
    }
    updatePixels();
  }
}

void blur(PImage img, int nIterations) {
  for (int i = 0; i < nIterations; ++i) {
    img.loadPixels();
    for (int x = 0; x < img.width; ++x) {
      for (int y = 0; y < img.height; ++y) {
        int t = 0;
        int r = 0, g = 0, b = 0;
        if (x+1 < img.width) {
          r += pow(red(img.pixels[x+1+img.width*y]), 2);
          g += pow(green(img.pixels[x+1+img.width*y]), 2);
          b += pow(blue(img.pixels[x+1+img.width*y]), 2);
          ++t;
        }
        if (x-1 >= 0) {
          r += pow(red(img.pixels[x-1+img.width*y]), 2);
          g += pow(green(img.pixels[x-1+img.width*y]), 2);
          b += pow(blue(img.pixels[x-1+img.width*y]), 2);
          ++t;
        }
        if (y+1 < img.height) {
          r += pow(red(img.pixels[x+img.width*(y+1)]), 2);
          g += pow(green(img.pixels[x+img.width*(y+1)]), 2);
          b += pow(blue(img.pixels[x+img.width*(y+1)]), 2);
          ++t;
        }
        if (y-1 >= 0) {
          r += pow(red(img.pixels[x+img.width*(y-1)]), 2);
          g += pow(green(img.pixels[x+img.width*(y-1)]), 2);
          b += pow(blue(img.pixels[x+img.width*(y-1)]), 2);
          ++t;
        }
        img.pixels[x+img.width*y] = color(sqrt(r/t), sqrt(g/t), sqrt(b/t));
      }
    }
    img.updatePixels();
  }
}

void quantization(float groupingValue) {
  loadPixels();
  for (int x = 0; x < width; ++x) {
    for (int y = 0; y < height; ++y) {
      color pix = pixels[x+width*y];
      float r = red(pix), g = green(pix), b = blue(pix);
      r = round(groupingValue*r/255)*(255/groupingValue);
      g = round(groupingValue*g/255)*(255/groupingValue);
      b = round(groupingValue*b/255)*(255/groupingValue);
      pixels[x+width*y] = color(r, g, b);
    }
  }
  updatePixels();
}

void quantization(PImage img, float groupingValue) {
  img.loadPixels();
  for (int x = 0; x < img.width; ++x) {
    for (int y = 0; y < img.height; ++y) {
      color pix = img.pixels[x+img.width*y];
      float r = red(pix), g = green(pix), b = blue(pix);
      r = round(groupingValue*r/255)*(255/groupingValue);
      g = round(groupingValue*g/255)*(255/groupingValue);
      b = round(groupingValue*b/255)*(255/groupingValue);
      img.pixels[x+img.width*y] = color(r, g, b);
    }
  }
  img.updatePixels();
}

void setup() {
  background(0);
  size(750, 500);
  munchikin = new PImage();
  munchikin = loadImage("munchikin.jpg");

  quantization(munchikin, 10);
  image(munchikin, 0, 0, width/2.0, height);
  
  blur(munchikin, 10);
  image(munchikin, width/2.0, 0, width/2.0, height);
}

void draw() {
}
