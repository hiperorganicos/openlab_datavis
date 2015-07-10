import oscP5.*;
import netP5.*;

OscP5 myOsc;

// setup conexion
int myPort = 22244;
String otherIP = "localhost";
NetAddress myRemoteLocation;


void oscEvent(OscMessage msg) {
  //println(msg);
  String addr = msg.addrPattern();
  float val = msg.get(0).floatValue();
//  println(addr + "   " + val);
if(osc){
  //if(frameCount%3 == 0){
    if (addr.equals("/hiperbot1/planta")) {
      //planta1.dataValue[0] = map(val, 0.4, 0.6, 0.0, 1.5);
     float mapa = map(val, 0.4, 0.6, 0.0, 1.5);
      planta1.petalas[0].updateData(mapa);
    }
    if (addr.equals("/hiperbot1/luz")) {
       float mapa = map(val, 0.7, 0.9, 0.0, 1.5);
       planta1.petalas[1].updateData(mapa);
    }
    if (addr.equals("/hiperbot1/solo")) {
       float mapa = map(val, 0.3, 0.6, 0.0, 1.5);
       planta1.petalas[2].updateData(mapa);
    }
    if (addr.equals("/hiperbot1/temp")) {
       float mapa = map(val, 0.5, 0.65, 0.0, 1.5);
       planta1.petalas[3].updateData(mapa);
    }
    
    if (addr.equals("/hiperbot2/planta")) {
       float mapa = map(val, 0.5, 0.65, 0.0, 1.5);
       planta2.petalas[0].updateData(mapa);
    }
    if (addr.equals("/hiperbot2/luz")) {
       float mapa = map(val, 0.8, 1.0, 0.0, 1.5);
       planta2.petalas[1].updateData(mapa);
    }
    if (addr.equals("/hiperbot2/solo")) {
       float mapa = map(val, -0.3, 0.6, 0.0, 1.5);
       planta2.petalas[2].updateData(mapa);
    }
    if (addr.equals("/hiperbot2/temp")) {
       float mapa =  map(val, 0.2, 0.4, 0.0, 1.5);
       planta2.petalas[3].updateData(mapa);
    }
    
    if (addr.equals("/tracking/0x")) {
      px = append(px, val);
    }
    if (addr.equals("/tracking/0y")) {
     py = append(py, val);
    }
    if (addr.equals("/tracking/1x")) {
     px = append(px, val);
    }
    if (addr.equals("/tracking/1y")) {
     py = append(py, val);
    }
    if (addr.equals("/tracking/2x")) {
     px = append(px, val);
    }
    if (addr.equals("/tracking/2y")) {
     py = append(py, val);
    }
    if (addr.equals("/tracking/3x")) {
     px = append(px, val);
    }
    if (addr.equals("/tracking/3y")) {
     py = append(py, val);
    }   
  }

}

void sendMessages(){
  OscMessage myMessage1 = new OscMessage ("/barbara/mouseX");
  myMessage1.add(mx);
  myOsc.send(myMessage1, myRemoteLocation);
  
  OscMessage myMessage2 = new OscMessage ("/barbara/mouseY");
  myMessage1.add(my);
  myOsc.send(myMessage2, myRemoteLocation);  
}


  
