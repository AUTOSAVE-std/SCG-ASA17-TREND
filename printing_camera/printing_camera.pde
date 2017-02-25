import processing.pdf.*;
import java.io.InputStreamReader;
import processing.video.*;
Capture cam;
boolean print= false;
void setup() {
  size(1920, 1080);
  //fullScreen();
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      print(i);
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[87]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0);
  set(0, 0, cam);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
void keyPressed() {
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
  launch  ("\""+ "C:/Program Files (x86)/Foxit Software/Foxit Reader/FoxitReader.exe"+"\"" +" /p "+ "C:/Users/SCG/Documents/Processing/SCG-ASA17-TREND/printing_camera/output.pdf");
  print = true;
  }
}
 