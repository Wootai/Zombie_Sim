 //<>//
float cstart = 700;
float hstart = 1;
float zstart = 1;

int hwincount = 0;
int zwincount = 0;

Common c;
Hero h;
Zombie z;

ArrayList<Common> commons;
ArrayList<Hero> heroes;
ArrayList<Zombie> zombies;
ArrayList<Zombie> newZombies;


void setup() {
  size(1200, 800, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>();
  newZombies = new ArrayList<Zombie>();
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
    z = new Zombie();
    zombies.add(z);
  }
}


void draw() {
  background(51);
  fill(255);
  text("Zombies " + str(zwincount) + "-" + str(hwincount) + " Humans", 10, 24);
  text("Commons: " + str(commons.size()), 10, height - 39);
  text("Heroes: " + str(heroes.size()), 10, height - 26);
  text("Zombies: " + str(zombies.size()), 10, height - 13);
  

  update();
  display();
 // bitten();

  if (heroes.size() == 0) {
    zwincount++;
    setup();
  }
  if (zombies.size() == 0) {
    hwincount++;
    setup();
  }
}

void update() {
  for (Actor c : commons) {
    c.move();
  }
  for (int i = zombies.size()-1; i >= 0; i--) {
    zombies.get(i).move();
    zombies.get(i).stacking();
    zombies.get(i).bite();
  }
  
  for (Hero h : heroes) {
    h.move();
    h.shoot();
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



void mouseReleased(){
   if (mouseButton == LEFT){
     h = new Hero();
     h.pos.x = mouseX;
     h.pos.y = mouseY;
     heroes.add(h);
   }
   if(mouseButton == RIGHT){
    z = new Zombie();
    z.pos.x = mouseX;
    z.pos.y = mouseY;
    zombies.add(z);
   }
}

//void bitten() {
//  for (int i = commons.size() - 1; i >= 0; i--) {
//    for (int j = zombies.size() - 1; j >= 0; j--) {
//      float d = dist(commons.get(i).pos.x, commons.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
//      if (d < commons.get(i).hsize) {
//        Zombie z = new Zombie();
//        z.pos.x = commons.get(i).pos.x;
//        z.pos.y = commons.get(i).pos.y;
//        zombies.add(0, z);
//        commons.remove(i);
//        break;
//      }
//    }
//  }

//  for (int i = heroes.size() - 1; i >= 0; i--) {
//    for (int j = zombies.size() - 1; j >= 0; j--) {
//      float d = dist(heroes.get(i).pos.x, heroes.get(i).pos.y, zombies.get(j).pos.x, zombies.get(j).pos.y);
//      if (d < heroes.get(i).hsize) {
//        Zombie z = new Zombie();
//        z.pos.x = heroes.get(i).pos.x;
//        z.pos.y = heroes.get(i).pos.y;
//        zombies.add(0, z);
//        commons.remove(i);
//        break;
//      }
//    }
//  }
//}