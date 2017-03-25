import processing.sound.*;

float angle, lastAngle;
float r, d, h;

float currentTime;
float fullCircleTime;

color bgc;
color fillTimeLapsed; 
 

float traceAlpha;

int cycleCount;
int cycleCounterGap;
int cycleCountDiameter;
int maxCounterAmount;
  
Amplitude amp;
AudioIn in;

void setup() {
  size(600,600);
  
  angle = 0;
  lastAngle = 0;
  d = int(width*0.618);
  d = makeEvenRoundUp(d);
  r = d/2;
  
  fullCircleTime = 4000;
  
  bgc = color(255);
  fillTimeLapsed = color(153, 64, 188); 

 
   
  cycleCount = 0;
  cycleCounterGap = 40;

  maxCounterAmount = (width / cycleCounterGap) - 1;
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}


void draw() {
  background(bgc);
  pushMatrix();
  translate(width/2,height/2);
  rotate(-HALF_PI);
  
  noStroke();
  fill(fillTimeLapsed);
  arc(0,0, d,d, 0,angle);
  popMatrix();
  
  lastAngle = angle;
  
  ///currentTime = random(4000)
  
  float h = map(amp.analyze(), 0, 1, 0, 4000);
  currentTime = h;
  angle = (currentTime/fullCircleTime) * TWO_PI;
  angle %= TWO_PI;
  
}




int makeEvenRoundUp(float number) {
  if( number%2 != 0 ){ number+=1; }
  return int(number);
}