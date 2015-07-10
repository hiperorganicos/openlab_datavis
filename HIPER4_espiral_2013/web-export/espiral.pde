//Sketch by Jim Bumgardner: http://krazydad.com/tutorials/circles_js/showexample.php?ex=animated_spiral

int   nbr_circles = 100;
  float angle_incr = 2*PI / nbr_circles;
  
  void setup() {
    size(600,600);
    smooth();
    frameRate(12);
  }
  
  void draw() {
    background(255);
  
    fill(0);
    
    float elapsedSeconds = millis()*.001;
    float angle_incr = radians(2 + frameCount/12.0);
  
    float cx = width/2;
    float cy = height/2;
    float outer_rad = width*.45;
    
    float sm_diameter = 4;
    
    for (int i = 1; i <= nbr_circles; ++i) {
      float ratio = i/(float)nbr_circles;
      float spiral_rad = ratio * outer_rad;
      float angle = i*angle_incr;
      float x = cx + cos(angle) * spiral_rad;
      float y = cy + sin(angle) * spiral_rad;
    
      // draw tiny circle at x,y
      ellipse(x, y, sm_diameter, sm_diameter);
    }
  }

