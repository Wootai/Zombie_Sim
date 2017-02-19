class Boomer extends Zombie{
  boolean exploding;
  int count = 0;
  
  Boomer(){
    super();
    hSize = 15;
    c = color(0, 175, 50);
    exploding = false;
  }
  
  void special(){
    exploding = true;
    for (int i = commons.size() - 1; i >= 0; i--){
      d = dist(pos.x, pos.y, commons.get(i).pos.x, commons.get(i).pos.y);
      if(d < 10*hSize ){
        super.zombifie(commons.get(i));
      }
    }
    
    for (int i = heroes.size() - 1; i >= 0; i--){
      d = dist(pos.x, pos.y, heroes.get(i).pos.x, heroes.get(i).pos.y);
      if(d<2*hSize){
        super.zombifie(heroes.get(i));
      }
    }
  }
  
  void show(){
    if(exploding){
      noStroke();
      fill(c);    
      ellipse(pos.x, pos.y, hSize+count, hSize+count);
      hSize += count;
      if(count == 2000){
        exploding = !exploding;
      }
    }
    
    else{super.show();}
    
    }
}