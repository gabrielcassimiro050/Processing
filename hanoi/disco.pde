class disco{
  float tamanho;
  
  disco(float tamanho){
    this.tamanho = tamanho;
  }
  
  void show(float x, float y){
    noStroke();
    rect(x, y, tamanho, altura+1);
  }
}
