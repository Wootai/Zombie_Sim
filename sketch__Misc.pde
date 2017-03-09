
//DeltaTime Function
float deltaTime(float lastTime){
   return millis() - lastTime;
}

//Draws HUD display messages
void hud(){
  fill(255);        // Change Fill to white
  text("Zombies " + str(zwincount) + "-" + str(hwincount) + " Humans", 10, 24);
  text("Commons: " + str(commons.size()), 10, height - 39);
  text("Heroes: " + str(heroes.size()), 10, height - 26);
  text("Zombies: " + str(zombies.size()), 10, height - 13);
}

//Resets sim when zombies or humans are all dead
void score(){
  if (commons.size() == 0)  {zwincount++; setup();}
  if (zombies.size() == 0) {hwincount++; setup();} 
}

void vectorLine(PVector V1, PVector V2){
  line(V1.x, V1.y, V2.x, V2.y);
}

void vectorBox(PVector V1, PVector V2, PVector V3, PVector V4){
     vectorLine(V1,V2);
     vectorLine(V2, V3);
     vectorLine(V3, V4);
     vectorLine(V4, V1);
}

float dist2(PVector v1, PVector v2) {
  return ((v1.x - v2.x)*(v1.x - v2.x) + (v1.y - v2.y)*(v1.y - v2.y) + (v1.z - v2.z)*(v1.z - v2.z));
}

float mag2(PVector v) {
  return (v.x*v.x + v.y*v.y + v.z*v.z);
}

void fillArrays(){
  
  for(int i = 0; i < obStart; i++){
    o = new Obstacle(random(150, width-150), random(125, height-125), random(50, 150), random(25, 125));
    obstacles.add(o);
   }
   
   for (int i = 0; i < zstart; i++) {
    if(i % 10 == 0){
      z = new Zombie();
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
    } 
    else{ 
    h = new Hero();
  }
    heroes.add(h); 
  } 
}