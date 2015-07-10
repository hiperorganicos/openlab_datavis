class Node {
  public String name;
  public int nData;
  public int nListen;
  int indice;
  color cor;
  PVector location = new PVector();
  PVector velocity = new PVector();
  public ArrayList <Data> data;
  public ArrayList <String> dataIDS;
  public ArrayList <String> listen;
  public ArrayList <DataListen> dList;
  float nX, nY;

  Node(String nodename, int index) {
    name = nodename;
    cor = nodesClr[index%nodesClr.length];
    data = new ArrayList < Data >();
    dataIDS = new ArrayList < String >();
    listen = new ArrayList < String >();
    dList = new ArrayList < DataListen >();
    nListen = int(random(2, 4));
    nX = index*random(0, 1);
    nY = nX/2;

    location.x = index*(width/6);
    location.y = random(height/4, 3*height/4);
  }


  void update() {
    nData = data.size();
    nListen = listen.size();
    nX+= 0.01;
    nY+= 0.01;
    location.x+= map(noise(nX), 0, 1, -1, 1);
    location.y+= map(noise(nY), 0, 1, -1, 1);

    location.x = constrain(location.x, width/5, 4*(width/5));
    location.y = constrain(location.y, height/5, 4*(height/5));

    for (int d = 0; d < data.size(); d++) {
      data.get(d).updateLoc(location.x, location.y);
    } 
    //  getLinks();
  }

  void display() {
    int size = width/10;
    polygon(location.x, location.y, nData + nListen, size, cor, true);
    float m = dist(location.x, location.y, mouseX, mouseY);
    if (m < (2*size)/3) {
      polygon(location.x, location.y, nData + nListen, size/5, color(255), false);
      displayName();
      if (mousePressed == true) {
        polygon(location.x, location.y, nData + nListen, size/5, color(0), false);
        location.x = mouseX;
        location.y = mouseY;
        for (int d = 0; d < data.size(); d++) {
          data.get(d).updateLoc(location.x, location.y);
        }
      }
    }
  }

  void polygon(float tx, float ty, int n, float d, color cor, boolean showData)
  {
    pushMatrix();
    translate(tx, ty); // changes the origin
    float r = d/2; 
    //ellipse(0,0,d,d); // Uncomment this to see the polygon inscribed in a circle.
    float[] x = new float[n]; 
    float[] y = new float[n];
    float[] xD = new float[nData]; 
    float[] yD = new float[nData]; 

    x[0] = 0;
    y[0] = -r;

    float theta = (PI/2)-(TWO_PI/n);

    for (int i = 0; i < n; i++)
    {
      x[i] = r*cos(theta);
      y[i] = -r*sin(theta);
      if (showData) {
        if (i < nData) {
          float c = map(nX, 0, 1, -2, 2);
          xD[i] = (r*2)*cos(theta);
          yD[i] = -(r*2)*sin(theta);
          data.get(i).location.x= screenX(xD[i], yD[i]);
          data.get(i).location.y= screenY(xD[i], yD[i]);
        }
      }
      //ellipse(x[i],y[i],4,4);
      theta = theta - (TWO_PI/n);
    }

    beginShape();
    for (int i = 0; i < x.length; i++) {
      vertex(x[i], y[i]);
      if (showData) {
        if (i<nData) {
          stroke(255);
          strokeWeight(4);
          line(x[i], y[i], xD[i], yD[i]);
          if (i<data.size()) {
            data.get(i).display();
          }
        } 
        else {
          if (i-nData < dList.size()) { 
            int nL = dList.get(i-nData).node; // ver quem é que está gerando o dado ouvido
            int dL = dList.get(i-nData).data; // // ver qual dado ouvido
            float dLx = nodes.get(nL).data.get(dL).location.x - tx; //pegar coordenada x do dado 
            float dLy = nodes.get(nL).data.get(dL).location.y - ty; //pegar coordenada y do dado
            float distL = dist(x[i], y[i], dLx, dLy);
            float dash = map(distL, 0, width/2, 3, 10);
            float gap = map(distL, 0, width/2, 2, 8);
            stroke(255);
            strokeWeight(2);
            dashline(x[i], y[i], dLx, dLy, dash, gap);  // <<----------------   desenhar linhas pontilhadas até quem está ouvindo
          }
        }
      }
    }
    
    fill(cor);
    if(showData){
      stroke(255);  
    } else {
      noStroke();
    }
    strokeWeight(4);
    endShape(CLOSE);

    popMatrix();
  }

  /* void getLinks() {
   for (int i = 0; i<listen.size(); i++) {
   String [] listening = split(listen.get(i), "/");
   
   String nodeL = listening[0];       
   String dataL = listening[1];
   // println(name + "  " + listening[0] + "  " + listening[1]);
   
   for (int n = 0; n < nodes.size(); n++) {
   if (nodeL.equals(nodes.get(n).name)) {
   for (int d = 0; d < nodes.get(n).dataIDS.size(); d++) {
   if (dataL.equals (nodes.get(n).data.get(d).name)) {
   dList.add (new DataListen (indice, n, d));
   }
   }
   }
   }
   }
   }
   */
  void displayName() {
    fill(255, 25);
    noStroke();
    rect(0, 0, width/3, height);
    fill(255);
    textSize(30);
    text(name, 40, 40);
    textSize(20);
    for (int d = 0; d < data.size(); d++) {
      text(data.get(d).name + " - " + data.get(d).value, 60, 70 +(d)*30);
    }
  }
}

