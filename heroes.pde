class Hero {
  PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  boolean visible = true;
  PVector direction = PVector.random2D();


  void move() {

    if (visible) {
      direction.setMag(0.7);
      if (edges(pos.x, pos.y)) {
        direction.rotate(HALF_PI);
      }

      float r1 = random(1);
      if (r1 < 0.01) {
        direction.rotate(random(-PI/6, PI/6));
      }


      pos.add(direction);
    }
  }


  void show() {
    if (visible) {
      fill(0, 0, 255);
      ellipse(pos.x, pos.y, hsize, hsize);
    }
  }
}