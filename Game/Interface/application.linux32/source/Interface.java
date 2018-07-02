import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 
import controlP5.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Interface extends PApplet {

//Libraries




//General objects
StopWatchTimer sw;
//Player one objects
ControlP5 cp5_one;
Knob myKnobA;
//Player two Objects
ControlP5 cp5_two;
Knob myKnobB;
//Player three Objects
ControlP5 cp5_three;
Knob myKnobC;
//Player four Objects
ControlP5 cp5_four;
Knob myKnobD;
//Player five Objects
ControlP5 cp5_five;
Knob myKnobE;
//Player six Objects
ControlP5 cp5_six;
Knob myKnobF;
// Declare server objects
Server server;
Client client;
// Sound objects
SoundFile laser_sound;
SoundFile coin_sound;
SoundFile background_music;

// Used to indicate a new message has arrived
float newMessageColor = 0xffffffff;
char incomingMessage = '0';
char value_received = '0';

//Player one
//Player one knob Variables
int life_PO = 5;
int background_death_one = color(0, 160, 100);
//Slider player one variables Shoot
//Activation variables for player one
String flag_one = "Yes";
String activation_one = "No";

//Player two
//Player two knob Variables
int life_PT = 5;
int background_death_two = color(0, 160, 100);
//Slider player one variables Shoot
//Activation variables for player two
String flag_two = "Yes";
String activation_two = "No";

//Player three
//Player three knob Variables
int life_PThree = 5;
int background_death_three = color(0, 160, 100);
//Slider player one variables Shoot
//Activation variables for player three
String flag_three = "Yes";
String activation_three = "No";

//Player four
//Player four knob Variables
int life_PFour = 5;
int background_death_four = color(0, 160, 100);
//Activation variables for player four
String flag_four = "Yes";
String activation_four = "No";

//Player five
//Player five knob Variables
int life_PFive = 5;
int background_death_five = color(0, 160, 100);
//Activation variables for player five
String flag_five = "Yes";
String activation_five = "No";

//Player six
//Player six knob Variables
int life_PSix = 5;
int background_death_six = color(0, 160, 100);
//Activation variables for player five
String flag_six = "Yes";
String activation_six = "No";

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

// Object for players life
Life        lifeC_POne;
Life_Two    lifeC_PTwo;
Life_Three  lifeC_PThree;
Life_Four   lifeC_PFour;
Life_Five   lifeC_PFive;
Life_Six    lifeC_PSix;


public void Game_BackGround() {
  background(0xffB28DFF);
  //logo of laboratory
  //logo = loadImage("Images/logo.png");
  //image(logo, 20, 20, 248, 75);
  ////Title of the game
  fill(255);
  textFont(title);
  text("MuscleBlazer", 1100, 200);
}

public void Watch() {
  fill(255);
  textFont(title);
  text("TIMER", 1170, 50);
  text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 1150, 100);
}

public void WiFi_Read_Data() {
  // If a client is available, we will find out
  // If there is no client, it will be"null"
  client = server.available();
  if (client != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage = client.readChar();
    value_received = incomingMessage;
    println(value_received);
    //delay(20);
  }
}

public void Serial_Event_PlayerOne() {
  //This is equal to one point because laser impact
  if (value_received == 'H') {
    life_PO = life_PO - 1;
    laser_sound.play();
    value_received = '0';
  }
}

public void Player_One() {
  textFont(title);
  fill(0xffFFFFFF);
  text("Player One", 80, 100);
  lifeC_POne.display_one(life_PO);
}

public void Serial_Event_PlayerTwo() {
  //This is equal to one point because laser impact
  if (value_received == 'W') {
    life_PT = life_PT - 1;
    laser_sound.play();
    value_received = '0';
  }
}

public void Player_Two() {
  textFont(title);
  fill(0xffFFFFFF);
  text("Player two", 440, 100);
  lifeC_PTwo.display_two(life_PT);
}

public void Serial_Event_PlayerThree() {
 //This is equal to one point because laser impact
 if (value_received == 'Z') {
   life_PThree = life_PThree - 1;
   laser_sound.play();
   value_received = '0';
 }
}

public void Player_Three() {
 textFont(title);
 fill(0xffFFFFFF);
 text("Player three", 770, 100);
 lifeC_PThree.display_three(life_PThree);
}

public void Serial_Event_PlayerFour() {
 //This is equal to one point because laser impact
 if (value_received == 'P') {
   life_PFour = life_PFour - 1;
   laser_sound.play();
   value_received = '0';
 }
}

public void Player_Four() {
 textFont(title);
 fill(0xffFFFFFF);
 text("Player four", 80, 520);
 lifeC_PFour.display_four(life_PFour);
}

public void Serial_Event_PlayerFive() {
 //This is equal to one point because laser impact
 if (value_received == 'S') {
   life_PFive = life_PFive - 1;
   laser_sound.play();
   value_received = '0';
 }
}

