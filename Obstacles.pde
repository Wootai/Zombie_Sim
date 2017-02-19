class Obstacle{
  
    float maxX;
    float maxY;
    float minX;
    float minY;
    float x, y;
    
    
  
   Obstacle(float x_, float y_, float len, float hi){
     maxX = len;
     maxY = hi;
     x = x_;
     y = y_;
   }
   
   void show(){
     rect(x, y, maxX, maxX); 
   }
   
   void update(){
     
   }
   
}