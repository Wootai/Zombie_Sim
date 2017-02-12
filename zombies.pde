class Zombie {
  PVector pos = new PVector();
  boolean visible = true;
  PVector direction = PVector.random2D();
  float speed = 1.2;

  Zombie(float x, float y) {
    pos.set(x, y);
  }

  void move() {

    if (edges(pos.x, pos.y)) {
      direction.rotate(HALF_PI);
      pos.add(direction);
      pos.add(direction);
    }


    // Moving the zombie towards its closest pray
    float mindist = height * width; 
    float minx = 0;
    float miny = 0;

    for (Common c : commons) {
      if (c.visible) {
        float d = dist(pos.x, pos.y, c.pos.x, c.pos.y);
        if (d < mindist) {
          mindist = d;
          minx = c.pos.x;
          miny = c.pos.y;
        }
      }
    }


    for (Hero h : heroes) {
      float d = dist(pos.x, pos.y, h.pos.x, h.pos.y);
      if (d < mindist) {
        mindist = d;
        minx = h.pos.x;
        miny = h.pos.y;
      }
    }

    PVector ZP = new PVector(minx - pos.x, miny - pos.y);
    direction = ZP;
    direction.setMag(speed);

    float r1 = random(1);
    if (r1 < 0.1) {
      direction.rotate(random(-PI/6, PI/6));
    }

    pos.add(direction);
  }


  void show() {
    fill(255, 0, 0);
    strokeWeight(1);
    stroke(0);
    ellipse(pos.x, pos.y, hsize, hsize);
  }
}