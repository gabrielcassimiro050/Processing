ArrayList<String> biomes, lifeForms, lifeFormsImages;

String biome, lifeForm;
PImage lifeFormImage;

void showDesc() {
  imageMode(CENTER);
  float x = map(lifeFormImage.width, 0, lifeFormImage.width, 0,  lifeFormImage.width/5.0);
  float y = map(lifeFormImage.height, 0, lifeFormImage.height, 0,  lifeFormImage.height/5.0);
  image(lifeFormImage, width/2.0, height/2.0, x, y);
  
  textAlign(CENTER);
  textSize(20);
  text(lifeForm, width/10.0, height/10.0);
  textSize(15);
  text(biome, width/10.0, height/10.0+height/15.0);

  
}

void randomDesc() {
  biome = biomes.get(floor(random(biomes.size())));
  lifeForm = lifeForms.get(floor(random(lifeForms.size())));

  
  ArrayList<String> possibleImages = new ArrayList<String>();
  for (String image : lifeFormsImages) {
    if (image.contains(lifeForm)) {
      possibleImages.add(image);    
    }
  }

  int imageIndex = (int)random(possibleImages.size());
  println(possibleImages);
  println(imageIndex);
  if(!possibleImages.isEmpty())lifeFormImage = loadImage("/lifeFormsImages/"+possibleImages.get(imageIndex));
}

void loadFiles() {
  String[] biomesText = loadStrings("biomes.txt");
  String[] lifeFormsText = loadStrings("lifeForms.txt");


  String path = sketchPath()+"/data/lifeFormsImages";
  String[] images;
  //println(path);
  File folder = new File(path);
  images = folder.list();

  biomes = new ArrayList<String>();
  lifeForms = new ArrayList<String>();
  lifeFormsImages = new ArrayList<String>();


  for (String s : biomesText) biomes.add(s);
  for (String s : lifeFormsText) lifeForms.add(s);
  for (String s : images) lifeFormsImages.add(s);
}

void mouseReleased() {
  randomDesc();
}

void setup() {
  size(1200, 500);
  loadFiles();
  randomDesc();
}

void draw() {
  background(#2E2822);
  showDesc();
}
