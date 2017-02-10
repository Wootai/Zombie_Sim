float hsize = 10; //<>//
float cstart = 100;
float hstart = 5;
float zstart = 3;

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

  display();
  for (Common c : commons) {
    c.move();
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