public void Player_Five() {
 textFont(title);
 fill(0xffFFFFFF);
 text("Player five", 430, 520);
 lifeC_PFive.display_five(life_PFive);
}

public void Serial_Event_PlayerSix() {
 //This is equal to one point because laser impact
 if (value_received == 'I') {
   life_PSix = life_PSix - 1;
   laser_sound.play();
   value_received = '0';
 }
}

public void Player_Six() {
 textFont(title);
 fill(0xffFFFFFF);
 text("Player six", 790, 520);
 lifeC_PSix.display_six(life_PSix);
}

// The serverEvent function is called whenever a new client connects.
public void serverEvent(Server server, Client client) {
  println(client.ip());
  // Reset newMessageColor to black
  newMessageColor = 0;
}

public void setup() {
  
  frameRate(120);
  //Setup font
  title = loadFont("Arial-BoldMT-48.vlw");
  life_title = loadFont("Arial-BoldMT-28.vlw");
  textFont(title);
  //Watch setup
  sw = new StopWatchTimer();
  sw.start();

  //New cp5_one Knob constructor for player one
  cp5_one = new ControlP5(this);
  //New cp5_two Knob constructor for player two
  cp5_two = new ControlP5(this);
  //New cp5_three Knob constructor for player three
  cp5_three = new ControlP5(this);
  //New cp5_four Knob constructor for player four
  cp5_four = new ControlP5(this);
  //New cp5_five Knob constructor for player five
  cp5_five = new ControlP5(this);
  //New cp5_six Knob constructor for player six
  cp5_six = new ControlP5(this);

  // Constructors for players life
  // life of the user, x and y coordinate for the orbe
  lifeC_POne   = new Life(195, 40, background_death_one);
  lifeC_PTwo   = new Life_Two(550, 40, background_death_two);
  lifeC_PThree = new Life_Three(905, 40, background_death_three);
  lifeC_PFour  = new Life_Four(195, 460, background_death_four);
  lifeC_PFive  = new Life_Five(550, 460, background_death_five);
  lifeC_PSix   = new Life_Six(905, 460, background_death_six);
  // Contructors for the laser sounds files
  laser_sound = new SoundFile(this, "laser.mp3");
  coin_sound = new SoundFile(this, "coin.mp3");
  background_music = new SoundFile(this, "background.mp3");
  //Display life of players knob
  lifeC_POne.position_one(75, 120);
  lifeC_PTwo.position_two(430, 120);
  lifeC_PThree.position_three(785, 120);
  lifeC_PFour.position_four(75, 550);
  lifeC_PFive.position_five(430, 550);
  lifeC_PSix.position_six(785, 550);
  //Color of the background
  background(0xffB28DFF);
  //Open the port
  // Create the Server on port 5204
  server = new Server(this, 5204);
  // Play background sound
  // background_music.play();
  background_music.loop();
}

public void draw() {
  //Set the background of the game
  Game_BackGround();
  //Show the watch
  Watch();
  //Read the incoming data of the serial port
  WiFi_Read_Data();
  if (flag_one == "Yes") {
    //Check for player one
    Serial_Event_PlayerOne();
    //Show events life for player one
    Player_One();
  }
  if (flag_two == "Yes") {
    //Check for player two
    Serial_Event_PlayerTwo();
    //Show events life for player two
    Player_Two();
  }
  if (flag_three == "Yes") {
   //Check for player two
   Serial_Event_PlayerThree();
   //Show events life for player two
   Player_Three();
  }
  if (flag_four == "Yes") {
   //Check for player two
   Serial_Event_PlayerFour();
   //Show events life for player two
   Player_Four();
  }
  if (flag_five == "Yes") {
   //Check for player two
   Serial_Event_PlayerFive();
   //Show events life for player two
   Player_Five();
  }
  if (flag_six == "Yes") {
   //Check for player two
   Serial_Event_PlayerSix();
   //Show events life for player two
   Player_Six();
  }
}
class Life {
  int x;
  int y;
  int background_color;

  Life(int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }
  public void position_one (int pos_x, int pos_y) {
    myKnobA = cp5_one.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PO)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  public void display_one(int life_temporal) {
    myKnobA.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if ((life_temporal <= 3) && (life_temporal > 1)) {
            //If the user end the game change the color to yellow
            noStroke();
            fill(0xfffff74d);
            ellipse(x, y, 40, 40);
            background_death_one = color(0xfffff74d);
            myKnobA.setColorForeground(0xff794DFF);
            myKnobA.setColorBackground(background_death_one);
            myKnobA.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
            //If the user end the game change the color to red
            noStroke();
            fill(0xffff2301);
            ellipse(x, y, 40, 40);
            background_death_one = color(0xffff2301);
            myKnobA.setColorBackground(background_death_one);
            myKnobA.setColorValue(255);
    }
  }
}
class Life_Five {
  int x;
  int y;
  int background_color;

