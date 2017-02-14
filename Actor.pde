class Actor {
    int type;
    
    //Zombie = 0 ; Common = 1 ; Hero = 2
    
    PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
    PVector direction = PVector.random2D();
 
    float firerange = 80; // Number of pixels
    float firespeed = 4; // Number of frames between shots
    float movespeed = 0.6; 
  
    float zombieSpeed = 1.2;
    

    Actor(int t){
        type = t;
      }
    
    
    void move() {
      if (type == 1) {
          if (edges(pos.x, pos.y)) {
              direction.rotate(PI);
              pos.add(direction);
              pos.add(direction);
          }

      float r1 = random(1);

      if (r1 < 0.05) {
          direction.rotate(random(-PI/6, PI/6));
      }

      for (Actor z : zombies) {
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
    
    if (type == 2) {
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

        for (Actor z : zombies) {
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
        heroShoot();
      }
   
   if(type == 0){
      if (edges(pos.x, pos.y)) {
          direction.rotate(HALF_PI);
          pos.add(direction);
          pos.add(direction);
      }

      // Moving the zombie towards its closest pray

      float mindist = height * width; 
      float minx = 0;
      float miny = 0;

      for (Actor c : commons) {
        if (c.type == 1) {
          float d = dist(pos.x, pos.y, c.pos.x, c.pos.y);
          if (d < mindist) {
            mindist = d;
            minx = c.pos.x;
            miny = c.pos.y;
          }
        }
      }

      for (Actor h : heroes) {
        float d = dist(pos.x, pos.y, h.pos.x, h.pos.y);
        if (d < mindist) {
          mindist = d;
          minx = h.pos.x;
          miny = h.pos.y;
        }
      }

      PVector ZP = new PVector(minx - pos.x, miny - pos.y);
      direction = ZP;
      direction.setMag(zombieSpeed);

      float r1 = random(1);
      if (r1 < 0.1) {
        direction.rotate(random(-PI/6, PI/6));
      }

      pos.add(direction);
    }
   }
   

  void heroShoot() {
      for (int i = zombies.size() - 1; i >= 0; i--) {
        float d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
        if (d < firerange && frameCount % firespeed == 0) {
           stroke(167, 240, 44);
           strokeWeight(4);
           line(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);
           zombies.remove(i);
           break;
        }
      }
    }

  void show() {
      stroke(0);
      strokeWeight(1);
   
    if (type == 1) {
        fill(0, 255, 0);
        }
    if (type == 2) {
        fill(0, 0, 255);
      }
    if (type == 0){
      fill(255, 0, 0);
     }
    
    ellipse(pos.x, pos.y, hsize, hsize);
  }

  boolean edges(float x, float y) {
    return (x + hsize > width || x - hsize < 0 || y + hsize > height || y - hsize < 0);
  }

}
