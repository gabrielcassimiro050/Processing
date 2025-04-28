Inventory inventory;
HashMap<String, String> materialNames;
HashMap<String, Integer> materialTextures;

int nMaterials = 0;
ArrayList<Integer> subIds;

void createMaterial(String name, color texture) {
  materialNames.put(nMaterials+"-0", name);
  materialTextures.put(nMaterials+"-0", texture);
  subIds.add(1);
  nMaterials++;
}

void createMaterial(int id, String name, color texture) {
  if(id>=subIds.size()) return;
  int subId = subIds.get(id);
  materialNames.put(id+"-"+subId, name);
  materialTextures.put(id+"-"+subId, texture);
  subIds.set(id, subIds.get(id)+1);
}

void setup() {
  size(750, 750);
  materialNames = new HashMap<String, String>();
  materialTextures = new HashMap<String, Integer>();
  subIds = new ArrayList<Integer>();
  
  //Oak Wood
  createMaterial("Oak Wood", #553206);
  //Acacia Wood
  createMaterial(0, "Acacia Wood", #987B67);
  
  //Stone
  createMaterial("Stone", #90979B);
  //Limestone
  createMaterial(1, "Limestone", #90979B);
  
  
  inventory = new Inventory();
  inventory.addMaterial(0, 10);
  inventory.addMaterial(0, 1, 10);
  inventory.addMaterial(1, 5);
  inventory.addMaterial(1, 1, 5);
  inventory.display();
}

void draw() {
}
