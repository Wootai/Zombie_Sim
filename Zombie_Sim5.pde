 //<>//
float cstart = 400; //<>//
float hstart = 6; //<>//
float zstart = 11; //<>//

int hwincount = 0;
int zwincount = 0;

Common c;
Hero h;
Zombie z;

ArrayList<Common> commons;
ArrayList<Hero> heroes;
ArrayList<Zombie> zombies;

void setup() {
  size(1200, 800, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>();
  // testing

  for (int i = 0; i < cstart; i++) {
    c = new Common();
    commons.add(c);
  }

  for (int i = 1; i < hstart+1; i++) {
    if(i % 3 == 0){
      h = new Sniper();
    } //<>//
    else{h = new Hero();} //<>//
    heroes.add(h); //<>//
  } //<>//
   //<>//
  for (int i = 0; i < zstart; i++) { //<>//
    if(i % 10 == 0){ //<>//
      z = new Boomer();
    }
    else{
      z = new Zombie();
    }
    zombies.add(z);

  }

}

void draw() {
  background(51);

  update();
  display();
  
  fill(255);
  hud();

  
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
    c.update();
  }

  for (int i = heroes.size()-1; i>=0; i--) {
    heroes.get(i).update();
  }
  
  for (int i = zombies.size()-1; i >= 0; i--) { //Go through the zombie array backwards.
    zombies.get(i).update();
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

void hud(){
  text("Zombies " + str(zwincount) + "-" + str(hwincount) + " Humans", 10, 24);
  text("Commons: " + str(commons.size()), 10, height - 39);
  text("Heroes: " + str(heroes.size()), 10, height - 26);
  text("Zombies: " + str(zombies.size()), 10, height - 13);

}
