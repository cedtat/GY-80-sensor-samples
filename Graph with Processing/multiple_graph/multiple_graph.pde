/* 
 // Graphing sketch
 
 // This program takes ASCII-encoded strings
 // from the serial port at 9600 baud and graphs them. It expects 3 values separated by a comma in the
 // range you defined defined between minValue and maxValue, followed by a newline, or newline and carriage return
 // then it draws 3 graph in the window
 
 // by Cédric Tatangelo
 // This example code is in the public domain.
 */

import processing.serial.*;
 
 Serial myPort;        // The serial port
 int xPos = 1;         // horizontal position of the graph
 int minValue = 230;   // Choose min value received through serial port
 int maxValue = 282;   // Choose max value received through serial port
 
 void setup () {
 // set the window size:
 size(400, 300);        
 
 // List all the available serial ports
 // println(Serial.list());
 
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[0], 9600);
 
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 
 // set inital background:
 background(0);
 }
 
 void draw () {
 // everything happens in the serialEvent()
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
 
   // trim off any whitespace:
 inString = trim(inString);
 String[] list = split(inString, ',');
 
 // convert to an int and map to the screen height:
 float inByte1 = float(list[0]); 
   inByte1 = map(inByte1, minValue, maxValue, 0, 100);
   
 float inByte2 = float(list[1]); 
   inByte2 = map(inByte2, minValue, maxValue, 0, 100);
   
  float inByte3 = float(list[2]); 
   inByte3 = map(inByte3, minValue, maxValue, 0, 100);
 
 // draw the line:
 stroke(127,34,255);
 line(xPos, 100, xPos, 100 - inByte1);
 
 stroke(255,34,255);
 line(xPos, 200, xPos, 200 - inByte2);
 
 stroke(127,255,255);
 line(xPos, 300, xPos, 300 - inByte3);
 
 // at the edge of the screen, go back to the beginning:
 if (xPos >= width) {
 xPos = 0;
 background(0); 
 } 
 else {
 // increment the horizontal position:
 xPos++;
 }
 }
 }
 
