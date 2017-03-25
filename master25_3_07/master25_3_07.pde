import processing.sound.*;
import processing.video.*;
Movie scene1;
SoundCAP_main mainsoundCAP;
boolean ended;
void setup() {
  fullScreen();
  //scene1 = new Movie(this, "video/1AuthenticnoVDOintro.mp4");
  
  //scene1 = new Movie(this, "video/1AuthenticnoVDOintro.mp4") {
  //  @ Override public void eosEvent() {
  //    super.eosEvent();
  //    myEoS();
  //  }
  //};
 
  //scene1.play();
  //scene1.noLoop();
  //while (scene1.width == 0 | scene1.height == 0)  delay(20);
  //surface.setSize(scene1.width, scene1.height); // P3

  mainsoundCAP = new SoundCAP_main();
}


void draw() {
  //if (!ended)  image(scene1, 0, 0);
  //else {
  //  mainsoundCAP.draw();
  //}
  
  mainsoundCAP.draw();
  
  //image(scene1, 0, 0);
  
  

}


//void movieEvent(Movie m) {
//  m.read();
//}
void myEoS() {
  ended = true;
}