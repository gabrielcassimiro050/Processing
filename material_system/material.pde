class Material {
  int id, subId;
  int quantity;
  String name;
  color texture;

  Material(int id, String name, color texture, int initialQuantity) {
    this.id = id;
    this.subId = 0;
    this.quantity = initialQuantity;
    this.name = name;
    this.texture = texture;
  }

  Material(int id, int subId, String name, color texture, int initialQuantity) {
    this.id = id;
    this.subId = subId;
    this.quantity = initialQuantity;
    this.name = name;
    this.texture = texture;
  }

  void display() {
    print(quantity+" - "+name);
  }
}
