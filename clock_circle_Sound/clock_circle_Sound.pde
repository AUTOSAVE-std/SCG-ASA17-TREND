import processing.sound.*;
// CHANGE VALUE FOR EACH MODEL
color fontcolorDB = color(255, 204, 0);
color fontcolorSecound = color(255, 204, 0);
float[] smooth= new float[10];
color bgc = color(255);
color fillTimeLapsed = color(153, 64, 188); 

// UN CHANGE
float angle, lastAngle;
float d, h;
int maximumDB = 0;

// Circle
float currentTime;
float fullCircleTime;

// Time countdown
int begin = millis(); 
int duration = 20;
int time = 20;
 

Amplitude amp;
AudioIn in;

void setup() {
  fullScreen();
  // sound start
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  //init smooth val
  for ( int i = 0; i < smooth.length; ++i ){smooth[i] = 0;}
  
  angle = 0;
  lastAngle = 0;
  d = int(width*0.418);
  d = makeEvenRoundUp(d);
  fullCircleTime = 4000;

}


void draw() {
  background(bgc);
  pushMatrix();
  translate(width/2,height/2-200);
  rotate(PI/1.15);
  
  noStroke();
  fill(fillTimeLapsed);
  arc(0,0, d,d, 0,angle);
  popMatrix();
  
  lastAngle = angle;
  
  ///currentTime = random(4000)
  
  float h = map(amp.analyze(), 0, 1, 0, 4000);
  currentTime = smoothsound(h);
  angle = (currentTime/fullCircleTime) * TWO_PI;
  angle %= TWO_PI;
  textSize(32);
  text(currentTime, width/2-50,height/2-200);
  if (time > 0)  time = duration - (millis() - begin)/1000;
  text(time,  width/2-50,height/2);
  text(maximumDB,  width/2-50,height/2+300);
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