class SoundCAP_main {

  color fontcolorDB, fontcolorSecound, fillTimeLapsed, fillTimecoundown;
  float[] smooth;
  int maxcamdb, maximumDB, passmaxDB, _db, duration, time;
  float angle, lastAngle, d, h, currentTime, fullCircleTime;
  int begin = millis(); 
  PFont font, font2;
  PImage bg, level, knob, knob_shadow, lound, lounder;
  Amplitude amp;
  AudioIn in;
  SoundFile Slound,Slounder;
  boolean issouldplay1,issouldplay2;
  
  
  SoundCAP_main(){
  bg =             loadImage("img/BG-01.png");
  level =          loadImage("img/level.png");
  knob =           loadImage("img/level0.png");
  knob_shadow =    loadImage("img/level2.png");
  lound =          loadImage("img/lounder.png");
  lounder =        loadImage("img/lounderand.png");
  Slound=          new SoundFile(master25_3_07.this, "sound/lounder1.wav");
  Slounder=        new SoundFile(master25_3_07.this, "sound/lounder2.wav");
  issouldplay1=    false;
  issouldplay2=    false;
  fontcolorDB =         color(255, 204, 0);
  fontcolorSecound =    color(255, 204, 0);
  smooth=               new float[10];
  maxcamdb =            2800;
  fillTimeLapsed =      color(216, 127, 96); 
  fillTimecoundown =    color(43, 105, 107); 
  duration =            20;
  time =                20;
  maximumDB =           0;
  passmaxDB =           2750;
  _db =                 0;
  angle =               0;
  lastAngle =           0;
  d =                   int(width*0.418);
  d =                   makeEvenRoundUp(d);
  fullCircleTime =      4000;
  
  // sound start
  amp =   new Amplitude(master25_3_07.this);
  in =    new AudioIn(master25_3_07.this, 0);
  in.start();
  amp.input(in);
  
  font =   loadFont("SCG-Bold-200.vlw");
  font2 =  loadFont("SCG-Bold-32.vlw");
  
  //init smooth val
  for ( int i = 0; i < smooth.length; ++i ){smooth[i] = 0;}
  

  
  }
  
  void draw(){

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
  if (time <= 10 && time >= 9 && maximumDB <= passmaxDB) {
    image(lound, width/2-200,height/2+100);
    if(!issouldplay1){Slound.play();issouldplay1=!issouldplay1;}
  }
  if (time <= 5 && time >= 4 && maximumDB <= passmaxDB) {
    image(lounder,width/2-200,height/2+100);
    if(!issouldplay2){Slounder.play();issouldplay2=!issouldplay2;}
  }




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
  
  
  
  
}