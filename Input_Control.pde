void mouseReleased(){
   if (mouseButton == LEFT){
     h = new Hero();
     h.pos.x = mouseX;
     h.pos.y = mouseY;
     heroes.add(0, h);
   }
   
   if(mouseButton == RIGHT){
    z = new Boomer();
    z.pos.x = mouseX;
    z.pos.y = mouseY;
    zombies.add(z);
   }
   
   if(mouseButton == CENTER){
    c = new Common();
    c.pos.x = mouseX;
    c.pos.y = mouseY;
    commons.add(c);
   }
}

void keyPressed(){
 if(key == 'p'){
   paused = !paused;
 }
}