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
Life        lifeC_POne;
Life_Two    lifeC_PTwo;
Life_Three  lifeC_PThree;
Life_Four   lifeC_PFour;
Life_Five   lifeC_PFive;
Life_Six    lifeC_PSix;


void Game_BackGround() {
  background(#B28DFF);
  //logo of laboratory
  //logo = loadImage("Images/logo.png");
  //image(logo, 20, 20, 248, 75);
  ////Title of the game
  fill(255);
  textFont(title);
  text("BlazerMuscle", 570, 60);
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
    value_received = '0';
  }
}

void Player_One() {
  textFont(title);
  fill(#FFFFFF);
  text("Player One", 80, 210);
  lifeC_POne.display_one(life_PO);
}

void Serial_Event_PlayerTwo() {
  //This is equal to one point because laser impact
  if (value_received == 'W') {
    life_PT = life_PT - 1;
    laser_sound.play();
    value_received = '0';
  }
}

void Player_Two() {
  textFont(title);
  fill(#FFFFFF);
  text("Player two", 440, 210);
  lifeC_PTwo.display_two(life_PT);
}

void Serial_Event_PlayerThree() {
 //This is equal to one point because laser impact
 if (value_received == 'Z') {
   life_PThree = life_PThree - 1;
   laser_sound.play();
   value_received = '0';
 }
}

void Player_Three() {
 textFont(title);
 fill(#FFFFFF);
 text("Player three", 770, 210);
 lifeC_PThree.display_three(life_PThree);
}

void Serial_Event_PlayerFour() {
 //This is equal to one point because laser impact
 if (value_received == 'P') {
   life_PFour = life_PFour - 1;
   laser_sound.play();
   value_received = '0';
 }
}

void Player_Four() {
 textFont(title);
 fill(#FFFFFF);
 text("Player four", 80, 670);
 lifeC_PFour.display_four(life_PFour);
}

void Serial_Event_PlayerFive() {
 //This is equal to one point because laser impact
 if (value_received == 'S') {
   life_PFive = life_PFive - 1;
   laser_sound.play();
   value_received = '0';
 }
}

void Player_Five() {
 textFont(title);
 fill(#FFFFFF);
 text("Player five", 430, 670);
 lifeC_PFive.display_five(life_PFive);
}

void Serial_Event_PlayerSix() {
 //This is equal to one point because laser impact
 if (value_received == 'I') {
   life_PSix = life_PSix - 1;
   laser_sound.play();
   value_received = '0';
 }
}

void Player_Six() {
 textFont(title);
 fill(#FFFFFF);
 text("Player six", 790, 670);
 lifeC_PSix.display_six(life_PSix);
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
  lifeC_POne   = new Life(195, 140, background_death_one);
  lifeC_PTwo   = new Life_Two(550, 140, background_death_two);
  lifeC_PThree = new Life_Three(905, 140, background_death_three);
  lifeC_PFour  = new Life_Four(195, 600, background_death_four);
  lifeC_PFive  = new Life_Five(550, 600, background_death_five);
  lifeC_PSix   = new Life_Six(905, 600, background_death_six);
  // Contructors for the laser sounds files
  laser_sound = new SoundFile(this, "laser.mp3");
  coin_sound = new SoundFile(this, "coin.mp3");
  //Display life of players knob
  lifeC_POne.position_one(75, 250);
  lifeC_PTwo.position_two(430, 250);
  lifeC_PThree.position_three(785, 250);
  lifeC_PFour.position_four(75, 710);
  lifeC_PFive.position_five(430, 710);
  lifeC_PSix.position_six(785, 710);
  //Color of the background
  background(#B28DFF);
  //Open the port
  // Create the Server on port 5204
  server = new Server(this, 5204);
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
