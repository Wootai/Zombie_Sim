class Actor {
  PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  boolean visible = true;
  PVector direction = PVector.random2D();
  
  //----- HERO PROPERTIES ------//
  //PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  //boolean visible = true;
  //PVector direction = PVector.random2D();
  
  //----- HERO SPECIFIC PROPERTIES ------//
  float firerange = 80; // Number of pixels
  float firespeed = 4; // Number of frames between shots
  float movespeed = 0.6; 
  
  //----- ZOMBIE PROPERTIES  ----------// 
  // z = new Zombie(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
  //PVector pos = new PVector();
  //boolean visible = true;
  //PVector direction = PVector.random2D();
  
  float zombieSpeed = 1.2;
 
  
  void commonMove() {
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
        if (d < 10*hsize) {
          PVector CZ = new PVector();
          CZ.set(pos); 
          CZ.sub(z.pos); 
          CZ.rotate(random(-PI/6, PI/6)); 
          CZ.normalize();
          direction.set(CZ);
        }
      }
      pos.add(direction);
    }

  }

 
void commonShow() {
  if (visible) {
      fill(0, 255, 0);
      stroke(0);
      strokeWeight(1);
      ellipse(pos.x, pos.y, hsize, hsize);
    }
  }

void heroMove() {
    if (visible) {
      direction.setMag(movespeed);
      if (edges(pos.x, pos.y)) {
        direction.rotate(PI);
        pos.add(direction);
        pos.add(direction);
      }

      float r1 = random(1);
      if (r1 < 0.01) {
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
          direction.set(CZ);
        }
      }

      pos.add(direction);
    }
  }

void heroShoot() {
    for (int i = zombies.size() - 1; i >= 0; i--) {
      float d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
      if (d < firerange && frameCount % firespeed == 0) {
         trajectory(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);
         
         zombies.remove(i);
         
         break;
      }
    }
  }

void heroShow() {
    if (visible) {
      fill(0, 0, 255);
      stroke(0);
      strokeWeight(1);
      ellipse(pos.x, pos.y, hsize, hsize);
    }
  }
}



  void zombieMove() {

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

void zombieShow() {
    fill(255, 0, 0);
    strokeWeight(1);
    stroke(0);
    ellipse(pos.x, pos.y, hsize, hsize);
  }
}
