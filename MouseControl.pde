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