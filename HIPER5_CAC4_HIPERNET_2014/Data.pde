class Data {

  public String name;
  public float value;
  public int parent;
  public int nListening;
  public  PVector location;
  public ArrayList <String> whoListen;
  public ArrayList <Integer>  listenID;
  color cor;
  public float size;
  float tx;
  float ty;
  float esp = 2;
  
  Data(int i, String dataname, float datavalue){
    parent = i;
    location = new PVector();
    name = dataname;
    value = datavalue;
    cor = nodes.get(parent).cor;
    tx = nodes.get(parent).location.x;
    ty = nodes.get(parent).location.y;
    whoListen = new ArrayList <String> ();
    listenID= new ArrayList <Integer> ();
  }
  
  void updateLoc(float x, float y){
    tx=x;
    ty=y;
  }
  
  void updateValue(float datavalue){
    value = datavalue;
    size = value*30;
  }
  
  void display(){
    strokeWeight(esp);    
    stroke(255);
    fill(cor, 120);
    ellipse(location.x-tx, location.y-ty, size, size);
    
   // println(name + location.x);
    noFill();
    for (int i = 0; i< nListening; i++){
      stroke(nodes.get(i).cor);
      float lR = size + ((i+1)*10); 
      ellipse(location.x-tx, location.y-ty , lR, lR); 
    }
    
    float m = dist(location.x, location.y, mouseX, mouseY);
    //println(m);
    if(m < 30){
      displayName();
      size = value*50;
      esp = 4;
    } else {
      size = value*30;
      esp = 2;
    }
  }
  
  void displayName() {
     pushMatrix();
     translate(-tx, -ty);
        fill(255, 25);
        noStroke();
        rect(0, 0, width/3, height);
        fill(255);
        textSize(30);
        text(nodes.get(parent).name + "/" + name + "   " + value, 40, 40);
        textSize(20);
        for(int l = 0; l < whoListen.size(); l++){
        text(whoListen.get(l) + " ouve", 60, 70+(l*30));
        }
     popMatrix();
        //text(whoListen, 5, 80);
     }
}


//methods for dashline got from: http://www.openprocessing.org/sketch/7013
void dashline(float x0, float y0, float x1, float y1, float[ ] spacing)
{
  float distance = dist(x0, y0, x1, y1);
  float [ ] xSpacing = new float[spacing.length];
  float [ ] ySpacing = new float[spacing.length];
  float drawn = 0.0;  // amount of distance drawn
 
  if (distance > 0)
  {
    int i;
    boolean drawLine = true; // alternate between dashes and gaps
 
    /*
      Figure out x and y distances for each of the spacing values
      I decided to trade memory for time; I'd rather allocate
      a few dozen bytes than have to do a calculation every time
      I draw.
    */
    for (i = 0; i < spacing.length; i++)
    {
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance);
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance);
    }
 
    i = 0;
    while (drawn < distance)
    {
      if (drawLine)
      {
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]);
      }
      x0 += xSpacing[i];
      y0 += ySpacing[i];
      /* Add distance "drawn" by this line or gap */
      drawn = drawn + mag(xSpacing[i], ySpacing[i]);
      i = (i + 1) % spacing.length;  // cycle through array
      drawLine = !drawLine;  // switch between dash and gap
    }
  }
}
 
void dashline(float x0, float y0, float x1, float y1, float dash, float gap)
{
  float [ ] spacing = { dash, gap };
  dashline(x0, y0, x1, y1, spacing);
}

void dashEllipse (float x, float y, float r, float dash, float gap){
  float x0off, y0off;
  float x1off, y1off;
  for(int i = 0; i < 360; i+=gap+dash){
       x0off = cos(radians(i))*r;
       y0off = sin(radians(i))*r;
       x1off = cos(radians(i+dash))*r;
       y1off = sin(radians(i+dash))*r;
       line(x+x0off,y+y0off, x+x1off,y+y1off);
   }
}
