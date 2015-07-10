import oscP5.*;
import netP5.*;
OscP5 myOsc;

boolean kinect = false;
int userRadius = 30;

// setup conexion
int myPort = 22244;
String otherIP = "localhost";
NetAddress myRemoteLocation;
boolean osc = false; // <<<<<---------------------- mude aqui para simulação / recepção de dados

//setup layout
int x=0;
int y=160;
int z=0;
float rX=-0.65;
float rY=0.0000;
int vision;

//setup interaction
PVector userM;

int loc = 21;
int reg = 6;
int inter = 7;
int allNodes = loc + reg + inter;
int allPaths = (loc*reg)+(loc*inter) + (loc*loc)+ (reg*inter);
int buffSize = 8;
float easing = 0.05;
float noiseScale = 0.1;

color [][] colN = {
  {
    color(187), color(137), color(108), color(147), color(124), color(91)  // pb[0]
  }
  , 
  {
    color(244, 109, 90), color(255, 0, 0), color(197, 7, 0), color(109, 209, 65), color(97, 228, 0), color(64, 162, 0) // Local [1]
  }
  , 
  {
    color(63, 169, 255), color(0, 108, 255), color(39, 29, 255), color(255, 61, 255), color(253, 0, 215), color(223, 23, 100) //Regional [2]
  }
  , 
  {
    color(224, 198, 59), color(255, 246, 0), color(242, 171, 0), color(154, 59, 224), color(197, 43, 255), color(142, 10, 255) //Internacional [3]
  }
}; 



PVector [] locPV =  new PVector[loc];//{ PVector(120, 0, 175),  PVector(140, 0, 135),  PVector(180, 0, 80),  PVector(250, 0, 90),  PVector(330, 0, 100),  PVector(400, 0, 100),  PVector(390, 0, 155),  PVector(220, 0, 150),  PVector(180, 0, 190),  PVector(310, 0, 160),  PVector(270, 0, 190),  PVector(100, 0, 60),  PVector(150, 0, 20),  PVector(250, 0, 0),  PVector(300, 0, 20),  PVector(350, 0, 60)};
PVector [] regPV =  new PVector[reg];
PVector [] intPV =  new PVector[inter];

PVector [] locOR =  new PVector[loc];
PVector [] regOR =  new PVector[reg];
PVector [] intOR =  new PVector[inter];

float [][] dataL = new float [loc][50];
float [][] dataR= new float [reg][50];
float [][] dataI = new float [inter][50];

Node [] placeLoc = new Node [loc];
Node [] placeReg = new Node [reg];
Node [] placeInt = new Node [inter];
Path [] bridges = new Path [allPaths];


PFont font;


void setup() {
  
  size(1024, 720, P3D);
  smooth();
  background(0);

  font = loadFont("Kalinga-57.vlw");  
  myOsc = new OscP5(this, myPort);
  myRemoteLocation = new NetAddress(otherIP, 22243);

  locPV[0] = new PVector(385-256, 0, 40+100);
  locPV[1] = new PVector(120-256, 0, 185+100);
  locPV[2] = new PVector(125-256, 0, 135+100);
  locPV[3] = new PVector(150-256, 0, 80+100);
  locPV[4] = new PVector(250-256, 0, 90+100);
  locPV[5] = new PVector(330-256, 0, 100+100);
  locPV[6] = new PVector(400-256, 0, 100+100);
  locPV[7] = new PVector(390-256, 0, 155+100);
  locPV[8] = new PVector(220-256, 0, 150+100);
  locPV[9] = new PVector(180-256, 0, 190+100);
  locPV[10] = new PVector(330-256, 0, 170+100);
  locPV[11] = new PVector(270-256, 0, 190+100);
  locPV[12] = new PVector(100-256, 0, 60+100);
  locPV[13] = new PVector(150-256, 0, 20+100);
  locPV[14] = new PVector(250-256, 0, 0+100);
  locPV[15] = new PVector(300-256, 0, 20+100);
  locPV[16] = new PVector(200-256, 0, 100+100);
  locPV[17] = new PVector(90-256, 0, 155+100);
  locPV[18] = new PVector(370-256, 0, 200+100);
  locPV[19] = new PVector(170-256, 0, 160+100);
  locPV[20] = new PVector(290-256, 0, 140+100);

  //reg
  regPV[0] = new PVector(140-256, 0, -200+100);
  regPV[1] = new PVector(0-256, 0, -150+100);
  regPV[2] = new PVector(50-256, 0, -250+100);
  regPV[3] = new PVector(160-256, 0, -300+100);
  regPV[4] = new PVector(80-256, 0, -140+100);
  regPV[5] = new PVector(100-256, 0, -70+100);


  //inter
  intPV[0] = new PVector(420-256, 0, -120+100);
  intPV[1] = new PVector(260-256, 0, -300+100);
  intPV[2] = new PVector(340-256, 0, -150+100);
  intPV[3] = new PVector(260-256, 0, -200+100);
  intPV[4] = new PVector(370-256, 0, -250+100);
  intPV[5] = new PVector(260-256, 0, -90+100);
  intPV[6] = new PVector(340-256, 0, -220+100);


  for (int i = 0; i<21; i++) {
    locOR[i] = locPV[i].get();
  }
  for (int i = 0; i<6; i++) {
    regOR[i] = regPV[i].get();
  }
  for (int i = 0; i<6; i++) {
    intOR[i] = intPV[i].get();
  }
  
  //frameRate(20);
}


