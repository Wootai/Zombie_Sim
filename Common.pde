 class Common extends Actor{
  
  color c;  
  float runDist;
  PVector flee;
  float minDist;
  
  Common(){
   c = color(255,255,0);
   runDist = 10*hSize;
   maxForce = 10;
   minDist = width*height;

  }
  
  void update(){
    
    super.update();
    
    for (int i = zombies.size()-1; i>=0; i--){
      d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);
      if (d < runDist) {
        flee = zombies.get(i).pos;
        vel.add(flee(flee));
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