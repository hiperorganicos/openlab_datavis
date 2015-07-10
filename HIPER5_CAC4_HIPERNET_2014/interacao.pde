// 'p' -> imprime players e seus dados
// 'o' -> alterna entre dados simulados ou do servidor
void keyPressed(){
  if(key == 'p'){
    println("------------------------------------------------------");
     println("TOTAL DE NODES = " + nodes.size());

    for (int i=0; i<nodes.size(); i++) {
      println("NÓ " + i + "    " + nodes.get(i).name + ": " + nodes.get(i).data.size() + " dados");
      for (int j = 0; j < nodes.get(i).data.size(); j++) {
        Data n =  nodes.get(i).data.get(j);
        println("     PRODUZINDO DADO " +  j + ": " + n.name + " = " + n.value);// + "  X= " + n.location.x  + "   Y= "+  n.location.y);
        if(n.nListening > 0){
        println("                   " + n.nListening + " ouvindo: " + n.whoListen);
        }
      }
      for(int l = 0; l < nodes.get(i).dList.size(); l++){
         DataListen  lD =  nodes.get(i).dList.get(l);
         println("     OUVINDO DADO " + lD.node + "/" + lD.data + " = " + lD.quem + "/" + lD.que);//+ "        x = " +lD.listLoc.x + "  y = " + lD.listLoc.y); 
       }
      println("  ");
    }
  }
  
  if(key == 'o'){
    if(osc == true){
      osc = false;
      println("OSC DESLIGADO - trabalhando com dados simulados");
    } else if(osc == false){
      osc = true;
      println("OSC LIGADO - trabalhando com dados do servidor");
    }
  }
  
  if(key == 'i'){
    println("'p' -> imprime players e seus dados");
    println("'o' -> alterna entre dados simulados ou do servidor");
    println("'i' -> imprime manual de interações");
  }
  println("------------------------------------------------------");
}
//
//void mousePressed() {
//  if (mouseButton == LEFT) {
//    println("TOTAL DE NODES = " + nodes.size());
//
//    for (int i=0; i<nodes.size(); i++) {
//      println(nodes.get(i).name + ": " + nodes.get(i).data.size() + " dados");
//      for (int j = 0; j < nodes.get(i).data.size(); j++) {
//        println(nodes.get(i).data.get(j).name + " = " + nodes.get(i).data.get(j).value);
//      }
//      println("  ");
//    }
//  }
//}

