//Libraries
import processing.serial.*;
import controlP5.*;
import gohai.glvideo.*;

//General objects
Serial myPort;
StopWatchTimer sw;
//Player one objects
ControlP5 cp5_one;
Knob myKnobA;
Slider Shoots_One_Slider;
GLCapture video;

PImage prevFrame;

//Motion variables

float threshold = 150;
int Mx = 0;
int My = 0;
int ave = 0;
 
int ballX = width/8;
int ballY = height/8;
int rsp = 5;

//Serial store variable
int serialuniversalvalue = 0;

//Player one
//Player one knob Variables
int life_PO = 10;
int background_death_one = color(0, 160, 100);
//Slider player one variables Shoot
int sliderValue_ShootOne = 0;
//Special weapon Variables
String IROne_empty = "Yes";
String IROne_charged = "No";
String IROne_shotted = "No";
//Activation variables for player one
String flag_one = "No";
String activation_one = "No";

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
        size(800,600, P2D);
        //frameRate(120);
        //Setup font
        title = loadFont("Dialog-28.vlw");
        life_title = loadFont("Dialog-20.vlw");
        textFont(title);
        //Watch setup
        sw = new StopWatchTimer();
        sw.start();
        //New cp5_one Knob constructor for player one
        cp5_one = new ControlP5(this);
        myKnobA = cp5_one.addKnob("Life")
                  .setFont(life_title)
                  .setViewStyle(3)
                  .setRange(0,10)
                  .setValue(life_PO)
                  .setPosition(25,250)
                  .setRadius(120)
                  .hideTickMarks()
                  .setNumberOfTickMarks(20)
                  .setTickMarkLength(8)
                  .setTickMarkWeight(3)
                  .snapToTickMarks(true)
                  .setColorForeground(color(186,255,201,191))
                  .setColorBackground(background_death_one)
                  //.setColorActive(color(255,255,0))
                  .setDragDirection(Knob.VERTICAL)
        ;
        //New cp5_one Slider constructor
        Shoots_One_Slider = cp5_one.addSlider("Shoots")
                            .setFont(life_title)
                            .setRange(0,30)
                            //.setNumberOfTickMarks(10)
                            //.setColorTickMark(220)
                            .setValue(sliderValue_ShootOne)
                            .setPosition(285,240)
                            //Because is deprecated it only accept hex values
                            .setColorForeground(#0CB7F2)
                            .setColorValue(#FFFFFF)
                            .setColorLabel(#FFFFFF)
                            .setSize(40,250)
        ;
	// Motion setup
	String[] devices = GLCapture.list();
  	println("Devices:");
  	printArray(devices);
  	if (0 < devices.length) {
    		String[] configs = GLCapture.configs(devices[0]);
    		println("Configs:");
    		printArray(configs);
	}
	//video = new Capture(this, width, height, 30);
  	video = new GLCapture(this, devices[0], 320, 240, 5);
  	video.start();
  	prevFrame = createImage(320, 240, RGB);
        //Color of the background
        background(#B28DFF);
        //Open the port
        String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 115200);
        myPort.buffer(3);
}

void draw() {
        //Set the background of the game
        Game_BackGround();
        //Show the watch
        Watch();
        //Read the incoming data of the serial port
        Serial_Read_Data();
        if(flag_one == "Yes") {
                //Check for player one
                Serial_Event_PlayerOne();
                //Show events life for player one
                Player_One();
        } else {
                textFont(title);
                fill(#FFFFFF);
                text("Disconnected",55,210);
                noStroke();
                fill(255,35,1);
                ellipse(143,150,40,40);
        }
	
	motion();
        
}

void motion() {
	if (video.available()) {
    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); 
    prevFrame.updatePixels();
    video.read();
  }
  //image(video, 0, 0, width, height);
 
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
 
  Mx = 0;
  My = 0;
  ave = 0;
 
 
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
 
      int loc = x + y*video.width;            
      color current = video.pixels[loc];      
      color previous = prevFrame.pixels[loc]; 
 
 
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);
 
 
      if (diff > threshold) { 
        pixels[loc] = video.pixels[loc];
        Mx += x;
        My += y;
        ave++;
      } 
      else {
 
        pixels[loc] = video.pixels[loc];
      }
    }
  }
  fill(255);
  rect(0, 0, width, height);
  if (ave != 0) { 
    Mx = Mx/ave;
    My = My/ave;
  }
  if (Mx > ballX + rsp/2 && Mx > 50) {
    ballX+= rsp;
  }
  else if (Mx < ballX - rsp/2 && Mx > 50) {
    ballX-= rsp;
  }
  if (My > ballY + rsp/2 && My > 50) {
    ballY+= rsp;
  }
  else if (My < ballY - rsp/2 && My > 50) {
    ballY-= rsp;
  }
 
  updatePixels();
  noStroke();
  fill(0, 0, 255);
  ellipse(ballX, ballY, 20, 20);
}

