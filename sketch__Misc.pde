
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

//Resets sim when zombies or Heroes are all dead
void score(){
  if (commons.size() == 0)  {zwincount++; setup();}
  if (zombies.size() == 0) {hwincount++; setup();}
  
}