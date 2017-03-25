import processing.sound.*;

// CHANGE VALUE FOR EACH MODEL
color fontcolorDB =         color(255, 204, 0);
color fontcolorSecound =    color(255, 204, 0);
float[] smooth=             new float[10];
int maxcamdb = 2800;
color fillTimeLapsed =      color(216, 127, 96); 
color fillTimecoundown =    color(43, 105, 107); 
// UN CHANGE
float angle, lastAngle;
float d, h;
int maximumDB = 0;
int passmaxDB = 2750;
int _db = 0;
// Circle
float currentTime;
float fullCircleTime;

// Time countdown
int begin = millis(); 
int duration = 20;
int time = 20;
// font 
PFont font, font2;

//Element
PImage bg;
PImage level;
PImage knob;
PImage knob_shadow;
PImage lound;
PImage lounder;
Amplitude amp;
AudioIn in;

void setup() {
  fullScreen();
  
  // sound start
  amp =   new Amplitude(this);
  in =    new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  
  bg =             loadImage("BG-01.png");
  level =          loadImage("level.png");
  knob =           loadImage("level0.png");
  knob_shadow =    loadImage("level2.png");
  lound =          loadImage("lounder.png");
  lounder =        loadImage("lounderand.png");
  
  font =   loadFont("SCG-Bold-200.vlw");
  font2 =  loadFont("SCG-Bold-32.vlw");
  
  //init smooth val
  for ( int i = 0; i < smooth.length; ++i ){smooth[i] = 0;}
  
  angle = 0;
  lastAngle = 0;
  d = int(width*0.418);
  d = makeEvenRoundUp(d);
  fullCircleTime = 4000;

}


void draw() {

  background(bg);
  
  //Level image here
  image(level,width/2-233,height/2-443);
  
  // Rotate Circle
  pushMatrix();
  translate(width/2,height/2-200);
  rotate(PI/1.25);
  
  // Cycle
  noStroke();
  fill(fillTimeLapsed);
  arc(0,0, d,d, 0,angle);
  popMatrix();
  
  //KNOB position
  image(knob_shadow,width/2-207,height/2-407);
  pushMatrix();
  translate(width/2,height/2-200);
  ellipse(0,0,10,10);
  rotate(map(currentTime,0,maxcamdb,0,4.5));
  image(knob,-206,-205);
  popMatrix();

  lastAngle = angle;
  
  float h = map(amp.analyze(), 0, 0.9, 0, maxcamdb);
  // maximum is maxcamdb 2500
  currentTime = smoothsound(h);
  _db = (int)map( currentTime , 0, maxcamdb, 0, 120 );;
  angle = (currentTime/fullCircleTime) * TWO_PI;
  angle %= TWO_PI;
  
// FONT DB current
  textFont(font, 100);
  
  // 100+
  if(_db >= 99){ text(_db, width/2-75,height/2-170); }
  // 1-9
  else if(_db <= 9) {text(_db, width/2-35,height/2-170);}
  // 10-99
  else text(_db, width/2-50,height/2-170);
  
  textFont(font2, 32);
  text("dB", width/2-20,height/2-120);

/////////////////////////////////////////////// LOWER PART
// FONT sec.
  fill(fillTimecoundown);
  if (time > 0)  time = duration - (millis() - begin)/1000;
  if (time<10){
    textFont(font, 200);
    text(time, width/2-50, height/2+450);
    textFont(font2, 32);
    text("sec", width/2+80, height/2+450);
  }
  else{
    textFont(font, 200);
    text(time,  width/2-90,height/2+450);
    textFont(font2, 32);
    text("sec",  width/2+110,height/2+450);
  }
  
// IF SOUND LOWER
  if (time <= 10 && time >= 9 && maximumDB <= passmaxDB) {image(lound, width/2-200,height/2+100);}
  if (time <= 5 && time >= 4 && maximumDB <= passmaxDB) {image(lounder,width/2-200,height/2+100);}




//debug max DB  
  textFont(font, 20);
  text(maximumDB,  200, 200);
  stroke(20);
  line(width/2, 0, width/2, height);
}

float smoothsound(float s_new) {
  for(int i=0; i<=(smooth.length-2);i++) {smooth[i] = smooth[i+1];}
  smooth[smooth.length-1] = s_new;
  if(s_new>=maximumDB){maximumDB=(int)s_new;} 
  float average = 0;
  for ( int i = 0; i < smooth.length; ++i ){ average += smooth[i]; }
  average /= (float)(smooth.length); 
  return average;
}


int makeEvenRoundUp(float number) {
  if( number%2 != 0 ){ number+=1; }
  return int(number);
}