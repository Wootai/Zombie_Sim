class Actor implements ActorI {
  
  PVector pos; // Position
  PVector vel; // Velocity
  PVector acc; // Acceleration
  PVector feeler; // feeler vector for collision detection


  float maxForce; //Maximum Force that can be applied to an actor
  float maxSpeed; // Maximum speed, 1 for commons Faster for Zombies
  float hSize;    // Diameter of Circle
  float d;        // Distance variable

  boolean obsValid = false;  // Obstacle collision variable for creation

  Actor() {
    maxForce = 1;   // MaxForce that can bee applied to Actor
    maxSpeed = 1;   // MaxSpeed of an actor
    hSize = 10;     // Diameter of circle.

    pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));  // Set initial position Vector
    vel = PVector.random2D();                                                             // Set initial Velocity Vector
    feeler = new PVector(pos.x+vel.x*20, pos.y+vel.y*20);                                 // Create Feeler vector infront of velocity Vector
    acc = new PVector(0,0);                                                               // initialize Acceleration to 0
    
    //================ Check position against obstacles to prevent spawing inside obstacles =======
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
    //================ Finish Check
    }
  
  void update() {
    
    //Obstacle Avoidance
    acc.add(avoid(obstacles));      //Obstacle Avoidance for all Actors

    feeler = new PVector(pos.x+vel.x*20, pos.y+vel.y*20);
    if (feeler.x > width || feeler.x - hSize*.5 < 0 || feeler.y + hSize*.5 > height || feeler.y - hSize*.5 < 0) {
      vel.rotate(random(PI-HALF_PI, PI+HALF_PI));
      pos.add(vel);
      }
    }

  void show(color c) {
    stroke(0);
    strokeWeight(1);
    fill(c);
    ellipse(pos.x, pos.y, hSize, hSize);
    
    ellipse(feeler.x, feeler.y, 5, 5);
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
    if (distance < hSize*10 ) {
      desired.normalize(); // Normalize desired
      desired.mult(maxForce);
      steer = PVector.sub(vel, desired); // Steering = Desired minus Velocity
    }
    else {
      steer = new PVector(0, 0);
    }
    return steer;
  }
  
  PVector pursue(PVector target) {
    PVector steer = new PVector();
    steer = PVector.sub(target, pos);
    steer.mult(maxForce);
    return steer;
  }
  
  PVector avoid(ArrayList<Obstacle> objs){
    PVector steer = new PVector();
    for(Obstacle o : objs){
      steer.add(flee(o.pos));
    }
    return steer;
  }
 
}