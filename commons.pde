class Common {
  PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  boolean visible = true;
  PVector direction = PVector.random2D();

  void move() {
    if (visible) {
      if (edges(pos.x, pos.y)) {
        direction.rotate(PI);
        pos.add(direction);
        pos.add(direction);
      }

      float r1 = random(1);
      if (r1 < 0.05) {
        direction.rotate(random(-PI/6, PI/6));
      }

      for (Zombie z : zombies) {
        float d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
        if (d < 6*hsize) {
          PVector CZ = new PVector();
          CZ.set(pos); 
          CZ.sub(z.pos); 
          CZ.rotate(random(-PI/6, PI/6)); 
          CZ.normalize();
          direction = CZ;
        }
      }
      pos.add(direction);
    }

  }







  void show() {

    if (visible) {
      fill(0, 255, 0);
      stroke(0);
      strokeWeight(1);
      ellipse(pos.x, pos.y, hsize, hsize);
    }
  }
}