void Game_BackGround() {
        background(#B28DFF);
        //logo of laboratory
        logo = loadImage("Images/logo.png");
        image(logo, 20,20,248,75);
        //Title of the game
        fill(255);
        textFont(title);
        text("BlazerMuscle",335,40);
        //Name of the team
        fill(255);
        textFont(title);
        text("Team Roger One",305,90);
}

void Watch() {
        fill(255);
        textFont(title);
        text("TIMER",660,40);
        text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2),642,70);
}

void Serial_Read_Data() {
        if(myPort.available() > 0) {
                serialuniversalvalue = myPort.read(); // read it and store it in val
                if(activation_one == "No") {
                        println(serialuniversalvalue);
                        if(serialuniversalvalue == 79) {
                                flag_one = "Yes";
                                activation_one = "Yes";
                        }
                }
                
        }
}

void Serial_Event_PlayerOne(){
        //This is equal to one point because laser impact
        if(serialuniversalvalue == 1) {
                life_PO = life_PO - 1;
                myKnobA.setValue(life_PO);
                serialuniversalvalue = 0;
        }
        //This is equal to five points because IR impact
        if(serialuniversalvalue == 2) {
                life_PO = life_PO - 5;
                myKnobA.setValue(life_PO);
                serialuniversalvalue = 0;
        }
        //This will count 1 if the user shoot the laser gun
        if(serialuniversalvalue == 3) {
                sliderValue_ShootOne = sliderValue_ShootOne + 1;
                Shoots_One_Slider.setValue(sliderValue_ShootOne);
                serialuniversalvalue = 0;
        }
        //This will show if the special gun was charged
        if(serialuniversalvalue == 4) {
                IROne_empty = "No";
                IROne_charged = "Yes";
                serialuniversalvalue = 0;
        }
        //This will show if the special weapon was shotted
        if(serialuniversalvalue == 5) {
                IROne_charged = "No";
                IROne_shotted = "Yes";
                sliderValue_ShootOne = sliderValue_ShootOne + 1;
                Shoots_One_Slider.setValue(sliderValue_ShootOne);
                serialuniversalvalue = 0;
        }
}

void Player_One() {
        textFont(title);
        fill(#FFFFFF);
        text("Kishishita", 85, 210);
        //Generate the ellipse above the name
        if(life_PO > 5) {
                noStroke();
                fill(69,252,131);
                ellipse(143,150,40,40);
        }
        if((life_PO <= 5) && (life_PO > 0)) {
                //If the user end the game change the color to yellow
                noStroke();
                fill(255,247,77);
                ellipse(143,150,40,40);
                background_death_one = color(255,247,77);
                myKnobA.setColorForeground(#794DFF);
                myKnobA.setColorBackground(background_death_one);
                myKnobA.setColorValueLabel(#05A73F);
        }
        if (life_PO <= 0) {
                //If the user end the game change the color to red
                noStroke();
                fill(255,35,1);
                ellipse(143,150,40,40);
                background_death_one = color(255,35,1);
                myKnobA.setColorBackground(background_death_one);
                myKnobA.setColorValue(255);
        }
        if(IROne_empty == "Yes") {
                //Red indicate that the Special Weapon is not loaded
                noStroke();
                fill(0,112,184);
                ellipse(90,560,40,40);
                textFont(life_title);
                text("Special Weapon",122,567);
        }
        if(IROne_charged == "Yes") {
                noStroke();
                fill(#0F34FA);
                ellipse(90,560,40,40);
                textFont(life_title);
                text("Special Weapon Loaded",122,567);
        }
        if(IROne_shotted == "Yes") {
                IROne_shotted = "No";
                noStroke();
                fill(#12FA0F);
                rect(90,560,100,50);
                textFont(life_title);
                text("Special Weapon Shooted",122,567);
                IROne_empty = "Yes";
        }
}