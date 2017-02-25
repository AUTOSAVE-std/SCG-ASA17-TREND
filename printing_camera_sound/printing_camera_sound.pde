import processing.pdf.*;
import processing.sound.*;
import java.io.InputStreamReader;
import processing.video.*;
Capture cam;
boolean print= false;
Amplitude amp;
AudioIn in;
float[] level;
void setup() {
  //size(1920, 1080);
  fullScreen();
  String[] cameras = Capture.list();
  
  level = new float[width+1];
  for(int i=0; i<=width;i++) {
    level[i] = 0;
  }
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  strokeWeight(1);
  
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
    cam = new Capture(this, cameras[83]);
    cam.start();     
  }      
}

void draw() {
    background(30);
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0);
  
  float h = map(amp.analyze(), 0, 1, 0, height);
  //println(h);
  
  //set(0, 0, cam);
    image(cam, 0, 0);
    detectSound(h);
  if(markflash == true && startcountflash < flashcount){
    background(255,255,255);
    if(startcountflash == startcountflash/2){
      print();
    }
    startcountflash++;
    println(startcountflash);
  }
  //if(h>200 && print == false) { 
  //  background(255,255,255);
  //  delay(3000);
  //  print();
  // }
 // if(h>200) { print(); }
  
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  
  for(int i=0; i<=width-1; i++) {
    level[i] = level[i+1];
  }
  level[width] = h;
  
  for(int i=0; i<=width-1; i++) {
    stroke(level[i],40,90);
    line(i,height-level[i],i,height);
  }
  
  
}

 