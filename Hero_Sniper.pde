class Sniper extends Hero{
  float minRange;
  
  Sniper(){
    super();
     fireRange = 220;
     minRange = 90;
     c = color(125,0,200);
     fireSpeed = 240;
     
  }
  
  void shoot() {
    m = millis();
    if(m % fireSpeed < 10){
      for (int i = zombies.size() - 1; i >= 0; i--) {
        d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
        
        if (d < fireRange && d > minRange) {
            super.kill(zombies.get(i)); 
            break;
        }
      }
    }
  }
}