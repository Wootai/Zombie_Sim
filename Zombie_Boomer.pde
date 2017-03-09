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
    BoomerExplosion bExplode = new BoomerExplosion(pos);
    zombies.add(bExplode);
  }
  
  void show(){
    super.show();
  }
}


class BoomerExplosion extends Zombie{
  boolean growing = true;

  BoomerExplosion(PVector s){
    super();
    pos = s;
  }

  void update(){
    if(growing){
      hSize += hSize*.5;
      for (int i = commons.size() - 1; i >= 0; i--){
        d = dist(pos.x, pos.y, commons.get(i).pos.x, commons.get(i).pos.y);
        if(d < hSize ){
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
    if(hSize == hSize*10){
      growing = false;
      zombies.remove(this);
    }
    show();
  }

  void show(){
    stroke(0);
    strokeWeight(1);
    fill(c);
    ellipse(pos.x, pos.y, hSize, hSize);
  }
}