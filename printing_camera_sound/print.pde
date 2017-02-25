int flashcount = 30; // 30 frame = 1 sex
int startcountflash = 0;
boolean markflash = false;
void detectSound(float lound){
  if(lound > 500){
    markflash = true;
  }  
}
void print() {
  if(print==false){
  PGraphics pdf = createGraphics(1280, 960, PDF, "output.pdf");
  pdf.beginDraw();
  pdf.background(255, 255, 255);
  pdf.stroke(0);
  //pdf.translate(640/2, 480/2);
  //pdf.image(cam, -(640/2), -(480/2), 640/2, 480/2);
  pdf.image(cam, 0,0,1280, 960);
  pdf.rect(20,20,100,100);
  pdf.line(50, 50, 250, 250);
  pdf.dispose(); 
  pdf.endDraw();
  launch  ("\""+ "C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe"+"\"" +" /p "+ "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing_camera_sound/output.pdf");
  print = true;
  }
}