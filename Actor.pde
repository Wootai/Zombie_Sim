class Actor implements ActorI {  //<>//
  
  float mass;
  float energy;
  PVector pos; // Position
  PVector vel; // Velocity
  PVector acc; // Acceleration
  int type; // Agent type
  float wdelta; // Wander delta
  int action; // Current action
  int prey; // Predator's target
  
  float hSize = 10;
  color c = color(0, 0, 255);
  float r1;
  float d;
  boolean obsValid = false;
  float runDist;

  float maxForce; //Maximum Force
  float maxSpeed; // Maximum speed (1 for commons Faster for Zombies)
  PVector feeler; // feeler vector for collision detection
  

  Actor() {
    mass = 1;
    pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
    maxForce = 1;
    maxSpeed = 1;
    vel = PVector.random2D();
    pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
    feeler = new PVector(pos.x+vel.x*20, pos.y+vel.y*20);
    acc = new PVector();

    
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
    
    feeler.x = pos.x+vel.x*20;
    feeler.y = pos.y+vel.y*20;

    if (feeler.x > width) {
      pos.x = width-hSize+1;
    }
    if (feeler.x < 0) {
      pos.x = hSize+1;
    }
    if (feeler.y > height) {
      pos.y = height - hSize+1;
    }
    if (feeler.y < 0) {
      pos.y = hSize+1;
    }
    
    for(Obstacle o: obstacles){
      
      if (feeler.x > o.x && feeler.x < o.maxX
            && feeler.y  > o.y && pos.y < o.maxY){
              flee(feeler);          
            }
          }
    
    if (feeler.x > width || feeler.x - hSize*.5 < 0 || feeler.y + hSize*.5 > height || feeler.y - hSize*.5 < 0) {
      vel.rotate(random(PI-HALF_PI, PI+HALF_PI));
      pos.add(vel);
      //pos.add(vel);
    }


  }

  void show(color c) {
    stroke(0);
    strokeWeight(1);
    fill(c);
    ellipse(pos.x, pos.y, hSize, hSize);
    
    ellipse(feeler.x, feeler.y, 5, 5);
    //rect(pos.x, pos.y-hSize*.5, vel.mag()*20, hSize);
    line(pos.x, pos.y, pos.x+vel.x*20, pos.y+vel.y*20);

  }
   
 PVector seek(PVector target) {
    PVector steer; // The steering vector
    PVector desired = PVector.sub(target, pos); // A vector pointing from current location to the target
    float distance = mag2(desired); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (distance > 0) {     
      desired.normalize(); // Normalize desired
      desired.mult(maxForce);
      steer = PVector.sub(desired, vel); // Steering = Desired minus Velocity
    }
    else {
      steer = new PVector(0, 0);
    }
    return steer;
  }

  PVector flee(PVector target) {
    PVector steer; // The steering vector
    PVector desired = PVector.sub(target, pos); // A vector pointing from current location to the target
    float distance = mag2(desired); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (distance < runDist) {
      desired.normalize(); // Normalize desired
      desired.mult(maxForce);
      steer = PVector.sub(vel, desired); // Steering = Desired minus Velocity
    }
    else {
      steer = new PVector(0, 0);
    }
    return steer;
  }
  

}