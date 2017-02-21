 class Common extends Actor{
  
  color c;  
  float runDist;
  
  Common(){
   c = color(255,255,0);
   runDist = 10*hSize;
  }
  
  void update(){
    
    super.update();
    //stack();  This should be collision

    for (Zombie z : zombies) {
       d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
          if (d < runDist) {
            PVector CZ = new PVector();
            CZ.set(pos); 
            CZ.sub(z.pos); 
            CZ.rotate(random(-PI/6, PI/6)); 
            CZ.normalize();
            vel.set(CZ);
          }
        }
     
     pos.add(vel);

  }
  
  void stack() {
    for (int i = 0; i < commons.size() - 1; i++) {
       d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
       if( d == 0){
         break;
       }
       if (d < 2*hSize) {
         commons.get(i).vel.rotate(PI+(random(1)));
         commons.get(i).pos.add(commons.get(i).vel.normalize());
       }
     } 
   } 
 
 void show(){
   super.show(c);
 }

  void wander(){ }
  void evasion(){ }
  void obstacleAvoidance() { }
  
}