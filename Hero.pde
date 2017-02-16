class Hero extends Actor{
   
  color c = color(255,0,0);
  float killCount; 
  float firerange = 80; // Number of pixels
  float firespeed = 8; // Number of frames between shots
  float movespeed = 0.6; 
  float d;
   
  void update(){
    super.update();
    
    direction.setMag(movespeed);
    
    
    if (r1 < 0.01) {
      direction.rotate(random(-PI/6, PI/6));
    }

    for (Actor z : zombies) {
      float d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
      if (d < 6*hsize) {
        PVector CZ = new PVector();
        CZ.set(pos); 
        CZ.sub(z.pos); 
        CZ.rotate(random(-PI/6, PI/6)); 
        CZ.normalize();
        direction.set(CZ);
      }
    }
    pos.add(direction);
    println(frameCount);
    shoot();  
  }
  
  void shoot() {
      for (int i = zombies.size() - 1; i >= 0; i--) {
        d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
        
        if (d < firerange && frameCount % firespeed == 0) {
           //println(this + " shot " + zombies.get(i));
           stroke(167, 240, 44);
           strokeWeight(4);
           line(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);
           zombies.remove(i);
           break;
        }
      }
    }
  
  void show() {
    //noStroke();
    //for(int i = 10; i>0; i--){
    //  fill(c, 10*i);    
    //  ellipse(pos.x, pos.y, hsize+i, hsize+i);
    //}
    super.show(c);
  }
  
}