void draw() {

  //println(frameRate);
  
  background(0);
  rotateX(rX);
  grid(); 
  noiseScale = noiseScale + 0.01;

  //----- aonde esta o usuario
  strokeWeight(10);
  stroke(255, 0, 0);
  userM = use(false, 0);
  strokeWeight(10);
  stroke(255, 0, 0);
  point(userM.x+width/4, y-10, userM.z+400+z);

  //----- qual area esta sendo privilegiada
  visions(vision);
  translate(width/2, y-10, 300+z);
  rotateY(rY);

//--------------->> SIMULACAO DE DADOS <<------------------------ para receber via osc altere la no inicio a boolean osc para true 

if(osc == false){
for (int l = 0; l < loc; l++){
 for(int d = 0; d < 50; d++){
  dataL[l][d] = noise(noiseScale)*20;
 }
}

for (int l = 0; l < reg; l++){
 for(int d = 0; d < 50; d++){
  dataR[l][d] = noise(noiseScale)*20;
 }
}

for (int l = 0; l < inter; l++){
 for(int d = 0; d < 50; d++){
  dataI[l][d] = noise(noiseScale)*20;
 }
}
}

  // ------------------>>> PONTOS  String nome,        int v(loc=1; reg =2; int=3),     int w = array ,      numero de variaveis produzindo)
  placeLoc[0] = new Node("Elen Nas", 1, 0, 1);
  placeLoc[1] = new Node("Kiko Barreto", 1, 1, 1);
  placeLoc[2] = new Node("Tania Fraga", 1, 2, 1);
  placeLoc[3] = new Node("Jarbas Jacomé", 1, 3, 0);
  placeLoc[4] = new Node("Marlus Araujo", 1, 4, 2);
  placeLoc[5] = new Node("Leslie Garcia", 1, 5, 2);
  placeLoc[6] = new Node("Barbara Castro", 1, 6, 6);
  placeLoc[7] = new Node("Walmeri Ribeiro", 1, 7, 0);
  placeLoc[8] = new Node("Ivan Henrique", 1, 8, 0);
  placeLoc[9] = new Node("Raquel Rennó", 1, 9, 0);
  placeLoc[10] = new Node("Bruno Vianna", 1, 10, 3);
  placeLoc[11] = new Node("Paola Barreto", 1, 11, 1);
  placeLoc[12] = new Node("Cinthia Mendonça", 1, 12, 1);
  placeLoc[13] = new Node("Jackson Marinho", 1, 13, 1);
  placeLoc[14] = new Node("Alexandra Cristina", 1, 14, 1);
  placeLoc[15] = new Node("Caio Cruz", 1, 15, 0);
  placeLoc[16] = new Node("Rodrigo Rodrigues", 1, 16, 0);
  placeLoc[17] = new Node("Daniel Belquer", 1, 17, 0);
  placeLoc[18] = new Node("Adriano Belizário", 1, 18, 0);
  placeLoc[19] = new Node("Ricardo Brazileiro", 1, 19, 0);
  placeLoc[20] = new Node("Ricardo Ruiz", 1, 20, 0);


  //reg
  placeReg[0] = new Node("UNICAMP", 2, 0, 1);
  placeReg[1] = new Node("UNOESTE", 2, 1, 0);
  placeReg[2] = new Node("Glerm", 2, 2, 1);
  placeReg[3] = new Node("UnB", 2, 3, 0);
  placeReg[4] = new Node("UFBA - Bruno", 2, 4, 3);
  placeReg[5] = new Node("UFBA - Karla", 2, 5, 0);


  //inter
  placeInt[0] = new Node("Kjell Petersen", 3, 0, 0);
  placeInt[1] = new Node("Luis Girão", 3, 1, 1);
  placeInt[2] = new Node("Briggita Zics", 3, 2, 0);
  placeInt[3] = new Node("Eduardo Coutinho", 3, 3, 7);
  placeInt[4] = new Node("Ken/Bruce", 3, 4, 1);
  placeInt[5] = new Node("Matheu", 3, 5, 0);




  // -------------------->> CONEXÕES ESTABELECIDAS

  int b = 0;
  bridges[b] = new Path(placeLoc[6], placeLoc[4]); //barbara - marlus
  b++;  
  bridges[b] = new Path(placeLoc[6], placeReg[4]); //barbara - bruno 
  b++;
  bridges[b] = new Path(placeLoc[6], placeReg[2]); //barbara - glerm 
  b++;
  bridges[b] = new Path(placeLoc[6], placeLoc[0]); //barbara - Elen 
  b++; 
  bridges[b] = new Path(placeLoc[6], placeInt[3]);// barbara - Eduardo coutinho
  b++;
  bridges[b] = new Path(placeLoc[6], placeReg[0]);// barbara - ijexa
  b++;
  bridges[b] = new Path(placeLoc[6], placeLoc[5]);// barbara - leslie
  b++;
  bridges[b] = new Path(placeLoc[6], placeLoc[1]);// barbara - kiko
  b++;
    bridges[b] = new Path(placeLoc[6], placeLoc[2]); //barbara - tania
    b++;
    bridges[b] = new Path(placeLoc[6], placeInt[1]); //barbara - girao
    b++;
  
  
  bridges[b] = new Path(placeReg[4], placeInt[3]);// bruno UFBA - eduardo
  b++;
  
  bridges[b] = new Path(placeLoc[11], placeLoc[5]);// paola - leslie
  b++;
  bridges[b] = new Path(placeLoc[12], placeLoc[11]);// cinthia - paola
  b++;
  bridges[b] = new Path(placeLoc[12], placeLoc[1]);// cinthia - kiko
  b++;
  bridges[b] = new Path(placeLoc[12], placeLoc[5]);// cinthia - leslie
  b++;
  bridges[b] = new Path(placeLoc[5], placeLoc[11]);// leslie - paola
  b++;
  
  
  bridges[b] = new Path(placeInt[1], placeLoc[6]);// girao - barbara
  b++;
  bridges[b] = new Path(placeLoc[2], placeLoc[6]);// tania - barbara
  b++;
  
  
  bridges[b] = new Path(placeLoc[17], placeLoc[1]);// daniel - kiko
  b++;
  bridges[b] = new Path(placeLoc[17], placeLoc[0]);// daniel - elen
  b++;
    bridges[b] = new Path(placeLoc[17], placeLoc[13]);// daniel - jackson
  b++;
  bridges[b] = new Path(placeLoc[1], placeLoc[0]);// kiko - elen
  b++;
  
  bridges[b] = new Path(placeLoc[8], placeInt[5]);// ivan - matheu 
  b++;
  //Cynthia vai receber de leslie, malu, kiko, paola
  //  bridges[b] = new Path(placeLoc[4], placeLoc[1]);// marlus - kiko
  //  b++;
  

  for (int i = 0; i < b; i++) {
   bridges[i].dataBridge();
  }
  
  // bridges[0].dataBridge();
  // bridges[1].dataBridge();


  for (int i = 0; i < loc; i++) {
    placeLoc[i].show ();
  }

  for (int i = 0; i < reg; i++) {
    placeReg[i].show ();
  }

  for (int i = 0; i < 6; i++) {
    placeInt[i].show ();
  }
  
  dataL[6][0] = (norm(userM.x, -200, 200))*20;
  dataL[6][1] = (norm(userM.z, -200, 200))*20;
//  dataL[6][2] = (norm(userK1.z, -400, 220))*20;
//  dataL[6][3] = (norm(userK2.x, -200, 200))*20;
//  dataL[6][4] = (norm(userK2.y, -200, 200))*20;
//  dataL[6][5] = (norm(userK2.z, -400, 220))*20;
  
  OscMessage myMessage1 = new OscMessage ("/barbara/kU1_Cx");
  myMessage1.add(userM.x);
  myOsc.send(myMessage1, myRemoteLocation);
  
  OscMessage myMessage2 = new OscMessage ("/barbara/kiU1_Cy");
  myMessage2.add(userM.z);
  myOsc.send(myMessage2, myRemoteLocation);
  
//  OscMessage myMessage3 = new OscMessage ("/barbara/kiU1_Cz");
//  myMessage3.add(userK1.z);
//  myOsc.send(myMessage3, myRemoteLocation);
//  
//  OscMessage myMessage4 = new OscMessage ("/barbara/kiU2_Cx");
//  myMessage4.add(userK2.x);
//  myOsc.send(myMessage4, myRemoteLocation);
//  
//  OscMessage myMessage5 = new OscMessage ("/barbara/kiU2_Cy");
//  myMessage5.add(userK2.y);
//  myOsc.send(myMessage5, myRemoteLocation);
//  
//  OscMessage myMessage6 = new OscMessage ("/barbara/kiU2_Cz");
//  myMessage6.add(userK2.z);
//  myOsc.send(myMessage6, myRemoteLocation);
//  
}


