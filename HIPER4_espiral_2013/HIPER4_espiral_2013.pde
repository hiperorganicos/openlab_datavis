/*
Visualização para o Hiperorganicos 2014
Barbara Castro - www.barbaracastro.com.br
NANO - nano.eba.ufrj.br
nano.eba.ufrj.br/hiper4
*/

boolean osc = true; //<<<<<<<---------------- t: dados do servidor / f: randômicos
Planta planta1, planta2;
float rotAng =1;

float mx, my;

float wx = 0;
float wy = 0;
float [] px, py;

void setup() {
  size(displayWidth, displayHeight);
  smooth();
  frameRate(12);
  background(0);
  
  myOsc = new OscP5(this, myPort);
  myRemoteLocation = new NetAddress(otherIP, 22243);
  
  planta1 = new Planta(.64, .91, 4, color(0, 255, 0), 120);
  planta2 = new Planta(.77, .77, 4, color(255, 0, 80), 120); 
}

void draw() {
  
  background(0);
  pushMatrix();
  translate(wx, wy); 
  planta1.display(); 
  planta2.display();
 
 if(px != null){
  if(px.length>4){
     px = shorten(px);
  }
  if(py.length>4){
     py = shorten(py);
  } 
 }
 popMatrix();
}


void keyPressed(){
  if(key == CODED){
      if(keyCode == RIGHT){
      wx += 2;
      println(wx+ "  " +wy);
    }
    if(keyCode == LEFT){
      wx -= 2;
      println(wx+ "  " +wy);
    }
    if(keyCode == UP){
      wy += 2;
      println(wx+ "  " +wy);
    }
    if(keyCode == DOWN){
      wy -= 2;
      println(wx+ "  " +wy);
    }
  }
}
