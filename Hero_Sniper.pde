class Sniper extends Hero{
  
  float minRange;
  
  Sniper(){
    super();
     fireRange = 220;
     minRange = 90;
     c = color(125,0,200);
     lastShot = 750;
     
  }
  
  void shoot() {
      for (int i = zombies.size() - 1; i >= 0; i--) {
        d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
        if (d < fireRange && d > minRange) {
            super.kill(zombies.get(i));
            lastShot = millis();
            break;
        }
      }
    }
  }