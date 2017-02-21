class Hero extends Actor{
   
  color c = color(255,0,0);
  float killCount; 
  float fireRange = 80; // Number of pixels
  float shootTime = 233; // Number of milliseconds between shots.
  float moveSpeed = 0.6; 
  float myNow = now;
  float lastShot;
  //float sinceLastShot;
   
  void update(){
    super.update();
    
    direction.setMag(moveSpeed);

    for (Actor z : zombies) {
      float d = dist(z.pos.x, z.pos.y, pos.x, pos.y);
      if (d < 6*hSize) {
        PVector CZ = new PVector();
        CZ.set(pos); 
        CZ.sub(z.pos); 
        CZ.rotate(random(-PI/6, PI/6)); 
        CZ.normalize();
        direction.set(CZ);
      }
    }
    pos.add(direction);

    if(deltaTime(lastShot) > shootTime){
      shoot();  
    }
  }
    
  void kill(Zombie Z){
      stroke(167, 240, 44);
      strokeWeight(4);
      line(Z.pos.x, Z.pos.y, pos.x, pos.y);
      Z.die();
      zombies.remove(Z);
      killCount++;
  }
  
  void shoot() {
        for (int i = zombies.size() - 1; i >= 0; i--) {
          d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y);           
          if (d < fireRange) {
             kill(zombies.get(i));
             lastShot = millis();
             break;
          }
        }
      }
  
  void show() {
    noStroke();
    for(int i = 0; i < killCount; i++){
      fill(c, 255/killCount);    
      ellipse(pos.x, pos.y, hSize+killCount, hSize+killCount);
    }
    super.show(c);
  }
}