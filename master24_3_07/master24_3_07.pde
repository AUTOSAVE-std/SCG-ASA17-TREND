import processing.video.*;
Movie myMovie;

void setup() {
  fullScreen();
  myMovie = new Movie(this, "video/1AuthenticnoVDOintro.mp4");
  myMovie.play();
}

void draw() {
  image(myMovie, 0, 0);
  myMovie.noLoop();
}

void movieEvent(Movie m) {
  m.read();
  
}