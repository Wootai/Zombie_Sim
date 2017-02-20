 class Common extends Actor{
  
  color c = color(255,255,0);  
  
  void update(){
    
    super.update();
    stack();

    for (Zombie z : zombies) {
       d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
          if (d < 10*hSize) {
            PVector CZ = new PVector();
            CZ.set(pos); 
            CZ.sub(z.pos); 
            CZ.rotate(random(-PI/6, PI/6)); 
            CZ.normalize();
            direction.set(CZ);
          }
        }
     
     pos.add(direction);

  }
  
  void stack() {
    for (int i = 0; i < commons.size() - 1; i++) {
       d = dist(commons.get(i).pos.x, commons.get(i).pos.y, pos.x, pos.y);
       if( d == 0){
         break;
       }
       if (d < 2*hSize) {
         commons.get(i).direction.rotate(PI+(random(1)));
         commons.get(i).pos.add(commons.get(i).direction.normalize());
       }
     } 
   } 
 
 void show(){
   super.show(c);

   //noStroke();
   //for(int i = 5; i>0; i--){
   //  fill(c, 10*i);    
   //  ellipse(pos.x, pos.y, hsize+i, hsize+i);
   //}
 }
}