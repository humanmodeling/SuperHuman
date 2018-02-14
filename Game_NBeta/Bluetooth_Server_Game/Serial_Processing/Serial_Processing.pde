import processing.serial.*;

Serial myPort;  // Create object from Serial class
StopWatchTimer sw;

//Serial variables
String val;     // Data received from the serial port
float a = 0;  

//Watch Variables
int s = second();
int m = minute();
int h = hour();
String t;

//Objects
PImage logo;
PFont title;

void setup() {
  size(1240,720);
  frameRate(30);
  //Setup font
  title = loadFont("Dialog-48.vlw");
  textFont(title);
  //Watch
  //Open the port
  //String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  //myPort = new Serial(this, portName, 38400);
  //print(myPort);
  //while (a < 5000) {         // cycle of 3 seconds duration, during this time
  //a = millis ();}            // you need to press the RESET buttom.
}

void draw() {
  logo = loadImage("Images/logo.png");
  background(#27516A);
  image(logo, 966, 620, 268, 95);
  fill(255);
  text("BlazerMuscle", 470, 70); 
  watch();
  
}

void watch() {
  //s = second();
  //m = minute();
  //h = hour();
  //t = h + ":" + nf(m, 2) + ":" + nf(s, 2);
  
  textSize(48);
  text (t, 20, 700);
}