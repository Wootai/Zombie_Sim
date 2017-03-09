class Obstacle{

    float x, y, len, wid;
    float maxX;
    float maxY;
    PVector pos; 
    
    PVector topLeft, topRight, bottomLeft, bottomRight;
  
   Obstacle(float x_, float y_, float len_, float wid_){
     len = len_;
     wid = wid_;
     x = x_;
     y = y_;
     maxX = x+len;
     maxY = y+wid;
     topLeft = new PVector(x, y);
     topRight = new PVector(maxX, y);
     bottomLeft = new PVector(x, maxY);
     bottomRight = new PVector(maxX, maxY);
     pos = new PVector(x, y);
 }
   
   void show(){
     noFill();
     stroke(0);
     strokeWeight(4);
     rect(x, y, len, wid);
     strokeWeight(1);
     stroke(0,255,0);
     vectorBox(topLeft, topRight, bottomRight, bottomLeft);
   }
   
   void update(){
     
   }
   
}