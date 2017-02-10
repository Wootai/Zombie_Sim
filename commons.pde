class Commons {
  PVector pos = new PVector();
  boolean visible = true;
  
  
  
  void show() {
    fill(0,255,0);
    ellipse(pos.x, pos.y, 4, 4);
  }
}