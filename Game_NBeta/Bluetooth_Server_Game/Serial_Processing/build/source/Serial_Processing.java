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
Serial myPort;
StopWatchTimer sw;
ControlP5 cp5;
Knob myKnobA;
Slider Shoots_One_Slider;

//Player one orbe variables Color
int r = 186;
int g = 255;
int b = 201;

//Serial variables
//Player one
int serialuniversalvalue = 0;

//Player one knob Variables
int life_PO = 100;
int background_death = color(0, 160, 100);

//Slider player one variables Shoot
int sliderValue_ShootOne = 0;

//Watch Variables
int s = second();
int m = minute();
int h = hour();
String t;

//Timer variables
float a = 0;

//Objects for text and logo
PImage logo;
PFont title;
PFont life_title;//knob

public void setup() {
        
        frameRate(120);
        //Setup font
        title = loadFont("Dialog-48.vlw");
        life_title = loadFont("Dialog-20.vlw");
        textFont(title);
        //Watch setup
        sw = new StopWatchTimer();
        sw.start();
        //New cp5 Knob constructor
        cp5 = new ControlP5(this);
        myKnobA = cp5.addKnob("Life")
                  .setFont(life_title)
                  .setViewStyle(3)
                  .setRange(0,100)
                  .setValue(life_PO)
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
        //New cp5 Slider constructor
        Shoots_One_Slider = cp5.addSlider("Shoots")
                            .setFont(life_title)
                            .setRange(0,30)
                            //.setNumberOfTickMarks(10)
                            //.setColorTickMark(220)
                            .setValue(sliderValue_ShootOne)
                            .setPosition(350,240)
                            //Because is deprecated it only accept hex values
                            .setColorForeground(0xff0CB7F2)
                            .setColorValue(0xffFFFFFF)
                            .setColorLabel(0xffFFFFFF)
                            .setSize(40,250)
        ;

        //Color of the background
        background(0xffB28DFF);
        //Open the port
        String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 115200);
        myPort.buffer(3);
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
        //Check for player one
        Serial_PlayerOne();
        //show events life for player one
        life_one();
}

public void watch() {
        fill(255);
        textSize(48);
        text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 20, 700);
}

public void Serial_PlayerOne(){
        if(myPort.available() > 0)
        {
                serialuniversalvalue = myPort.read(); // read it and store it in val
                println(serialuniversalvalue);
                if (serialuniversalvalue == 1) {
                        life_PO = life_PO - 5;
                        fill(255,35,1);
                        ellipse(200,120, frameCount%100, frameCount%100);
                        fill(255,35,1);
                        text("Kishishita",85,200);
                        myKnobA.setValue(life_PO);
                }
                if (serialuniversalvalue == 2) {
                        sliderValue_ShootOne = sliderValue_ShootOne + 1;
                        Shoots_One_Slider.setValue(sliderValue_ShootOne);
                }
        }
}

public void life_one() {
        text("Kishishita", 85, 200);
        //Generate the ellipse above the name
        if(life_PO > 50) {
                noStroke();
                r = 69;
                g = 252;
                b = 131;
                fill(r, g, b);
                ellipse(200, 120, frameCount%70, frameCount%70);
        }
        if((life_PO <= 50) && (life_PO > 0)) {
                //If the user end the game change the color to yellow
                fill(255,247,77);
                ellipse(200, 120, frameCount%50, frameCount%50);
                background_death = color(255,247,77);
                myKnobA.setColorForeground(0xff794DFF);
                myKnobA.setColorBackground(background_death);
                myKnobA.setColorValueLabel(0xff05A73F);
        }
        if (life_PO <= 0) {
                //If the user end the game change the color to red
                fill(255,35,1);
                ellipse(200, 120, frameCount%20, frameCount%20);
                background_death = color(255,35,1);
                myKnobA.setColorBackground(background_death);
                myKnobA.setColorValue(255);
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
