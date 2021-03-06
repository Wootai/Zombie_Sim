class Zombie extends Actor{
   
  color c = color(0,150,0);
  float mindDist = height * width; 
  float minX = 0;
  float minY = 0;
  int closestC;
  int closestH;
  float prevMinDist;   
  PVector victim;
     
  Zombie(){
   super();
   maxSpeed = 1.2;
   maxForce = 1.2;

  }
     
  void update() { //<>//
    
    super.update();
    
    if(prevMinDist == mindDist){mindDist=height*width;}
        
    // Moving the zombie towards its closest pray
    for (int i = commons.size()-1; i>=0; i--){
      d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
      if (d < mindDist) {
        mindDist = d;
        victim = new PVector(commons.get(i).pos.x, commons.get(i).pos.y);
      }
    }
    
    for (int i = heroes.size()-1; i>= 0; i--){
      d = dist(pos.x, pos.y, heroes.get(i).pos.x, heroes.get(i).pos.y);  //<>// //<>//

      if (d < mindDist) {
        mindDist = d;
        victim = new PVector(heroes.get(i).pos.x, heroes.get(i).pos.y);
      }
    }
    
    vel.add(super.seek(victim));

    pos.add(vel);
    prevMinDist = mindDist;
   
    bite();
    for (Zombie z: zombies){
      if(dist(z.pos.x, z.pos.y, pos.x, pos.y) < hSize*5){
        //line(pos.x, pos.y, z.pos.x, z.pos.y); //Debug line between Zombies
        //flock(z.pos);

      }
   }
      
       
    stack();
  
  }
  
  void show() {
    if(victim != null){
      line(pos.x, pos.y, victim.x, victim.y);//Debug line between Zombie and Victim
    }
    super.show(c);
  }
  
  void bite() {
    for (int i = commons.size() - 1; i >= 0; i--) {
       d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
       if (d < hSize) {
         zombifie(commons.get(i));
         break;
        }
    }
  
    for (int i = heroes.size() - 1; i >= 0; i--) {
        d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, pos.x, pos.y);
        if (d < hSize) {
          zombifie(heroes.get(i));
          break;
        }
      }
    }

  void zombifie(Object o){
     z = new Zombie();
     if(o instanceof Common && !(o instanceof Hero) ){
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
      
  void stack() {
    for (int i = 0; i < zombies.size() - 1; i++) {
      d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);
         if( d == 0){
           break;
         }
         if (d < hSize+1) {
           zombies.get(i).vel.rotate(random(PI*3/4, PI*5/4));
           zombies.get(i).pos.add(zombies.get(i).vel);
         }
       } 
     } 
     
  void die(){
  }
  

}