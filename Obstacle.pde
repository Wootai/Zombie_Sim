class Obstacle{

    float x, y, len, wid;
  
    float maxX;
    float maxY;
    
    
  
   Obstacle(float x_, float y_, float len_, float wid_){
     len = len_;
     wid = wid_;
     x = x_;
     y = y_;
     maxX = x+len;
     maxY = y+wid;
   }
   
   void show(){
     noFill();
     stroke(0);
     strokeWeight(4);
     rect(x, y, len, wid); 
   }
   
   void update(){
     
   }
   
}