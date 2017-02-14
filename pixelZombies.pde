float hsize = 10; //<>//
float cstart = 700;
float hstart = 6;
float zstart = 5;
int hwincount = 0;
int zwincount = 0;


Actor c;

ArrayList<Actor> commons;
ArrayList<Actor> heroes;
ArrayList<Actor> zombies;

void setup() {
  size(1200, 800, P2D);

  commons = new ArrayList<Actor>();
  heroes = new ArrayList<Actor>();
  zombies = new ArrayList<Actor>();
  // testing


  for (int i = 0; i < cstart; i++) {
    c = new Actor(false, true, false);
    commons.add(c);
  }

  for (int i = 0; i < hstart; i++) {
    c = new Actor(false, false, true);
    heroes.add(c);
  }
  for (int i = 0; i < zstart; i++) {
    c = new Actor(true, false, false);
    zombies.add(c);
  }
}


void draw() {
  background(51);
  fill(255);
  text("Zombies " + str(zwincount) + "-" + str(hwincount) + " Humans", 10, 24);
  text("Commons: " + str(commons.size()), 10, height - 39);
  text("Heroes: " + str(heroes.size()), 10, height - 26);
  text("Zombies: " + str(zombies.size()), 10, height - 13);
  
  display();

  animate();
  stacking();

  bitten();


  if (heroes.size() == 0) {
    zwincount++;
    setup();
  }
  if (zombies.size() == 0) {
    hwincount++;
    setup();
  }
}

void display() {
  for (Actor c : commons) {
    c.show();
  }
  for (Actor h : heroes) {
    h.show();
  }
  for (Actor z : zombies) {
    z.show();
  }
}

void animate() {
  for (Actor c : commons) {
    c.move();
  }
  for (Actor z : zombies) {
    z.move();
  }
  for (Actor h : heroes) {
    h.move();
  }
}

void bitten() {
  for (int i = commons.size() - 1; i >= 0; i--) {
    for (int j = zombies.size() - 1; j >= 0; j--) {
      float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d < hsize) {
        commons.get(i).isZombie = true;
        commons.get(i).isCommon = false;
        zombies.add(commons.get(i));
        commons.remove(i);
        break;
      }
    }
  }

  for (int i = heroes.size() - 1; i >= 0; i--) {
    for (int j = zombies.size() - 1; j >= 0; j--) {
      float d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d < hsize) {
        heroes.get(i).isZombie = true;
        heroes.get(i).isHero = false;
        zombies.add(heroes.get(i));
        heroes.remove(i);
        break;
      }
    }
  }
}

void stacking() {
  for (int i = 0; i < zombies.size() - 1; i++) {
    for (int j = i + 1; j < zombies.size(); j++) {
      float d = dist(zombies.get(i).pos.x, zombies.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
      if (d < 0.5*hsize) {
        
        zombies.get(i).direction.rotate(random(PI*3/4, PI*5/4));
        zombies.get(i).pos.add(zombies.get(i).direction);
      }
    }
  }
}
