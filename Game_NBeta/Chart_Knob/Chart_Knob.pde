//Libraries
import processing.serial.*;
import controlP5.*;

//Objects
ControlP5 cp5;
Serial myPort;  // Create object from Serial class
Knob myKnobA;

//Variables
int myColorBackground = color(0,0,0);
String val;

void setup() {
  size(700,400);
  smooth();
  noStroke();

  cp5 = new ControlP5(this);

  myKnobA = cp5.addKnob("Life")
               .setRange(0,100)
               .setValue(100)
               .setPosition(100,70)
               .setRadius(120)
               .setNumberOfTickMarks(20)
               .setTickMarkLength(8)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(0, 160, 100))
               .setColorActive(color(255,255,0))
               .setDragDirection(Knob.VERTICAL)
               ;

  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 38400);
}

void draw() {
  background(myColorBackground);
  fill(250);
  Serial_read();
}

void Serial_read(){
if(myPort.available() > 0)
{  // If data is available,
val = myPort.readStringUntil('\n');         // read it and store it in val
}
if(val == "1")  {
  println(val); //print it out in the console
  myKnobA.setValue(50);
}

}