void grid () {

  strokeWeight(0.9);
  stroke(255, 15);
  for (int i = 0; i < 125; i++) {
    line((15*i)-80, y, 0, (15*i)+x-80, y, 900);
  }

  for (int i = 0; i < 70; i++) {
    line(-80, y, 15*i, width+80, y, 15*i);
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      rY = rY+.05;
      println("rY= " + rY);
    } 
    else if (keyCode == RIGHT) {
      rY = rY-.05;
      println("rY= " + rY);
    }
    else if (keyCode == UP) {
      z = z-10;
      println("Y= " + z);
    }
    else if (keyCode == DOWN) {
      z = z+10;
      println("Y= " + z);
    }
  }

  if (key == 'l') {
    vision =1;
    println("visão LOCAL");
  }
  if (key == 'r') {
    vision =2;
    println("visão REGIONAL");
  } 
  if (key == 'i') {
    vision =3;
    println("visão INTERNACIONAL");
  }
  if (key == 'k') {
    kinect = true;
    println("Interação KINECT");
  }
  if (key == 'm') {
    kinect = false;
    println("Interação MOUSE");
  }
}

void visions(int phase) {
  vision = phase;

  switch(vision)
  {
  case 1:
    //-------------------- local --------------------- 
    if (rY<0) {
      rY= rY+0.01;
    }
    if (z>0) {
      z= z-1;
    }

    break;

  case 2:
    //-------------------- regional --------------------- 
    if (rY>-4.14) {
      rY = rY- 0.01;
    } 
    if (z<=39) {
      z=z+1;
    } 
    else if (z>=41) {
      z=z-1;
    }

    break;

  case 3:
    //-------------------- internacional --------------------- 
    if (rY>-2.4000) {
      rY = rY- 0.0100;
    } 
    if (rY<-2.3700) {
      rY = rY+ 0.0100;
    } 
    if (rY>=-2.4099982 && rY<-2.3700) { 
      rY = -2.39000;
    }
    if (z<=99) {
      z = z+1;
    } 
    else if (z>=101) {
      z = z-1;
    }

    break;
  }
}

