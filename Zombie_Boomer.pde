class Boomer extends Zombie{
  boolean exploding;
  int count = 1;
  
  Boomer(){
    super();
    hSize = 15;
    c = color(0, 175, 50);
    exploding = false;
    maxForce = .1;
  }
  
  void die(){
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
    for(int i = 0; i < 10; i++){
      show();
    }
  }
  
  void show(){
    if(exploding){
      noStroke();
      fill(c, 150);    
      ellipse(pos.x, pos.y, hSize*10, hSize*10);
      fill(c, 100);
      ellipse(pos.x, pos.y, hSize*10, hSize*10);
      
    }
    
    else{super.show();}
    
    }
}