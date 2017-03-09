float cstart = 1;   //<>//
float hstart = 10;  //<>//
float zstart = 15;   //<>//

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

boolean paused = false;


void setup() {
  frameRate(60);
  size(1200, 800, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>(); 
  obstacles = new ArrayList<Obstacle>();  //<>// //<>// //<>// //<>//
  fillArrays();  //<>//

} 

void draw() {
   
    background(51);
    score();
    if(!paused)
     {
       update();
     }
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