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
  //Watch setup
  println (millis());
  sw = new StopWatchTimer();
  sw.start();
  //Setup font
  title = loadFont("Dialog-48.vlw");
  textFont(title);
  //Open the port
  //String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
  //myPort = new Serial(this, portName, 38400);
  //print(myPort);
  //while (a < 5000) {         // cycle of 3 seconds duration, during this time
  //a = millis ();}            // you need to press the RESET buttom.
}

void draw() {
  logo = loadImage("Images/logo.png");
  background(#033E3C);
  image(logo, 966, 620, 268, 95);
  fill(255);
  text("BlazerMuscle", 470, 70);
  fill(255);
  text("Team Roger One", 430, 120);
  watch();
  life();
  
}

void watch() {
  fill(255);
  textSize(48);
  text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 20, 700);
}
void life() {
  fill(#959D9D);
  noStroke();
  arc(200, 350, 250, 250, 0, TWO_PI);
  fill(#0B4EB7);
  noStroke();
  arc(200, 350, 250, 250, PI, 2*PI); 
  fill(#E1E2E5);
  text("Life", 160, 530);
}