class Planta {
  int numData; //numero de dados da planta
  float centroX, centroY;
  int tam;
  Espiral [] petalas;
  float [] ang;
  float [] dataValue;
  color cor;  

  Planta(float x, float y, int num, color c, int r) {
    centroX = lerp(0, width, x);
    centroY = lerp(0, height, y);
    numData = num;
    tam = r;
    cor = c;
    
    petalas = new Espiral [numData];
    ang = new float [numData];
    dataValue = new float [numData];

    color cc;
    for (int i = 0; i < numData; i++) {
      if (i%2==0) cc=cor;
      else cc = color(255);

      dataValue[i] = random(1.0);
      ang [i] = int(random(numData))*60; 
      petalas [i] = new Espiral (centroX, centroY, r, 1+(i*.4), ang[i], cc,i, numData);
    }
  }

  void display() {
    for (int i = 0; i < numData; i++) {
      if(osc == false){
      dataValue[i] += random(.1);
      if(dataValue[i]>1){
        dataValue[i] = random(1.0);
      }
      }
      petalas[i].display();
      petalas[i].update(int(wx), int(wy));
    }
  }
}

class Espiral {

  float cx, cy; // centro da espiral
  float tx, ty;
  int trac; //numero de pontinhos tracejados
  float tracSz = 2; // tamanho da bolinha tracejada
  float angle_incr; // angulo para rotacionar a espiral para o próximo ponto
  float outer_r; // raio máximo da espiral
  float rotAng; // angulo de rotação
  color corSpi;
  float anda = .3;
  int a = 0;
  float pAng;
  
  int index;
  int numT;
  
  float dataValue = .3; // valor dos dados
  float locData = random(40,trac); // localização na espiral
  boolean go; // vai ou volta na espiral

  Espiral(float x, float y, int num, float r, float ang, color spiC, int i, int numData) {
    cx=x;
    cy=y;
    tx=cx;
    ty=cy;
    trac=num;
    outer_r = r;
    angle_incr=radians(1);
    rotAng = ang;
    corSpi = spiC;
    index = i;
    numT = numData;
  }

  void display() {  
    pushMatrix();
    translate(tx, ty);
    rotate(radians(rotAng));
    for (int i = 1; i <= trac; ++i) {
      float ratio = i/(float)trac;
      float spiral_rad = ratio * outer_r;
      float angle = i*angle_incr;
      float x =  (i+5) * cos(2*sqrt(1.5*i+1))* spiral_rad;
      float y =  (i+5) * sin(2*sqrt(1.5*i+1)) * spiral_rad;    

      // draw tiny circle at x,y
      noStroke();
      strokeWeight(0);
      fill(corSpi);
      ellipse(x, y, 2, 2);
    }   
    data();
    popMatrix();
  }

  void data() {

    float ratio = locData/(float)trac;
    float spiral_rad = ratio * outer_r;
    float angle = locData*angle_incr;

    float x =  (locData+5) * cos(2*sqrt(1.5*locData+1)) * spiral_rad;
    float y =  (locData+5) * sin(2*sqrt(1.5*locData+1)) * spiral_rad; 
    
    stroke(corSpi);
    strokeWeight(3);
    fill(255,60);
    ellipse(x, y, dataValue*20, dataValue*20);
  }

  void updateData(float dado){
    dataValue = dado;
  }

  void update(int mapx, int mapy) {
    int ttx = mapx; int tty = mapy;
    ty = cy + tty;
    tx = cx + ttx;
    float deltaRot;
    float ease =.01;
    
        if(prox(px, py)){
      float pAng = atan2(cx-mouseX, cy-mouseY); 
      deltaRot = ((rotAng-pAng)%360)*ease*2; 
    }else{
      //  float vel = map(dado, 0.0, 1.0, 0.0, .5);
        float appart = (360/numT)*(index+1);
        deltaRot= appart*ease*0.3;
      }

    rotAng+= deltaRot;
   // println(prox(mx, my) + "  angulo " + deltaRot);  
    locData = locData+anda; 
    //dataValue = dado;
    if (locData > trac || locData < 30)
      a++;

    if(a%2==0){
      go = true;}
    else{
      go = false;}


    if (go) {
      anda = .3; 
      // rotAng+=.5;
    } 
    else if (go == false) {
      anda = -.3;
      //   rotAng-=.5;
    }
  }
  
  boolean prox (float [] x, float [] y){
    float xp=4000; 
    float yp=4000;
    float ccx = map(cx, 0, width, .0, 1.0);
    float ccy = map(cy, 0, height, .0, 1.0);
    
    float proximo=3;
    if(x != null){
    for(int i=0; i< x.length; i++){
      float proxi = dist(ccx, ccy, x[i],y[i]);
      if(proxi < .2){
        proximo = proxi;
        xp = x[i];
        yp = y[i];
      }
    }
    }
       if(proximo<.2){ 
         pAng = atan2(cx-xp, cy-yp);
         xp= map(xp, .0, 1.0, 0, width ); 
         yp= map(yp, .0, 1.0, 0, height);
        return true;
      }    else return false;
  }
    
}

