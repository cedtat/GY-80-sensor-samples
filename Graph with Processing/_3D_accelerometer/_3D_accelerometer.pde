// Original source here for explanation : http://codeyoung.blogspot.fr/2009/11/adxl345-accelerometer-breakout-board.html
// Simply feed Serial port with Xout, Yout, Zout from ADXL345
// this sketch will create a 3D view of your component 

import processing.opengl.*;
import processing.serial.*;

Serial sp;
float[] r;

int SIZE = 150, SIZEX = 200;
int OFFSET_X = -28, OFFSET_Y = 9;    //These offsets are chip specific, and vary.  Play with them to get the best ones for you

void setup() {
  size(SIZEX, SIZE, P3D);
  
 //new  
 sp = new Serial(this, Serial.list()[0], 9600);
  
  r = new float[3];
  
   // don't generate a serialEvent() unless you get a newline character:
 sp.bufferUntil('\n');
}

float protz, protx;
void draw() {
  
}

void serialEvent (Serial myPort) {
  
  String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
 
   // trim off any whitespace:
   inString = trim(inString);
 
 //perspective( 45, 4.0/3.0, 1, 5000 );
  translate(SIZEX/2, SIZE/2, -400);
  background(0);
  buildShape(protz, protx);
  
  
      setVals(r, inString);
    
    float z = r[0], x = r[1];
    if(abs(protz - r[0]) < 0.05)
      z = protz;
     if(abs(protx - r[1]) < 0.05)
     x = protx;
    background(0);  
    buildShape(z, x);
    
     protz = z;     
     protx = x;
    println(r[0] + ", " + r[1] + ", " + r[2]);
    
 }
  
}

void buildShape(float rotz, float rotx) {
  pushMatrix();
  scale(6,6,14);
  rotateZ(rotz);
    rotateX(rotx);
    fill(255);
     stroke(0);
     box(60, 10, 10);
     fill(0, 255, 0);
     box(10, 9, 40);
     translate(0, -10, 20);
     fill(255, 0, 0);
     box(5, 12, 10);  
  popMatrix();
}

void setVals(float[] r, String s) {
  int i = 0;
  r[0] = -(float)(Integer.parseInt(s.substring(0, i = s.indexOf(","))) +OFFSET_X)*HALF_PI/256;
  r[1] = -(float)(Integer.parseInt(s.substring(i+1, i = s.indexOf(",", i+1))) + OFFSET_Y)*HALF_PI/256;
  r[2] = (float) Integer.parseInt(s.substring(i+1));
  
  
}
