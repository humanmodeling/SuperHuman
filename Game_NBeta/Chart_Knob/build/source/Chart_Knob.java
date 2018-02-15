import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Chart_Knob extends PApplet {

//Libraries



//Objects
ControlP5 cp5;
Serial myPort;  // Create object from Serial class
Knob myKnobA;

//Variables
int myColorBackground = color(0,0,0);
String val;

public void setup() {
  
  
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

public void draw() {
  background(myColorBackground);
  fill(250);
  Serial_read();
}

public void Serial_read(){
if(myPort.available() > 0)
{  // If data is available,
val = myPort.readStringUntil('\n');         // read it and store it in val
}
if(val == "1")  {
  println(val); //print it out in the console
  myKnobA.setValue(50);break;
}

}
  public void settings() {  size(700,400);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Chart_Knob" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
