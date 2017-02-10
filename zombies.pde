class Zombie {
  PVector pos = new PVector(random(width), random(height));
  boolean visible = true;
  
  
  
  void show() {
    fill(255,0,0);
    ellipse(pos.x, pos.y, hsize, hsize);
    
  }
}