class Zombie extends Actor{
   
  color c = color(0,150,0);
  float mindist = height * width; 
  float minx = 0;
  float miny = 0;
  float zombieSpeed = 1.2;
     
  void move() {
    super.move();
    
    // Moving the zombie towards its closest pray
    for (Common c : commons) {
      float d = dist(c.pos.x, c.pos.y, pos.x, pos.y);
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

    if (r1 < 0.1) {
      direction.rotate(random(-PI/6, PI/6));
    }

    pos.add(direction);
  }
  
  void show() {
    super.show(c);
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
  
  void bite() {
    for (int i = commons.size() - 1; i >= 0; i--) {
      float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
        if (d < commons.get(i).hsize) {
          zombifie(commons.get(i));
        }
    }
    for (int i = heroes.size() - 1; i >= 0; i--) {
        float d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, pos.x, pos.y);
        if(d<0){break;}
        if (d < heroes.get(i).hsize) {
          zombifie(heroes.get(i));
        }
    }
  }
   
   void zombifie(Object o){
     
     if(o instanceof Common){
      z = new Zombie();
      z.pos.x = commons.get(commons.indexOf(o)).pos.x;
      z.pos.y = commons.get(commons.indexOf(o)).pos.y;
      zombies.add(z);
      commons.remove(commons.indexOf(o));
      }

     if(o instanceof Hero){
      z = new Zombie();
      z.pos.x = heroes.get(heroes.indexOf(o)).pos.x;
      z.pos.y = heroes.get(heroes.indexOf(o)).pos.y;
      zombies.add(z);
      commons.remove(commons.indexOf(o));
      println("Zombified! Hero: " + o);
     }
   }   
}