  Life_Five (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  public void position_five(int pos_x, int pos_y) {
    myKnobE = cp5_five.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PFive)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  public void display_five(int life_temporal) {
    myKnobE.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_temporal <= 3) && (life_temporal > 1)) {
      //If the user end the game change the color to yellow
      noStroke();
      fill(0xfffff74d);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xfffff74d);
      myKnobE.setColorForeground(0xff794DFF);
      myKnobE.setColorBackground(background_death_one);
      myKnobE.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(0xffff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xffff2301);
      myKnobE.setColorBackground(background_death_one);
      myKnobE.setColorValue(255);
    }
  }
}
class Life_Four {
  int x;
  int y;
  int background_color;

  Life_Four (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  public void position_four(int pos_x, int pos_y) {
    myKnobD = cp5_four.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PFour)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  public void display_four(int life_temporal) {
    myKnobD.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_temporal <= 3) && (life_temporal > 1)) {
      //If the user end the game change the color to yellow
      noStroke();
      fill(0xfffff74d);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xfffff74d);
      myKnobD.setColorForeground(0xff794DFF);
      myKnobD.setColorBackground(background_death_one);
      myKnobD.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(0xffff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xffff2301);
      myKnobD.setColorBackground(background_death_one);
      myKnobD.setColorValue(255);
    }
  }
}
class Life_Six {
  int x;
  int y;
  int background_color;

  Life_Six (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  public void position_six(int pos_x, int pos_y) {
    myKnobF = cp5_six.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PSix)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  public void display_six(int life_temporal) {
    myKnobF.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_temporal <= 3) && (life_temporal > 1)) {
      //If the user end the game change the color to yellow
      noStroke();
      fill(0xfffff74d);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xfffff74d);
      myKnobF.setColorForeground(0xff794DFF);
      myKnobF.setColorBackground(background_death_one);
      myKnobF.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(0xffff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xffff2301);
      myKnobF.setColorBackground(background_death_one);
      myKnobF.setColorValue(255);
    }
  }
}
class Life_Three {
  int x;
  int y;
  int background_color;

  Life_Three (int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }

  public void position_three(int pos_x, int pos_y) {
    myKnobC = cp5_three.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PThree)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }

  public void display_three(int life_temporal) {
    myKnobC.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if((life_temporal <= 3) && (life_temporal > 1)) {
      //If the user end the game change the color to yellow
      noStroke();
      fill(0xfffff74d);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xfffff74d);
      myKnobC.setColorForeground(0xff794DFF);
      myKnobC.setColorBackground(background_death_one);
      myKnobC.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
      //If the user end the game change the color to red
      noStroke();
      fill(0xffff2301);
      ellipse(x, y, 40, 40);
      background_death_one = color(0xffff2301);
      myKnobC.setColorBackground(background_death_one);
      myKnobC.setColorValue(255);
    }
  }
}
class Life_Two {
  int x;
  int y;
  int background_color;

  Life_Two(int x_temporal, int y_temporal, int temporal_background_color) {
    x = x_temporal;
    y = y_temporal;
    background_color = temporal_background_color;
  }
  public void position_two(int pos_x, int pos_y) {
    myKnobB = cp5_two.addKnob("Life")
      .setFont(life_title)
      .setViewStyle(3)
      .setRange(0, 5)
      .setValue(life_PT)
      .setPosition(pos_x, pos_y)
      .setRadius(120)
      .hideTickMarks()
      .setNumberOfTickMarks(5)
      .setTickMarkLength(8)
      .setTickMarkWeight(3)
      .snapToTickMarks(true)
      .setColorForeground(color(0xffbaffc9, 191))
      .setColorBackground(background_color)
      //.setColorActive(color(255,255,0))
      .setDragDirection(Knob.VERTICAL)
      ;
  }
  public void display_two(int life_temporal) {
    myKnobB.setValue(life_temporal);
    if(life_temporal > 3) {
            noStroke();
            fill(69, 252, 131);
            ellipse(x, y, 40, 40);
    }
    if ((life_temporal <= 3) && (life_temporal > 1)) {
            //If the user end the game change the color to yellow
            noStroke();
            fill(0xfffff74d);
            ellipse(x, y, 40, 40);
            background_death_one = color(0xfffff74d);
            myKnobB.setColorForeground(0xff794DFF);
            myKnobB.setColorBackground(background_death_one);
            myKnobB.setColorValueLabel(0xff05A73F);
    }
    if (life_temporal <= 1) {
            //If the user end the game change the color to red
            noStroke();
            fill(0xffff2301);
            ellipse(x, y, 40, 40);
            background_death_one = color(0xffff2301);
            myKnobB.setColorBackground(background_death_one);
            myKnobB.setColorValue(255);
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
  public void settings() {  size(1440, 850); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Interface" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
