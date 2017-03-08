 class Common extends Actor{
  
  color c;  
  float runDist;
  PVector flee;
  float minDist;
  
  Common(){
   c = color(255,255,0);
   runDist = 10*hSize;
   maxForce = 5;

   minDist = width*height;

  }
  
  void update(){
    acc.mult(0);
    super.update();
    
    //for (int i = zombies.size()-1; i>=0; i--){
    //  println(acc);
    //  acc.add(flee(zombies.get(i).pos));
    //}
   PVector flee = evade(zombies);
   acc.add(flee);
   vel.add(acc);
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