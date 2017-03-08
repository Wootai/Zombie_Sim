void mouseReleased(){
   if (mouseButton == LEFT){
     c = new Common();
     c.pos.x = mouseX;
     c.pos.y = mouseY;
     commons.add(0, c);
   }
   
   if(mouseButton == RIGHT){
    z = new Zombie();
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