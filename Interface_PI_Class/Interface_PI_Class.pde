//Libraries
import processing.net.*;
import controlP5.*;
import processing.sound.*;

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

// Used to indicate a new message has arrived
float newMessageColor = #ffffff;
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
Life lifeC_POne;
Life lifeC_PTwo;
Life lifeC_PThree;
Life lifeC_PFour;
Life lifeC_PFive;
Life lifeC_PSix;

// Variables for data
char read_one;
char read_two;
char read_three;
char read_four;
char read_five;
char read_six;

void Game_BackGround() {
  background(#B28DFF);
  //logo of laboratory
  //logo = loadImage("Images/logo.png");
  //image(logo, 20, 20, 248, 75);
  ////Title of the game
  fill(255);
  textFont(title);
  text("BlazerMuscle", 570, 60);
  //Name of the team
  //fill(255);
  //textFont(title);
  //text("Team Roger One", 305, 90);
}

void Watch() {
  fill(255);
  textFont(title);
  text("TIMER", 1200, 50);
  text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 1182, 100);
}

void WiFi_Read_Data() {
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

void Serial_Event_PlayerOne() {
  //This is equal to one point because laser impact
  if (value_received == 'H') {
    life_PO = life_PO - 1;
    laser_sound.play();
    myKnobA.setValue(life_PO);
    value_received = '0';
  } else if (value_received == 'R' && life_PO < 5) {
    life_PO = life_PO + 1;
    coin_sound.play();
    myKnobA.setValue(life_PO);
    value_received = '0';
  }
}

void Player_One() {
  textFont(title);
  fill(#FFFFFF);
  text("Player One", 80, 210);
  lifeC_POne.display(life_PO);
}

void Serial_Event_PlayerTwo() {
  //This is equal to one point because laser impact
  if (value_received == 'W') {
    life_PT = life_PT - 1;
    laser_sound.play();
    myKnobB.setValue(life_PT);
    value_received = '0';
  } else if (value_received == 'X' && life_PT < 5) {
    life_PT = life_PT + 1;
    coin_sound.play();
    myKnobB.setValue(life_PT);
    value_received = '0';
  }
}

void Player_Two() {
  textFont(title);
  fill(#FFFFFF);
  text("Player two", 440, 210);
  lifeC_PTwo.display(life_PT);
}

void Serial_Event_PlayerThree() {
  //This is equal to one point because laser impact
  if (value_received == 'Z') {
    life_PThree = life_PThree - 1;
    laser_sound.play();
    myKnobC.setValue(life_PThree);
    value_received = '0';
  } else if (value_received == 'Y' && life_PThree < 5) {
    life_PThree = life_PThree + 1;
    coin_sound.play();
    myKnobC.setValue(life_PThree);
    value_received = '0';
  }
}

void Player_Three() {
  textFont(title);
  fill(#FFFFFF);
  text("Player three", 770, 210);
  lifeC_PThree.display(life_PThree);
}

void Serial_Event_PlayerFour() {
  //This is equal to one point because laser impact
  if (value_received == 'P') {
    life_PFour = life_PFour - 1;
    laser_sound.play();
    myKnobD.setValue(life_PFour);
    value_received = '0';
  } else if (value_received == 'Q' && life_PFour < 5) {
    life_PFour = life_PFour + 1;
    coin_sound.play();
    myKnobD.setValue(life_PFour);
    value_received = '0';
  }
}

void Player_Four() {
  textFont(title);
  fill(#FFFFFF);
  text("Player four", 80, 670);
  lifeC_PFour.display(life_PFour);
}

void Serial_Event_PlayerFive() {
  //This is equal to one point because laser impact
  if (value_received == 'S') {
    life_PFive = life_PFive - 1;
    laser_sound.play();
    myKnobE.setValue(life_PFive);
    value_received = '0';
  } else if (value_received == 'T' && life_PFive < 5) {
    life_PFive = life_PFive + 1;
    coin_sound.play();
    myKnobE.setValue(life_PFive);
    value_received = '0';
  }
}

void Player_Five() {
  textFont(title);
  fill(#FFFFFF);
  text("Player five", 430, 670);
  lifeC_PFive.display(life_PFive);
}

void Serial_Event_PlayerSix() {
  //This is equal to one point because laser impact
  if (value_received == 'I') {
    life_PSix = life_PSix - 1;
    laser_sound.play();
    myKnobF.setValue(life_PSix);
    value_received = '0';
  } else if (value_received == 'J' && life_PSix < 5) {
    life_PSix = life_PSix + 1;
    coin_sound.play();
    myKnobF.setValue(life_PSix);
    value_received = '0';
  }
}

void Player_Six() {
  textFont(title);
  fill(#FFFFFF);
  text("Player six", 790, 670);
  lifeC_PSix.display(life_PSix);
}

// The serverEvent function is called whenever a new client connects.
void serverEvent(Server server, Client client) {
  println(client.ip());
  // Reset newMessageColor to black
  newMessageColor = 0;
}

void setup() {
  size(1440, 1000);
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
  myKnobA = cp5_one.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PO)
    .setPosition(75, 250)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_one)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
  //New cp5_two Knob constructor for player two
  cp5_two = new ControlP5(this);
  myKnobB = cp5_two.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PT)
    .setPosition(430, 250)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_two)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
  //New cp5_three Knob constructor for player three
  cp5_three = new ControlP5(this);
  myKnobC = cp5_three.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PThree)
    .setPosition(785, 250)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_three)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
    //New cp5_two Knob constructor for player four
  cp5_four = new ControlP5(this);
  myKnobD = cp5_four.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PFour)
    .setPosition(75, 710)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_four)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
    //New cp5_two Knob constructor for player five
  cp5_five = new ControlP5(this);
  myKnobE = cp5_five.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PFive)
    .setPosition(430, 710)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_five)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
    //New cp5_two Knob constructor for player two
  cp5_six = new ControlP5(this);
  myKnobF = cp5_six.addKnob("Life")
    .setFont(life_title)
    .setViewStyle(3)
    .setRange(0, 5)
    .setValue(life_PSix)
    .setPosition(785, 710)
    .setRadius(120)
    .hideTickMarks()
    .setNumberOfTickMarks(5)
    .setTickMarkLength(8)
    .setTickMarkWeight(3)
    .snapToTickMarks(true)
    .setColorForeground(color(#baffc9, 191))
    .setColorBackground(background_death_six)
    //.setColorActive(color(255,255,0))
    .setDragDirection(Knob.VERTICAL)
    ;
  //Color of the background
  background(#B28DFF);
  //Open the port
  // Create the Server on port 5204
  server = new Server(this, 5204);
  // Constructors for players life
  // life of the user, x and y coordinate for the orbe
  lifeC_POne = new Life(195, 140);
  lifeC_PTwo = new Life(550, 140);
  lifeC_PThree = new Life(905, 140);
  lifeC_PFour = new Life(195, 600);
  lifeC_PFive = new Life(550, 600);
  lifeC_PSix = new Life(905, 600);
  // Contructos for the laser sound file
  laser_sound = new SoundFile(this, "laser.mp3");
  coin_sound = new SoundFile(this, "coin.mp3");
}

void draw() {
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
