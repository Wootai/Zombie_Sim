class Actor implements ActorI {
    float hsize = 10; //<>//
    color c = color(0, 0, 255);

    PVector pos = new PVector(random(0.1*width, 0.9*width), random(0.1*height, 0.9*height));
    PVector direction = PVector.random2D();
 
    
  //------Constructor
   
    Actor(){}
     
  //-----------------  
    
  void move(){ }

  void show(color c){
    stroke(0);
    strokeWeight(1);
    //noStroke();
    fill(c);    
    ellipse(pos.x, pos.y, hsize, hsize);
  }
  
  
  void border(){
    if (pos.x + hsize > width || pos.x - hsize < 0 || pos.y + hsize > height || pos.y - hsize < 0){
      direction.rotate(PI);
      pos.add(direction);
      pos.add(direction);
    }
  }

}