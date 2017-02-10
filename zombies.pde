class Zombies {
  PVector pos = new PVector();
  boolean visible = true;
  
  
  
  void show() {
    fill(255,0,0);
    ellipse(pos.x, pos.y, 4, 4);
    
  }
}