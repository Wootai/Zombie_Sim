float cstart = 1;   //<>//
float hstart = 1;   //<>//
float zstart = 1;   //<>//


float obStart = 4;

int hwincount = 0;
int zwincount = 0;

Common c;
Hero h;
Zombie z;
Obstacle o;
float now = millis();
float lastTime;

ArrayList<Common> commons;
ArrayList<Hero> heroes;
ArrayList<Zombie> zombies;
ArrayList<Obstacle> obstacles;

void setup() {
  frameRate(60);
  size(1200, 800, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>();
  obstacles = new ArrayList<Obstacle>();

   for(int i = 0; i < obStart; i++){
    o = new Obstacle(random(150, width-150), random(125, height-125), random(50, 150), random(25, 125));
    obstacles.add(o);
   }

   for (int i = 0; i < zstart; i++) {
    if(i % 10 == 0){
      z = new Boomer();
    }
    else{
      z = new Zombie();
    }
    zombies.add(z);

  }

  for (int i = 0; i < cstart; i++) {
    c = new Common();
    commons.add(c);
  }

  for (int i = 1; i < hstart+1; i++) {
    if(i % 3 == 0){
    h = new Sniper();
    }   //<>//
    else{   //<>//
    h = new Hero();
  }
    heroes.add(h);   //<>//
  }   //<>//
}
  //<>//

void draw() {
  //println(frameRate/1000);
  background(51);

  now = millis();

  score();
  update();
  display();
  fill(255);
  hud();

  while(deltaTime(lastTime) < 60){
    deltaTime(lastTime);
  }
 lastTime = now;

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
  for (Obstacle o : obstacles){
    o.show();
  }

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
