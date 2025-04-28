class Inventory {
  ArrayList<Material> materials;

  Inventory() {
    materials = new ArrayList<Material>();
  }

  void addMaterial(int id, int subId, int quantity) {
    String key = id+"-"+subId;
    
    if(!materialNames.containsKey(key)) return;
    if(!materialTextures.containsKey(key)) return;
    
    for (Material m : materials) {
      if (m.id == id && m.subId == subId) {
        m.quantity += quantity;
        return;
      }
    }

    Material material = new Material(id, subId, materialNames.get(key), materialTextures.get(key), quantity);
    materials.add(material);
  }

  void addMaterial(int id, int quantity) {
    String key = id+"-"+0;

    for (Material m : materials) {
      if (m.id == id && m.subId == 0) {
        m.quantity+=quantity;
        return;
      }
    }

    Material material = new Material(id, 0, materialNames.get(key), materialTextures.get(key), quantity);
    materials.add(material);
  }

  void display() {
    //println(materials.size());
    for (Material m : materials) {
      m.display();
      println();
    }
  }
}
