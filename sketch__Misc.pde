
//DeltaTime Function
float deltaTime(float lastTime){
   return millis() - lastTime;
}

//Draws HUD display messages
void hud(){
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