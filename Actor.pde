class Actor implements ActorI {
    float hsize = 10; //<>//
    color c = color(0, 0, 255);
    float r1;

    PVector pos = new PVector(random(0.05*width, 0.95*width), random(0.05*height, 0.95*height));
    PVector direction = PVector.random2D();
 
    
  //------Constructor
   
    Actor(){}
     
  //-----------------  
    
  void update(){
   if (pos.x + hsize > width || pos.x - hsize < 0 || pos.y + hsize > height || pos.y - hsize < 0){
      direction.rotate(PI);
      pos.add(direction);
      pos.add(direction);
    }
    r1 = random(1);
  }

  void show(color c){
    stroke(0);
    strokeWeight(1);
    //noStroke();
    fill(c);    
    ellipse(pos.x, pos.y, hsize, hsize);
  }
  
}