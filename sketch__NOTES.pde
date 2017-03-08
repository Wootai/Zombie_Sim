/*

TODO:

* add Obstacles 
  - adjust adjust movement to go around obstacles
    -Update Zombie movement to integrate new steering algorithm to steer around obstacles.
    -Update Common 

 

* Untie Fire-rate from frame-rate

* Play Boomer animation when dying
  - slow the animation?

*Shotgun Hero Type:
  - Shoots Multiple Zombies

3rd Zombie type: One that explodes into many small fast zombies, that cannot kill heroes through contact.


3rd Hero type: Demolitions launches grenades and does AOE Damage.


Heroes with higher kill counts are more attractive to zombies.

  PVector arrival(PVector target) {
    PVector steer; // The steering vector
    PVector desired = PVector.sub(target, pos); // A vector pointing from current location to the target
    float distance = mag2(desired); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (distance > 0) {
      desired.normalize(); // Normalize desired
      if (distance < hSize*hSize) {
        distance = (float) Math.sqrt(distance);
        desired.mult(maxspeed*(distance/hSize)); // This damping is somewhat arbitrary
      }
      else desired.mult(maxforce);
      steer = PVector.sub(desired, vel); // Steering = Desired minus Velocity
    }
    else {
      steer = new PVector();
    }
    return steer;
  }

  PVector departure(PVector target) {
    PVector steer; // The steering vector
    PVector desired = PVector.sub(target, pos); // A vector pointing from current location to the target
    float distance = mag2(desired); // Distance from the target is the magnitude of the vector
    // If the distance is greater than 0, calc steering (otherwise return zero vector)
    if (distance > 0 && distance < (ARadius*100)*(ARadius*100)) {
      desired.normalize(); // Normalize desired
      if (distance < hSize*hSize) {
        distance = (float) Math.sqrt(distance);
        desired.mult(maxspeed*(hSize/hSize)); // This damping is somewhat arbitrary
      }
      else desired.mult(maxforce);
      steer = PVector.sub(vel, desired); // Steering = Desired minus Velocity
    }
    else {
      steer = new PVector();
    }
    return steer;
  }
  
  PVector pursue(ArrayList boids) {
    PVector steer = new PVector();
    if (prey < boids.size()) {
      Agent boid = (Agent) boids.get(prey);
      steer = PVector.sub(boid.pos, pos);
      steer.mult(maxpursue);
    }
    return steer;
  }
  
  PVector evade(ArrayList predators) {
    PVector steer = new PVector();
    for (int i = 0; i < predators.size(); i++) {
      Agent predator = (Agent) predators.get(i);
      float distance = dist2(pos, predator.pos);
      if (distance < ERadius*ERadius) {
        action = 1;
        steer = flee(predator.pos);
        steer.mult(maxevade);
        return steer;
      }
    };
    return steer;
  }

  PVector wander() {
    wdelta += random(-NRadius, NRadius); // Determine noise ratio
    // Calculate the new location to steer towards on the wander circle
    PVector center = vel.get(); // Get center of wander circle
    center.mult(60.0); // Multiply by distance
    center.add(pos); // Make it relative to boid's location
    // Apply offset to get new target    
    PVector offset = new PVector(WRadius*cos(wdelta), WRadius*sin(wdelta));
    PVector target = PVector.add(center, offset); // Determine new target
    // Steer toward new target    
    PVector steer = seek(target); // Steer towards it    
    return steer;
  }
  
  PVector avoid(ArrayList objs) {
    PVector steer  = new PVector();    

    for (int i = 0; i < objs.size(); i++) {
      Obj obj = (Obj) objs.get(i);
      // Distance between object and avoidance sphere
      float distance = dist2(obj.pos, pos);
      // If distance is less than the sum of the two radius, there is collision
      float bound = obj.mass*0.5 + BRadius + ORadius;
      if (distance < bound*bound) {
        wAvo = 10.0;
        wWan = 0.1;
        float collision = (obj.mass + mass)*0.5;
        if (distance < collision*collision) {
          steer = PVector.sub(pos, obj.pos);
          steer.mult(maxforce*0.1);
          return steer;
        }
        else {
          float direction = dist2(obj.pos, PVector.add(pos, vel));
          // If is heading toward obstacle
          if (direction < distance) {
            // If steering in the verticle direction
            if (abs(vel.x) <= abs(vel.y)) {   
              steer = new PVector((pos.x - obj.pos.x), vel.y);
              steer.mult(maxforce*((bound*bound)/distance)*0.001);       
            }
            // If steering in the horizontal direction
            else {
              steer = new PVector(vel.x, (pos.y - obj.pos.y));
              steer.mult(maxforce*((bound*bound)/distance)*0.001);  
            }
          }
        }
      }
    }
    return steer;
  }

  PVector flocking(ArrayList boids) {
    // Get steering forces
    PVector steer = new PVector();
    PVector coh = new PVector(); // Perceived center
    PVector sep = new PVector(); // Displacement
    PVector ali = new PVector(); // Perceived velocity
    int count = 0;
    // Agents try to fly towards the centre of mass of neighbouring agents
    // Agents try to keep a small distance away from other objects (including other agents)
    // Agents try to match velocity with near agents
    for (int i = 0; i < boids.size(); i++) {
      Agent boid = (Agent) boids.get(i);
      float distance = dist2(pos, boid.pos);
      // Go through each agents
      if (this != boid && distance < Rn*Rn) {
        coh.add(boid.pos); // Cohesion
        ali.add(boid.vel); // Alignment
        count++;
      }      
      // Separation
      if (this != boid && distance < SDistance*SDistance) {
        PVector diff = PVector.sub(boid.pos, pos); // (agent.position - bJ.position)
        diff.normalize();
        distance = (float) Math.sqrt(distance);
        diff.div(distance); // Weighed by distance
        sep.sub(diff); // c = c - (agent.position - bJ.position)
      }
    }
    if (count > 0) {
      // Cohesion - Step towards the center of mass
      coh.div((float)count); // cJ = pc / (N-1)
      coh.sub(pos); // (pcJ - bJ.position)
      coh.mult(CStep); // (pcJ - bJ.position) / 100
    // Alignment - Find average velocity
      ali.div((float)count); // pvJ = pvJ / N-1
      ali.sub(vel); // (pvJ - bJ.velocity)
      ali.mult(AVelocity); // (pvJ - bJ.velocity) / 8
    }
    // Apply weights
    coh.mult(wCoh);
    sep.mult(wSep);
    ali.mult(wAli);
    // Accumulate forces
    steer.add(coh);
    steer.add(sep);
    steer.add(ali);
    // Add speed
    steer.mult(maxspeed);
    return steer;
  }

*/