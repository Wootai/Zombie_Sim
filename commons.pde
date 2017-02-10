class Common {
  PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  boolean visible = true;
  PVector direction = PVector.random2D();

  void move() {
    if (edges()) {
      direction.rotate(HALF_PI);
    }

    float r1 = random(1);
    if (r1 < 0.01) {
      direction.rotate(PI/6);
    }

    for (Zombie z : zombies) {
      float d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
      if (d < 5*hsize) {
        float r2 = random(2*PI/3, 5*PI/3);
        direction.rotate(r2);
      }
    }
    pos.add(direction);
  }



  boolean edges() {
    return (pos.x + hsize > width || pos.x - hsize < 0 || pos.y + hsize > height || pos.y - hsize < 0);
  }



  void show() {
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, hsize, hsize);
  }
}