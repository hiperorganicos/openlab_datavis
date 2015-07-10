void oscEvent(OscMessage msg) {
  println(msg);
  String addr = msg.addrPattern();
  float val = msg.get(0).floatValue();
  //println(addr + "   " + val);
  
  if(addr.equals("/nano_base")) {
   dataL[15][0] = val;
   //println("NANO   " + val);
   dataL[15][0] = map (dataL[15][0], 130, 136, 5, 20); 
   dataL[15][0] = constrain(dataL[15][0], 5, 20);
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  
//  if (addr.equals("/marlus")) {
//   dataL[4][0] = val;
//   dataL[4][0] = map (dataL[4][0], 0, 1, 5, 20);   
//      //, dataL[4][1], dataL[4][2], dataL[4][3], dataL[4][4], dataL[4][5]
//  }
//  
//  if (addr.equals("/marlus/test")) {
//   dataL[4][1] = val;
//   dataL[4][1] = map (dataL[4][0], 0, 1, 5, 20);   
//      //, dataL[4][1], dataL[4][2], dataL[4][3], dataL[4][4], dataL[4][5]
//  }

 if(osc){
  if(addr.equals("/Ubersonic/residual")) {
   dataL[5][0] = val;
   dataL[5][0] = map (dataL[5][0], .1, .8, 5, 20);
   dataL[5][0] = constrain(dataL[5][0], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  
  if(addr.equals("/elen/som")) {
   dataL[0][0] = val;
//  println("ELEN  " + val); 
   dataL[0][0] = map (dataL[0][0], .6, .85, 0, 20);
 //dataL[0][1], dataL[0][2], dataL[0][3], dataL[0][4], dataL[0][5]    y = val;
  }
  
  if(addr.equals("/bruno/sabotage")) {
   dataL[12][0] = val;    
   dataL[12][0] = map (dataL[12][0], 0, 1, 5, 20);
     //dataL[12][1], dataL[12][2], dataL[12][3], dataL[12][4], dataL[12][5]
  }
  
  if(addr.equals("/Coherence_Mirror")) {
   dataR[2][0] = val;
  // println("GLERM" + val);
   dataR[2][0] = map (dataR[2][0], 0, 1, 5, 20);
    //, dataR[2][1], dataR[2][2], dataR[2][3], dataR[2][4], dataR[2][5]
  }
  
  if(addr.equals("/girao/randRef")) {
   dataI[1][0] = val;
   dataI[1][0] = map (dataI[1][0], 0, 1, 5, 20); 
 // dataI[1][0], dataI[1][1], dataI[1][2], dataI[1][3], dataI[1][4], dataI[1][5], colN[2]);
 //  placeReg[4] = new Node("UFBA - Bruno",  2, 4, 3);
  }

  if(addr.equals("/bruno/dado1")) {
   dataR[4][0] = val;
   dataR[4][0] = map (dataR[4][0], 0, 1, 5, 20); 
 //  placeReg[4] = new Node("UFBA - Bruno",  2, 4, 3);
  }

if(addr.equals("/bruno/k_head_Y")) {
   dataR[4][1] = val;
   dataR[4][1] = map (dataR[4][1], 0, 1, 5, 20); 
 //  placeReg[4] = new Node("UFBA - Bruno",  2, 4, 3);
  }    

if(addr.equals("/bruno/k_head_Z")) {
   dataR[4][2] = val;
   dataR[4][2] = map (dataR[4][2], 0, 1, 5, 20); 
 //  placeReg[4] = new Node("UFBA - Bruno",  2, 4, 3);
  }

if(addr.equals("/ijexa")) {
   dataR[0][0] = val;
   dataR[0][0] = map (dataR[0][0], 0, 1, 5, 20); 
 //  placeReg[4] = new Node("UFBA - Bruno",  2, 4, 3);
  }      
 // println(msg);

if(addr.equals("/eadward/L")) {
   dataI[3][0] = val;
   dataI[3][0] = map (dataI[3][0], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  } 

if(addr.equals("/eadward/stimulus")) {
   dataI[3][1] = val;
   dataI[3][1] = map (dataI[3][1], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  } 

if(addr.equals("/eadward/SC")) {
   dataI[3][2] = val;
   dataI[3][2] = map (dataI[3][2], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
 if(addr.equals("/eadward/SC")) {
   dataI[3][2] = val;
   dataI[3][2] = map (dataI[3][2], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
 if(addr.equals("/eadward/R")) {
   dataI[3][3] = val;
   dataI[3][3] = map (dataI[3][3], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
 if(addr.equals("/eadward/T")) {
   dataI[3][4] = val;
   dataI[3][4] = map (dataI[3][4], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
 if(addr.equals("/eadward/A")) {
   dataI[3][5] = val;
   dataI[3][5] = map (dataI[3][5], 0, 1, 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  if(addr.equals("/eadward/V")) {
   dataI[3][6] = val;
   dataI[3][6] = map (dataI[3][6], 0, 1, 5, 20);
   dataI[3][6] = constrain(dataI[3][6], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  if(addr.equals("/tania/z")) {
   dataL[2][0] = val;
   println("TANIA  " + val);
   dataL[2][0] = map (dataL[2][0], 1400, 2000, 5, 20);
   dataL[2][0] = constrain(dataL[2][0], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  if(addr.equals("/gen/ping")) {
   dataL[1][0] = val;
   //println("KIKO  " + val);
   dataL[1][0] = map (dataL[1][0], 0, 1, 5, 20);
   dataL[1][0] = constrain(dataL[1][0], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  if(addr.equals("jackson")) {
   dataL[13][0] = val;
   //println("KIKO  " + val);
   dataL[13][0] = map (dataL[13][0], 0, 10, 5, 20);
   dataL[13][0] = constrain(dataL[13][0], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
  if(addr.equals("paolab/plantalla")) {
   dataL[11][0] = val;
   //println("KIKO  " + val);
   dataL[11][0] = map (dataL[11][0], 0, 1, 5, 20);
   dataL[11][0] = constrain(dataL[11][0], 5, 20); 
 //placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
  }
 }
  
  
 
}

//Cynthia vai receber de leslie, malu, kiko, paola

//  placeLoc[1] = new Node("Kiko Barreto", 1, 1, 1);
//  placeLoc[2] = new Node("Tania Fraga", 1, 2, 1);
//  placeLoc[5] = new Node("Leslie Garcia", 1, 5, 1);
//  placeLoc[6] = new Node("Barbara Castro", 1, 6, 1);
//  placeLoc[7] = new Node("Walmeri Ribeiro", 1, 7, 1);
//  placeLoc[8] = new Node("Ivan Henrique", 1, 8, 1);
//  placeLoc[9] = new Node("Raquel Rennó", 1, 9, 1);
//  placeLoc[10] = new Node("Bruno Vianna", 1, 10, 1);

//  placeLoc[12] = new Node("Cinthia Mendonça", 1, 12, 1);
//  placeLoc[13] = new Node("Jackson Marinho", 1, 13, 1);
//  placeLoc[14] = new Node("Alexandra Cristina", 1, 14, 1);
//  placeLoc[15] = new Node("Caio Cruz", 1, 15, 1);
//  placeLoc[16] = new Node("Rodrigo Rodrigues", 1, 16, 1);
//  placeLoc[17] = new Node("Juliana Tobar", 1, 17, 1);
//  placeLoc[18] = new Node("Adriano Belizário", 1, 18, 1);
//  placeLoc[19] = new Node("Ricardo Brazileiro", 1, 19, 1);
//  placeLoc[20] = new Node("Ricardo Ruiz", 1, 20, 1);

//  //reg
//  placeReg[0] = new Node("UNICAMP",  2, 0, 1);
//  placeReg[1] = new Node("UNOESTE",   2, 1, 1);
//  placeReg[3] = new Node("UnB",   2, 3, 1);
//  placeReg[5] = new Node("UFBA - Karla",  2, 5, 1);

//  //inter
//  placeInt[0] = new Node("Kjell Petersen", 3, 0, 1);
//  placeInt[1] = new Node("Luis Girão", 3, 1, 1);
//  placeInt[2] = new Node("Briggita Zics", 3, 2, 1);
//  placeInt[3] = new Node("Eduardo Coutinho",  3, 3, 1);
//  placeInt[4] = new Node("Ken/Bruce",  3, 4, 1);
//  placeInt[5] = new Node("Katerina Karoussos", 3, 5, 1);
