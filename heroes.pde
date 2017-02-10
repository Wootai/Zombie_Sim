class Hero {
  PVector pos = new PVector(random(width), random(height));
  boolean visible = true;



  void show() {
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, hsize, hsize);
  }
}