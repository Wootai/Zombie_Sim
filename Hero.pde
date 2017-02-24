class Hero extends Common{
   
  color c = color(255,0,0);
  float killCount;
  float fireRange; // distance it can kill zombies at.
  float shootTime; // Number of milliseconds between shots.
  float moveSpeed; 
  float lastShot;
  
   
  Hero(){
    super();
    killCount = 0;
    shootTime = 500; // Number of milliseconds between shots.
    moveSpeed = 0.6; 
    c = color(255,0,0);
    lastShot = millis();
    runDist = 6*hSize;
    fireRange = 80;
    moveSpeed = 0.6;
    fireRange = 80;

  }
   
  void update(){
    super.update();
    vel.setMag(moveSpeed);
 
    if(deltaTime(lastShot) > shootTime){
      shoot();  
    }
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
  
  void kill(Zombie Z){
      stroke(167, 240, 44);
      strokeWeight(4);
      line(Z.pos.x, Z.pos.y, pos.x, pos.y);
      Z.die();
      zombies.remove(Z);
      killCount++;
  }
  
}