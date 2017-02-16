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
  

  animate();
  display();

  if (heroes.size() == 0) {
    zwincount++;
    setup();
  }
  if (zombies.size() == 0) {
    hwincount++;
    setup();
  }
}

void animate() {
  for (Actor c : commons) {
    c.move();
  }
  for (Zombie z : zombies) {
    z.move();
    z.stacking();
  //  z.bite();
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