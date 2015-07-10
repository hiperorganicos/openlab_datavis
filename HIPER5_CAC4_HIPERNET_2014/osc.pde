// RECEBER DADOS
int currentNode;

void oscEvent(OscMessage msg) {
  //println("MESSAGE: " + msg + "   ... end message");
  String addr = msg.addrPattern();
  String [] item = split(msg.addrPattern(), "/");
  //println(item[1] + "  " + item[2]);
  if(osc){
  addUser(item[1]);
  float val = msg.get(0).floatValue();
  addData(currentNode, item[2], val);
  
  // checar se é dado ouvindo
  int lD = addr.indexOf("/listening/");
  if(lD != -1){
    int sub = lD + 11; // caracter inicial do nome dos node e do dado ouvido
    String lData = addr.substring(sub);
    addListenData(currentNode, lData);
  }
  }
}

boolean addUser (String userID) {
  if (!nodeIDS.contains(userID)) {
    if(!userID.equals("groupclient")){
    nodes.add(new Node(userID, nodes.size()+1));
    nodeIDS.add(new String(userID));
    //println(userID + " has been added to list");
    //println(nodeIDS);
    currentNode = nodes.size()-1;
    }
    return true;
  }
  //println(userID + " cannot be added to list because already there");
  for (int i = 0; i < nodes.size(); i++) {
    if (userID.equals(nodes.get(i).name)) {
      currentNode = i;
    }
  }
  return false;
}

boolean addData (int i, String dataID, float value) {
  if (!nodes.get(i).dataIDS.contains(dataID)) {
    nodes.get(i).data.add(new Data(i, dataID, value));
    nodes.get(i).dataIDS.add(new String(dataID));
    //println(dataID + " has been added to " + nodes.get(i).name);
    return true;
  }
  //println(dataID + " cannot be added to " + nodes.get(i).name + " because is already there");
  for (int j = 0; j < nodes.get(i).data.size(); j++) {
   if (dataID.equals(nodes.get(i).data.get(j).name)) { 
    nodes.get(i).data.get(j).updateValue(value);
   }
  }
  return false;
}

boolean addListenData (int i, String dataID) { // i é quem está ouvindo - dataID é o que está sendo ouvido /usuario/dado
  if (!nodes.get(i).listen.contains(dataID)) {   // se não este nome não está incluido na lista
    nodes.get(i).listen.add(new String(dataID)); // incluir em listen
    
      String [] listening = split(dataID, "/"); 
      String nodeL = listening[0];  // nome de quem estou ouvindo
      String dataL = listening[1]; //  dado que estou ouvindo

      for (int n = 0; n < nodes.size(); n++) {  // para todos os nós
        if (nodeL.equals(nodes.get(n).name)) {  //se nome que estou ouvindo é igual ao nome de algum no
          for (int d = 0; d < nodes.get(n).dataIDS.size(); d++) { // para todos os dados dele
            if (dataL.equals (nodes.get(n).data.get(d).name)) {  // se o dado que estou ouvindo é igual a algum dado dele
              nodes.get(n).data.get(d).whoListen.add(new String(nodes.get(i).name)); // avisa ao dado que ele está sendo ouvido por este node 
              nodes.get(n).data.get(d).listenID.add (new Integer(i)); // avisa ao dado o index de quem esta ouvindo
              nodes.get(n).data.get(d).nListening++; // avisa ao dado que o numero de gente ouvindo ele aumentou
              nodes.get(i).dList.add (new DataListen (i, n, d)); // adiciona este dado a lista de objetos como dados ouvidos 
             // println(dataID + " is beeing listened by " + nodes.get(i).name);
            }
          }
        }
      }
    return true;
  }
  //println(dataID + " cannot be added to " + nodes.get(i).name + " because is already there");
  return false;
}
