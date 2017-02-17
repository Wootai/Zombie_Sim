class Zombie extends Actor{
   
  color c = color(0,150,0);
  float mindist = height * width; 
  float minx = 0;
  float miny = 0;
  float zombieSpeed = 1.2;
  float d;
  int closestC;
  int closestH;
  float prevMinDist;   
     
     
  void update() { //<>//
    
    // Have to change all this code.
    // Removing target from Arraybreaks the update code of the Zombie
    
    
    super.update();
    if(mindist <= hsize || prevMinDist == mindist){mindist=height*width;}
    
    //if (commons.size() == 0 && heroes.size() == 0){
    //  PVector ZP = PVector.random2D();
    //  direction = ZP;
    //  direction.setMag(zombieSpeed);
    //  pos.add(direction);
    //}
    
    // Moving the zombie towards its closest pray
    for (int i = commons.size()-1; i>=0; i--){
      closestC = i;
      float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
      if (d < mindist) {
        mindist = d;
        minx = commons.get(i).pos.x;
        miny = commons.get(i).pos.y;
      }
    }
    
    for (int i = heroes.size()-1; i>= 0; i--){
      closestH = i;
      d = dist(pos.x, pos.y, heroes.get(i).pos.x, heroes.get(i).pos.y); //<>//
      if (d < mindist) {
        mindist = d;
        minx = heroes.get(i).pos.x;
        miny = heroes.get(i).pos.y;
      }
    }
    
    if(heroes.size()>0){
      if(heroes.contains(heroes.get(closestH)) == false){
        update();
      }
    }
    
    if(commons.size()>0){
      if(commons.contains(commons.get(closestC)) == false ){
        update();
      }
    }
    
    PVector ZP = new PVector(minx - pos.x, miny - pos.y);
    direction = ZP;
    direction.setMag(zombieSpeed);

    //if (r1 < 0.1) {
    //  direction.rotate(random(-PI/6, PI/6));
    //}

    pos.add(direction);
    prevMinDist = mindist;
   
   bite();
  
  }
  
  void show() {
    super.show(c);
  }
  
  void bite() {
    for (int i = commons.size() - 1; i >= 0; i--) {
       d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
       if (d < commons.get(i).hsize) {
         zombifie(commons.get(i));
         break;
        }
    }
  
    for (int i = heroes.size() - 1; i >= 0; i--) {
        d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, pos.x, pos.y);
        if (d < heroes.get(i).hsize) {
          zombifie(heroes.get(i));
          break;
        }
      }
    }

  void zombifie(Object o){
     z = new Zombie();
     if(o instanceof Common){
       z.pos.x = commons.get(commons.indexOf(o)).pos.x;
       z.pos.y = commons.get(commons.indexOf(o)).pos.y;
       zombies.add(z);
       commons.remove(commons.indexOf(o));
      
     }

     if(o instanceof Hero){
       z.pos.x = heroes.get(heroes.indexOf(o)).pos.x;
       z.pos.y = heroes.get(heroes.indexOf(o)).pos.y;
       zombies.add(z);
       heroes.remove(heroes.indexOf(o));
    }
  }   

}