class Node
{
  String nome;
  PVector place, o;
  
  float nInput;
  float [] input = new float [50];
  
  color [] palheta;
 
  float [] power = new float [4];
  float pw, strength;
  
  float meIn;
  float meOut;
  
  float allIn;
  float allOut;

  Node(String n, int v, int w, float nIn) 
  {
    nome = n;
    
    nInput = nIn;
    
    if(v == 1)
    {
    place = locPV[w];
    o = locOR[w];
    for (int i = 0; i < nIn; i++)
    {
     input[i] = dataL[w][i];
    } 
    } 
    else if(v == 2)
    {
    place = regPV[w];
    o = regOR[w];
    for (int i = 0; i < nIn; i++)
    {
     input[i] = dataR[w][i];
    }
    } else if(v == 3)
    {
    place = intPV[w];
    o = intOR[w];
    for (int i = 0; i < nIn; i++)
    {
     input[i] = dataI[w][i];
    }
    }
    
    //interação com mouse
    float near1 = dist(place.x+256, place.y, place.z-100, userM.x, userM.y, userM.z);
    power[0] = map(near1, 50, 10, 1, 3);
    if(near1<50){
       pw = constrain(power[0], 1, 3);
       }
    if(abs(userM.x - (place.x+256)) < 30 && abs(userM.z - (place.z-100)) < 30)
    {
      place.x = place.x + (userM.x - (place.x+256))*easing;
      place.z = place.z + (userM.z - (place.z-100))*easing;
    }   
    
       
    
    if(abs(o.x - (place.x+256)) > 80 && abs(o.z - (place.z-100)) > 80)
    {
      place.x = place.x + ((o.x+256) - (place.x+256))*easing;
      place.z = place.z + ((o.z-100) - (place.z-100))*easing;
    }
    
    for(int i = 0; i < nIn; i++){  
    allIn = allIn + input[i];
    }
    
    strength = map((allIn), 0, (20*nIn), 1, 2.4);
    strength = constrain (strength, 1, 2);
    
    //-------------   cores
    palheta = colN[v];
    if((allIn) == 0)
    {
    palheta = colN[0];  
    strength = 0.5;
    }
    
    meIn = allIn/nIn;
  }

  void show () {
        
    float siz = 10+(10*pw*strength);
    float hei = -20;
    
    pushMatrix();
    translate(place.x, hei, place.z);

    pushMatrix();
    rotateX(PI);
    strokeWeight(1.5);
   
    int d = 0;
    
    for(int i = 0; i<8; i++){
      if(d == nInput){
        d = 0;
      }
      stroke(palheta[0]);
      rotateY(TWO_PI/24);
      line(siz/2, 0, 0, siz/2, input[d], 0);
      
      d++;
      stroke(palheta[1]);
      rotateY(TWO_PI/24);
      line(siz/2, 0, 0, siz/2, input[d], 0);
      
      d++;
      rotateY(TWO_PI/24);
      stroke(palheta[2]);
      line(siz/2, 0, 0, siz/2, input[d], 0);   
      
    }
    popMatrix();
    
    pushMatrix();
    ellipseMode(CENTER);  
    rotateX(HALF_PI);
    fill(0);
    noStroke();
    ellipse(0, -5, siz, siz);
    noFill();
    stroke(palheta[0]);
    strokeWeight(2);
    ellipse(0, 0, siz+1, siz+1);
    popMatrix();
    
    //label <<-----------------------
    if(pw>1.2){
    float opac = map(pw-1, 0, 2, 0, 255);
    pushMatrix();
    float recS = map(nome.length(), 0, 50, 0, 650);
    translate(0, 0, 25);
    rotateY(-rY);
    fill(255, opac-70);
    noStroke();
    rect (siz/2, -20, recS, 20);
    translate(0, 0, 1.5);
    textFont(font,18); 
    textAlign(LEFT);
    fill(0, opac+40);
    text(nome, (siz/2)+2, -18, recS, 20);
    popMatrix();
    }
    
    popMatrix();
  }
}

