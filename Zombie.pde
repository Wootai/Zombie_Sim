class Zombie extends Actor{
   
  color c;
  float mindist = height * width; 
  float minx = 0;
  float miny = 0;
  float zombieSpeed = 1.2;
     
  void move() {
    border();
  
    // Moving the zombie towards its closest pray
    for (Common c : commons) {
      
        float d = dist(pos.x, pos.y, c.pos.x, c.pos.y);
        if (d < mindist) {
          mindist = d;
          minx = c.pos.x;
          miny = c.pos.y;
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
    direction.setMag(zombieSpeed);

    float r1 = random(1);
    
    if (r1 < 0.1) {
      direction.rotate(random(-PI/6, PI/6));
    }

    pos.add(direction);
  }
  
  void show() {
    stroke(0);
    strokeWeight(1);
    fill(0, 150, 0);    
    ellipse(pos.x, pos.y, hsize, hsize);
  }
    
  
  void stacking() {
   for (int j = 0; j < zombies.size(); j++) {
      float d = dist(pos.x, pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d==0)
        {
        break;
      }
      
      if (d < 0.5*hsize) {
        
        zombies.get(j).direction.rotate(random(PI*3/4, PI*5/4));
        zombies.get(j).pos.add(zombies.get(j).direction);
      }
    }
  }
  
  //void bite() {
  //  for (int i = commons.size() - 1; i >= 0; i--) {
  //    float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
  //      if(d<0){break;}
  //      if (d < commons.get(i).hsize) {
  //        float xPos = commons.get(i).pos.x;
  //        float yPos = commons.get(i).pos.y;
  //        Zombie zn;
  //        zn = new Zombie();
  //        zn.pos.x = xPos;
  //        zn.pos.y = yPos;
  //        commons.remove(i);
  //        zombies.add(zn);
  //      }
  //  }
  
  //  for (int i = heroes.size() - 1; i >= 0; i--) {
  //      float d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, pos.x, pos.y);
  //      if(d<0){break;}
  //      if (d < heroes.get(i).hsize) {
  //        float xPos = heroes.get(i).pos.x;
  //        float yPos = heroes.get(i).pos.y;
  //        z = new Zombie();
  //        z.pos.x = xPos;
  //        z.pos.y = yPos;
  //        zombies.add(z);
  //        heroes.remove(i);
  //      }
  //    }
  //  }
  
}