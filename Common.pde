class Common extends Actor{
  
  color c = color(255,255,0);  
  
  void move(){
    
    border();
  
    float r1 = random(1);
    
    if (r1 < 0.05) {
            direction.rotate(random(-PI/6, PI/6));
          }
    
    for (Zombie z : zombies) {
      float d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
          if (d < 10*hsize) {
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
 
 void show(){
    noStroke();
    for(int i = 5; i>0; i--){
      fill(c, 10*i);    
      ellipse(pos.x, pos.y, hsize+i, hsize+i);
    }
   super.show(c);
 }
}