float cstart = 40;   // Start Common Human 
float hstart = 0;  // Start Hero Human 
float zstart = 15;  // Start Zombies 
float obStart = 4;  // Start Obsticles

int hwincount = 0;  // Human Win counter
int zwincount = 0;  // Zombie Win counter

PVector pos;

Common c;           // Global Common             
Hero h;             // Global Hero
Zombie z;           // Global Zombie

Obstacle o;         // Global Obstacle

ArrayList<Common> commons;      // Commons Array
ArrayList<Hero> heroes;         // Heroes Array
ArrayList<Zombie> zombies;      // Zombies Array
ArrayList<Obstacle> obstacles;  // Obstacles Array

boolean paused = false;         // Paused State Global Variable

void setup() {
  frameRate(60);                // Set framerate to 60fps
  size(1200, 800, P2D);

  commons = new ArrayList<Common>();
  heroes = new ArrayList<Hero>();
  zombies = new ArrayList<Zombie>(); 
  obstacles = new ArrayList<Obstacle>();  
  fillArrays(); 
}  

void draw() {
   
    background(51);   // draw background
    score();          // Check Score
    if(!paused)       // check for Paused
     {
       update();      // Update if not paused
     }
    display();        // Display
    hud();            // draw Hud
    
}

void update() {
  for (Common c : commons) {
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