class Actor implements ActorI { //<>//
  
  float hSize = 10;
  color c = color(0, 0, 255);
  float r1;
  float d;
  boolean obsValid = false;
  //boolean actValid = false;

//Simple Vehicle Model:
//mass scalar
//  position      vector
//  velocity      vector
//  max_force     scalar
//  max_speed     scalar
//  orientation   N basis vectors

  float mass; // will equal 1 for now
  PVector pos; //position same
  float maxForce; //Maximum Force
  float maxSpeed; // Maximum speed (1 for commons Faster for Zombies)
  PVector vel; //Direction
  

  Actor() {
    mass = 1;
    pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
    maxForce = .1;
    maxSpeed = 1;
    vel = PVector.random2D();
    pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));

    while(!obsValid){
      for(Obstacle o: obstacles){
          if (pos.x > o.x - hSize * 2
              && pos.x  < o.maxX + hSize * 2
              && pos.y  > o.y - hSize * 2 
              && pos.y < o.maxY + hSize * 2){ 
              obsValid = false;
              pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
  
            }
           else {obsValid = true;}
          }
        }
      }

  void update() {

    if (pos.x > width) {
      pos.x = width-hSize+1;
    }
    if (pos.x < 0) {
      pos.x = hSize+1;
    }
    if (pos.y > height) {
      pos.y = height - hSize+1;
    }
    if (pos.y < 0) {
      pos.y = hSize+1;
    }
    
    for(Obstacle o: obstacles){
      if (pos.x > o.x - hSize * 2 && pos.x < o.maxX + hSize * 2
            && pos.y  > o.y - hSize * 2 && pos.y < o.maxY + hSize * 2){ 
          vel.rotate(random(HALF_PI, PI));
          pos.add(vel);
          pos.add(vel);
        }
      }
    
    if (pos.x + hSize*.5 > width || pos.x - hSize*.5 < 0 || pos.y + hSize*.5 > height || pos.y - hSize*.5 < 0) {
      vel.rotate(PI);
      pos.add(vel);
      pos.add(vel);
    }
  }

  void show(color c) {
    stroke(0);
    strokeWeight(1);
    fill(c);
    ellipse(pos.x, pos.y, hSize, hSize);
    line(pos.x, pos.y, pos.x+vel.x*20, pos.y+vel.y*20);

  }
 
  
  
  PVector persue(PVector target){
  
    PVector t = target.copy();
    PVector desired = t.sub(pos);
    float d = desired.mag();
    float speed = maxSpeed;
        
    desired.setMag(speed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    return steer;
  }
  
  PVector flee(PVector target){  
    PVector t = target.copy();
    PVector desired = t.sub(pos);
    float d = desired.mag();
    float speed = maxSpeed;
        
    desired.setMag(speed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    steer.mult(-1);
    return steer;
  }
  
  PVector follow(PVector target){return target;}
  
  PVector wander(PVector target){return target;}
  
  PVector arrive(PVector target) {
    PVector t = target.copy();
    PVector desired = t.sub(pos);
    float d = desired.mag();
    float speed = maxSpeed;
    
    if (d < 100) {
      speed = map(d, 0, 100, 0, maxSpeed);
    }
    
    desired.setMag(speed);
    PVector steer = desired.sub(vel);
    steer.limit(maxForce);
    return steer;
  }
  
  
  

}