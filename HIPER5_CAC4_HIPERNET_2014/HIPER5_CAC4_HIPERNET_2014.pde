/* ---------------------------------------------------------------------------------------------
 * HIPERORGANICOS 5
 * ---------------------------------------------------------------------------------------------
 * prog:  Barbara Castro / Artist-researcher / EBA/UFRJ / NANO - Nucleo de Arte e Novos Organismos
 * www.barbaracastro.com.br    !      http://www.nano.eba.ufrj.br
 * date:  28/08/2014 (d/m/y)
 * ---------------------------------------------------------------------------------------------
 * Data Visualization of telemediatic artistic experience. NANO network - http://146.164.80.56:3000/  
 */

import oscP5.*;
import netP5.*;
OscP5 myOsc;

boolean osc = false; // <<<<<---------------------- mude aqui para simulação / recepção de dados

int receiveRate = 3; // a cada quantos frames recebe dados

int nNodes;
ArrayList <String> nodeIDS;
ArrayList <Node> nodes;



// setup conexion
int myPort = 22244;
String otherIP = "localhost";
NetAddress myRemoteLocation;
String userName = "/barbara";

color[]       nodesClr = new color[] { 
  color(255, 0, 0), //vermelho
  color(0, 217, 18), //verde
  color(196, 0, 199), //roxo
  color(255, 157, 0), //laranja
  color(255, 0, 98), //rosa
  color(255, 247, 0), //amarelo
  color(0, 0, 240) //azul
};

void setup() {
  size(displayWidth, displayHeight);

  myOsc = new OscP5(this, myPort);
  myRemoteLocation = new NetAddress(otherIP, 22243);

  nodes = new ArrayList<Node>();
  nodeIDS = new ArrayList<String>();

  //imprimir comandos de interação
  println("'p' -> imprime players e seus dados");
  println(" 'o' -> alterna entre dados simulados ou do servidor");
  println("'i' -> imprime manual de interações");
}

void draw() {
  background(0);

  if (!osc) { // <--------------------- dados falsos
    addUser("Fabacateiro");
    addData(nodes.size()-1, "kinect", 0.4);
    addData(nodes.size()-1, "voz", 0.2);
    addUser("Fmalu");
    addData(nodes.size()-1, "abelha", .7);
    addUser("Fhiperbot"); 
    addData(nodes.size()-1, "luz", .2);
    addData(nodes.size()-1, "planta", .9);
    addData(nodes.size()-1, "temperatura", .6);
    
    addListenData (0, "Fhiperbot/luz");
    addListenData (0, "Fhiperbot/planta");
    addListenData (0, "Fhiperbot/temperatura");
    addListenData (0, "Fmalu/abelha");
    addListenData (1, "Fhiperbot/luz");
    addListenData (1, "Fhiperbot/planta");
    addListenData (1, "Fhiperbot/temperatura");
    addListenData (1, "Fbarbara/kinect");
    addListenData (2, "Fmalu/abelha");
    addListenData (2, "Fbarbara/kinect");
  } 

  if (osc) { // <--------------------- dados falsos
    for (int i = 0; i < nodes.size(); i++) {
      if (nodes.get(i).name.equals("Fabacateiro") || nodes.get(i).name.equals("Fmalu") || nodes.get(i).name.equals("Fhiperbot")) {
        nodes.remove(i);
      }
    }
  } 
  for (int i = 0; i < nodes.size(); i++) {
    Node n = nodes.get(i);
    n.update();
    n.display();
    //for(int d=0; d<nodes.get(i).data.size();d++){
     // nodes.get(i).data.get(d).updateValue(random(0,1));
    //}    
  }
}

