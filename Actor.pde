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
  PVector vel; //Velocity
  float maxForce; //Maximum Force
  float maxSpeed; // Maximum speed (1 for commons Faster for Zombies)
  PVector direction; //Direction
  

  Actor() {

    direction = PVector.random2D();
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
          direction.rotate(random(HALF_PI, PI));
          pos.add(direction);
          pos.add(direction);
        }
      }
    
    if (pos.x + hSize*.5 > width || pos.x - hSize*.5 < 0 || pos.y + hSize*.5 > height || pos.y - hSize*.5 < 0) {
      direction.rotate(PI);
      pos.add(direction);
      pos.add(direction);
    }
  }

  void show(color c) {
    stroke(0);
    strokeWeight(1);
    fill(c);
    ellipse(pos.x, pos.y, hSize, hSize);
    line(pos.x, pos.y, pos.x+direction.x*20, pos.y+direction.y*20);

  }
 
  void validate(){ }

  

}