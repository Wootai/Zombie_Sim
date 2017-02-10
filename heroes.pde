class Heroes {
  PVector pos = new PVector();
  boolean visible = true;



  void show() {
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, 4, 4);
  }
}