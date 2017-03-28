import processing.sound.*;
import processing.video.*;

Movie scene1;
int scene_1_time = 55; 
boolean scean_1_INIT;

SoundCAP_main mainsoundCAP;
boolean ended;
boolean scene_2_INIT;
public int RUNTIME;
void setup() {
  fullScreen();

  scean_1_INIT = true;
  scene_2_INIT = true;
  RUNTIME = 0;
}


void draw() {
  //if (!ended)  image(scene1, 0, 0);
  //else {
  //  mainsoundCAP.draw();
  //}
  switch(RUNTIME) {
  case 0:
    if(scean_1_INIT){
      scene1 = new Movie(this, "video/1AuthenticnoVDOintro.mp4");
      scene1.noLoop();
      scean_1_INIT = false;
      println("RUN INIT");
    }
    
    image(scene1, 0, 0);
    
    if(scene1.time() >= scene1.duration()) {
      scene1.stop();
      scene1.dispose();
      RUNTIME=1;
      println("RUN DELETE");
    }
    break;
  case 1:
    if(scene_2_INIT){
      mainsoundCAP = new SoundCAP_main();
      scene_2_INIT = false;
    }
    mainsoundCAP.draw();
    if(mainsoundCAP.time == 0){
      RUNTIME = 2;
    }
    break;
   }
  
  

}


void movieEvent(Movie m) {
  m.read();
}