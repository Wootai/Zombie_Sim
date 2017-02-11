float hsize = 10; //<>//
float cstart = 100;
float hstart = 5;
float zstart = 5;

Common c;
Hero h;
Zombie z;

ArrayList<Common> commons;
ArrayList<Hero> heroes;
ArrayList<Zombie> zombies;

void setup() {
  size(800, 600, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>();
  // testing


  for (int i = 0; i < cstart; i++) {
    c = new Common();
    commons.add(c);
  }

  for (int i = 0; i < hstart; i++) {
    h = new Hero();
    heroes.add(h);
  }
  for (int i = 0; i < zstart; i++) {
    z = new Zombie(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
    zombies.add(z);
  }
}


void draw() {
  background(51);

  display();
  animate();
  nostack();
  bitten();
  
  if (commons.size() == 0 && heroes.size() == 0) {
     println("Zombies win");
     setup(); 
  }
}






void display() {
  for (Common c : commons) {
    c.show();
  }
  for (Hero h : heroes) {
    h.show();
  }
  for (Zombie z : zombies) {
    z.show();
  }
}
void animate() {
  for (Common c : commons) {
    c.move();
  }
  for (Zombie z : zombies) {
    z.move();
  }
  for (Hero h : heroes) {
    h.move();
  }
}


void bitten() {
  for (int i = commons.size() - 1; i >= 0; i--) {
    for (int j = zombies.size() - 1; j >= 0; j--) {
      float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d < 1.5 * hsize) {
        z = new Zombie(commons.get(i).pos.x, commons.get(i).pos.y);
        zombies.add(z);


        commons.get(i).visible = false;
        commons.remove(i);
        break;
      }
    }
  }

  for (int i = heroes.size() - 1; i >= 0; i--) {
    for (int j = zombies.size() - 1; j >= 0; j--) {
      float d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d < 1.5 * hsize) {
        z = new Zombie(heroes.get(i).pos.x, heroes.get(i).pos.y);
        zombies.add(z);


        heroes.get(i).visible = false;
        heroes.remove(i);
        break;
      }
    }
  }
}
void nostack() {
  for (Zombie z : zombies) {
    for (Zombie other : zombies) {
      if (z != other && z != null) {
        float d = dist(z.pos.x, z.pos.y, other.pos.x, other.pos.y); 
        if (d < 0.4*hsize) {
          other.pos.sub(other.direction);
        }
      }
    }
  }
}


boolean edges(float x, float y) {
  return (x + hsize > width || x - hsize < 0 || y + hsize > height || y - hsize < 0);
}