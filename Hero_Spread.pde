class Shotgun extends Hero{
  
  float minRange;
  ArrayList<Zombie> targets;
  
  Shotgun(){
    super();
    targets = new ArrayList<Zombie>();
     fireRange = 180;
     c = color(1,150,200);
     lastShot = 900;
     
  }
  
  void shoot() {
      for (int i = zombies.size() - 1; i >= 0; i--) {
        d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, pos.x, pos.y); 
        if (d < fireRange) {
            targets.add(zombies.get(i));
            super.kill(zombies.get(i));
            lastShot = millis();
            //break;
        }
      }
      if(targets.size()>0){
        for(int j = targets.size()-1; j<= 0; j--){
        super.kill(targets.get(j));
        }
      }
    }
  }