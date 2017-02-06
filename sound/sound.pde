import processing.sound.*;
import processing.video.*;

import processing.pdf.*;
boolean saveOneFrame = false;

Capture cam;
Amplitude amp;
AudioIn in;
PVector nStart;
float hue;
float[] level;
void setup(){

  //size(500, 500);
  fullScreen();
  background(30);
  level = new float[width+1];
  for(int i=0; i<=width;i++) {
    level[i] = 0;
  }
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  strokeWeight(1);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this,960,720, "Logitech HD Webcam C615", 30);
//Capture(parent, requestWidth, requestHeight, cameraName, frameRate)
    cam.start();     
  }
  
  
  
}

void mousePressed() {                     // When a mouse button is pressed,
  saveOneFrame = true;                    // trigger PDF recording within the draw()
}

void draw(){
  if (saveOneFrame == true) {             // When the saveOneFrame boolean is true,
    beginRecord(PDF, "line-####.pdf");    // start recording to the PDF
  }
  
  
  
  
  background(0);
    if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  //set(0, 0, cam);
  float h = map(amp.analyze(), 0, 1, 0, height);
  for(int i=0; i<=width-1; i++) {
    level[i] = level[i+1];
  }
  level[width] = h;
  
  for(int i=0; i<=width-1; i++) {
    stroke(level[i],40,90);
    line(i,height-level[i],i,height);
  }
 

 
 
 
 
  if (saveOneFrame == true) {             // If the PDF has been recording,</em>
    endRecord();                          // stop recording, 
    saveOneFrame = false;                 // and set the boolean value to false
  }
 
}