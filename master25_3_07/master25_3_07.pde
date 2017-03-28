/*
  SCG-ASA-17
  Installation at SCG ASA EXPO for Trend booth
  
  Extra : WEBCAM with MIC attached to you damn computer 
  
  modified 25 MARCH 2017 for SCG ASA EXPO - TREND INSALLATION
  by Chawanan Inkumnoi 
  
 █████╗ ██╗   ██╗████████╗ ██████╗ ███████╗ █████╗ ██╗   ██╗███████╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔════╝██╔══██╗██║   ██║██╔════╝
███████║██║   ██║   ██║   ██║   ██║███████╗███████║██║   ██║█████╗  
██╔══██║██║   ██║   ██║   ██║   ██║╚════██║██╔══██║╚██╗ ██╔╝██╔══╝  
██║  ██║╚██████╔╝   ██║   ╚██████╔╝███████║██║  ██║ ╚████╔╝ ███████╗
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝
studio.
xx                             
*/

//AUTHENTIC = AUT   - [CHECKED]
//BioSMART = Bio    - [ ]
//ECOFICIENT = ECO  - [ ]
//INFLUENCE = INF   - [ ]

import processing.sound.*;
import processing.video.*;
import processing.serial.*;

Serial LightPort;
int colorR=184;
int colorG=62;
int colorB=0;
final int LOUNDESTDB           = 110;
final int LOUNDEST_AIRCON_DB   = 60;
final int LOUNDEST_suck_DB     = 70;
final int LOUNDEST_blender_DB  = 80;
final int LOUNDEST_motobike_DB = 90;
final int LOUNDEST_lanmover_DB = 100;


Movie scene1;
float scene_1_time = 47; 
boolean scean_1_INIT;

Movie scene2; //AUTO06
float scene_2_time = 5; 

Movie scene3; //AUTO09
float scene_3_time = 5; 

//Movie scene3; //AUTO09
//float scene_3_time = 5; 
boolean Resault;
Movie passsound = new Movie(this, "video/AUT03.mp4"); //
float passsound_s = 5; 

Movie pass_AIRCON = new Movie(this, "video/AUT08.mp4"); //
float pass_AIRCON_s = 5; 

Movie pass_suck = new Movie(this, "video/AUT09.mp4"); //
float pass_suck_s = 5;  

Movie pass_blender = new Movie(this, "video/AUT10.mp4"); //
float pass_blender_s = 5; 

Movie pass_motobike = new Movie(this, "video/AUT11.mp4"); //
float pass_motobike_s = 5; 

Movie pass_lanmover = new Movie(this, "video/AUT12.mp4"); //
float pass_lanmover_s = 5; 

float publicDB;
SoundCAP_main mainsoundCAP;
boolean ended;
boolean scene_2_INIT;
public int RUNTIME;
void setup() {
  fullScreen();
  //fullScreen(JAVA2D); // fast with set() and background()
  String portName = Serial.list()[3];
  LightPort = new Serial(this, portName, 9600);
  
  scean_1_INIT = true;
  scene_2_INIT = true;
  Resault = true;
  RUNTIME = 0;
  publicDB = 0;
}


void draw() {
  switch(RUNTIME) {
    
  /////////////////////// START RUNNING Clip 1, DAMN
  case 0:
    if(scean_1_INIT){
      scene1 = new Movie(this, "video/AUT01.mp4");
      scene1.play();
      scean_1_INIT = false;
      println("RUN INIT");
      LightPort.write(colorR+","+colorG+","+colorB);
    }
    /////////////////////////// RUN Clip
    image(scene1,0, 0);
    ///////////////////////////
    if(scene1.time() >= scene_1_time) {
      scene1.stop();
      scene1.dispose();
      RUNTIME=1;
      println("RUN DELETE");
    }
    break;
    
  /////////////////////// START MERSERING SOUND HERE YOU FOOL.
  case 1:
    if(scene_2_INIT){
      mainsoundCAP = new SoundCAP_main();
      scene_2_INIT = false;
    }
    mainsoundCAP.draw();
    if(mainsoundCAP.time == 0){
      publicDB = mainsoundCAP.maximumDB;
      mainsoundCAP = null;
      RUNTIME = 2;
    }
    break;
    
  /////////////////////// TAKE OR NOT TAKE PHOTO
  case 2:
    background(0,255,0);
    if(publicDB >= LOUNDESTDB){
      passsound.play();
      scean_1_INIT = false;
    } else if(publicDB >= LOUNDEST_lanmover_DB ) {
      pass_lanmover.play();
      scean_1_INIT = false;
    } else if(publicDB >= LOUNDEST_motobike_DB ) {
      pass_motobike.play();
      scean_1_INIT = false;
    } else if(publicDB >= LOUNDEST_blender_DB ) {
      pass_blender.play();
      scean_1_INIT = false;
    } else if(publicDB >= LOUNDEST_suck_DB ) {
      scene1.play();
      scean_1_INIT = false;
    } else {
      pass_suck.play();
      scean_1_INIT = false;
    } 
  
  }
  
  

}


void movieEvent(Movie m) {
  m.read();
}