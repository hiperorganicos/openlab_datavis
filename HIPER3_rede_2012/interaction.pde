PVector use (boolean kin, int i) {
  //PVector kinect;
  PVector mouse = new PVector();
  float ytoZ, xtoZ;

    mouse.y = 0;

    if (mouseY < 659 && mouseY >= 457) {
      xtoZ = map (mouseX, 18, 953, 50, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 457, 659, 100, 200);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 457 && mouseY >= 343) {
      xtoZ = map (mouseX, 125, 894, 50, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 457, 343, 100, 0);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 343 && mouseY >= 270) {
      xtoZ = map (mouseX, 183, 815, 50, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 270, 343, -100, 0);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 270 && mouseY >= 217) {
      xtoZ = map (mouseX, 233, 779, 50, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 270, 217, -100, -200);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 217 && mouseY >= 177) {
      xtoZ = map (mouseX, 158, 735, 50, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 217, 177, -300, -200);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 177 && mouseY >= 150) {
      xtoZ = map (mouseX, 292, 694, 0, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 150, 177, -400, -300);
      mouse.z = ytoZ;
    } 
    else if (mouseY < 150 && mouseY >= 0) {
      xtoZ = map (mouseX, 242, 694, 0, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 150, 0, -400, -1000);
      mouse.z = ytoZ;
    } 
    else if (mouseY < height && mouseY > 660) {
      xtoZ = map (mouseX, 242, 694, 0, 425);
      mouse.x = xtoZ;
      ytoZ = map (mouseY, 660, height, 200, 220);
      mouse.z = ytoZ;
    }
    return mouse;
}

