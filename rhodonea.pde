import controlP5.*;
import processing.pdf.*;
boolean record;
/* 
 In mathematics, a rose or rhodonea curve 
 is a sinusoid plotted in polar coordinates.
 */
ControlP5 cp5;


float r = 250;
float petalLen;
int resolution = 720;
float theta;
float x;
float y;
float k;
float n = 20;
float d = 18;
float c = 0;


int index = 0;
float animationVal1;

void setup() {
  //fullScreen();
  size(1080, 720);

  cp5 = new ControlP5(this);


  cp5.addSlider("r")
    .setLabel("RADIUS")
    .setPosition(20, 20)
    .setRange(20, 800)
    ;

  cp5.addSlider("n")
    .setLabel("n Value")
    .setPosition(20, 32)
    .setRange(0, 50)
    .setNumberOfTickMarks(51);

  cp5.addSlider("d")
    .setLabel("d Value")
    .setPosition(20, 44)
    .setRange(0, 100)
    .setNumberOfTickMarks(51);

  cp5.addSlider("c")
    .setLabel("Offset Value")
    .setPosition(20, 56)
    .setRange(0, 10)
    ;
}


void draw() {
  
  //animationVal1 = sin(millis()*0.001)*d;
  animationVal1 = d;
  
  if (record == true) {
    // Note that #### will be replaced with the frame number. Fancy!
    beginRecord(PDF, "rhodonea.pdf");
  }

  background(0);
  pushMatrix();
  translate(width*0.5, height*0.5);
  //fill(255);
  noFill();
  stroke(255);

  k = n / d;

  beginShape();
  for (int i = 0; i < resolution; i++) {

    theta = map(i*ceil(animationVal1), 0, resolution, 0, TWO_PI);
   
    petalLen = sin(n*theta);

    petalLen = cos(k*theta) + c;
    x = r * petalLen * cos(theta);
    y = r * petalLen * sin(theta);
    point(x,y);
    vertex(x,y);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();

  if (record == true) {
    endRecord();
    record = false;
  }
  
  if(frameCount % 25 == 0) {
      //println(frameCount);
      //saveFrame(str(index) + "-output.gif");
      index = index + 1;
  }
}

// Use a keypress so thousands of files aren't created
void mousePressed() {
  record = true;
}