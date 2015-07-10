class Path
{
  Node nodeA;
  Node nodeB;

  Path(Node p1, Node p2) 
  {
    nodeA = p1;
    nodeB = p2;
  }

  void dataBridge () 
  {
    
    float flux = map((nodeB.allIn/nodeB.nInput), 0, 20, 0, 3);
    flux = constrain(flux, 0, 3);
    float siz = 10*nodeB.pw*nodeB.strength;
    float hei = -20;
   
    pushMatrix();
    translate(nodeA.place.x, hei, nodeA.place.z);
    rotateX(PI);
    strokeWeight(1.5);
    
    int d = 0;
    
    for(int i = 0; i<8; i++){
      if(d == nodeB.nInput){
        d = 0;
      }
      
      stroke(nodeB.palheta[3]);
      rotateY(TWO_PI/24);
      line(siz/2, 0, 0, siz/2, (0-nodeB.input[d]), 0);
      
      d++;
      
      stroke(nodeB.palheta[4]);
      rotateY(TWO_PI/24);
      line(siz/2, 0, 0, siz/2, (0-nodeB.input[d]), 0);
      
      d++;
      
      rotateY(TWO_PI/24);
      stroke(nodeB.palheta[5]);
      line(siz/2, 0, 0, siz/2, (0-nodeB.input[d])/4, 0);
      
    }
    popMatrix();
//    
    pushMatrix();
      translate(0, -20, 0);
      noFill();        
      strokeWeight(flux);
      stroke(nodeB.palheta[1],170);
      bezier(nodeA.place.x, nodeA.place.y, nodeA.place.z, nodeA.place.x, nodeA.place.y, nodeB.place.z, nodeB.place.x, nodeB.place.y, nodeA.place.z,  nodeB.place.x, nodeB.place.y, nodeB.place.z);  
   popMatrix();
    
  }
} 
