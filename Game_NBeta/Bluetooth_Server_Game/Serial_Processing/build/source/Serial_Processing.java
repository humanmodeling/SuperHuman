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

public class Serial_Processing extends PApplet {

//Libraries



//Objects
Serial myPort;  // Create object from Serial class
StopWatchTimer sw;
ControlP5 cp5;
Knob myKnobA;

//orbe variables Color
int r = 186;
int g = 255;
int b = 201;

//Serial variables
int val;     // Data received from the serial port
int valor = 0;

//Timer variables
float a = 0;
//knob Variables
int life = 100;
int background_death = color(0, 160, 100);

//Watch Variables
int s = second();
int m = minute();
int h = hour();
String t;

//Objects
PImage logo;
PFont title;

public void setup() {
        
        frameRate(120);
        //Watch setup
        sw = new StopWatchTimer();
        sw.start();
        //New cp5 constructor
        cp5 = new ControlP5(this);
        myKnobA = cp5.addKnob("Life")
                  .setViewStyle(3)
                  .setRange(0,100)
                  .setValue(life)
                  .setPosition(78,250)
                  .setRadius(120)
                  .hideTickMarks()
                  .setNumberOfTickMarks(20)
                  .setTickMarkLength(8)
                  .setTickMarkWeight(3)
                  .snapToTickMarks(true)
                  .setColorForeground(color(186,255,201,191))
                  .setColorBackground(background_death)
                  //.setColorActive(color(255,255,0))
                  .setDragDirection(Knob.VERTICAL)
        ;
        //Color of the background
        background(0xffB28DFF);
        //Setup font
        title = loadFont("Dialog-48.vlw");
        textFont(title);
        //Open the port
        String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 115200);
}

public void draw() {
        background(0xffB28DFF);
        //logo of laboratory
        logo = loadImage("Images/logo.png");
        image(logo, 966,620,268,95);
        //Title of the game
        fill(255);
        text("BlazerMuscle",470,70);
        //Name of the team
        fill(255);
        text("Team Roger One",430,120);
        //Show the watch
        watch();
        //show the player one
        life_one();
        //Check if the player was shooted
        Serial_life();

}

public void watch() {
        fill(255);
        textSize(48);
        text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 20, 700);
}

public void life_one() {
        text("Kishishita", 85, 200);
        //Generate the ellipse above the name
        if(life > 0) {
                noStroke();
                r = 69;
                g = 252;
                b = 131;
                fill(r, g, b);
                ellipse(200, 120, frameCount%50, frameCount%50);
        }
        /*if((life <= 13) && (life > 5)) {
          //If the user end the game change the color to yellow
          fill(255,247,77);
          ellipse(200, 120, frameCount%50, frameCount%50);
          background_death = color(255,247,77);
          myKnobA.setColorBackground(background_death);
        } */else {
                //If the user end the game change the color to red
                fill(255,35,1);
                ellipse(200, 120, frameCount%50, frameCount%50);
                background_death = color(255,35,1);
                myKnobA.setColorBackground(background_death);
        }
}

public void Serial_life(){
        if(myPort.available() > 0)
        { // If data is available,
                valor = myPort.read(); // read it and store it in val
                println(valor);
                if (valor == 100) {
                        life = life - 5;
                        fill(255,35,1);
                        ellipse(200,120, frameCount%100, frameCount%100);
                        fill(255,35,1);
                        text("Kishishita",85,200);
                        myKnobA.setValue(life);
                }
        }
}
class StopWatchTimer {
  int startTime = 0, stopTime = 0;
  boolean running = false; 
  public void start() {
    startTime = millis();
    running = true;
  }
  public void stop() {
    stopTime = millis();
    running = false;
  }
  public int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    }
    else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  public int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  public int minute() {
    return (getElapsedTime() / (1000*60)) % 60;
  }
  public int hour() {
    return (getElapsedTime() / (1000*60*60)) % 24;
  }
}
  public void settings() {  size(1240,720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Serial_Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
