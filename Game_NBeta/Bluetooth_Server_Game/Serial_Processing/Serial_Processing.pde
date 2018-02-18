//Libraries
import processing.serial.*;
import controlP5.*;

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

void setup() {
        size(1240,720);
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
                            .setColorForeground(#0CB7F2)
                            .setColorValue(#FFFFFF)
                            .setColorLabel(#FFFFFF)
                            .setSize(40,250)
        ;

        //Color of the background
        background(#B28DFF);
        //Open the port
        String portName = Serial.list()[5]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 115200);
        myPort.buffer(3);
}

void draw() {
        background(#B28DFF);
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
        //Serial_Read
        Serial_Read_Data();
        //Check for player one
        Serial_PlayerOne();
        //show events life for player one
        life_one();
}

void watch() {
        fill(255);
        textSize(48);
        text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 20, 700);
}

void Serial_Read_Data() {
        if(myPort.available() > 0)
        {
                serialuniversalvalue = myPort.read(); // read it and store it in val
                println(serialuniversalvalue);
        }
}

void Serial_PlayerOne(){
        if (serialuniversalvalue == 1) {
                life_PO = life_PO - 5;
                fill(255,35,1);
                ellipse(200,120, frameCount%100, frameCount%100);
                fill(255,35,1);
                text("Kishishita",85,200);
                myKnobA.setValue(life_PO);
                serialuniversalvalue = 0;
        }
        if (serialuniversalvalue == 2) {
                sliderValue_ShootOne = sliderValue_ShootOne + 1;
                Shoots_One_Slider.setValue(sliderValue_ShootOne);
                serialuniversalvalue = 0;

        }
}

void life_one() {
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
                myKnobA.setColorForeground(#794DFF);
                myKnobA.setColorBackground(background_death);
                myKnobA.setColorValueLabel(#05A73F);
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
