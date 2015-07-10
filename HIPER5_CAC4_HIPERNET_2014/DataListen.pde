class DataListen {

  public int parent; // index do nodes que está o pai
  public int node; // index do node que está ouvindo
  public String quem;
  public int data; // index do dado do node que está ouvindo
  public String que;
  color cor; // cor do node que está ouvindo
  PVector listLoc;
   
  DataListen(int p, int n, int d){
    parent = p;
    node = n;
    data = d;
    cor = nodes.get(node).cor;
    quem = nodes.get(n).name;
    que = nodes.get(n).data.get(d).name;
    //listLoc.x = nodes.get(n).data.get(d).location.x;
    //listLoc.y = nodes.get(n).data.get(d).location.y;
  }
}

