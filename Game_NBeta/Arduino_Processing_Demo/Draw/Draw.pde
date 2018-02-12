import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
float a = 0;


void setup () {
  size(1280,640);
  background(120);
  String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 38400);
  while (a < 5000) {         // cycle of 3 seconds duration, during this time
  a = millis ();}            // you need to press the RESET buttom.
  
}

void draw() {
  if ( myPort.available() > 0) 
  {  // If data is available,
  val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  println(val); //print it out in the console
  
  noFill();
  ellipse(56, 46, 200, 200);
}