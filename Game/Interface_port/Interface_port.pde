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
Server server_one;
Client client_one;
Server server_two;
Client client_two;
Server server_three;
Client client_three;
Server server_four;
Client client_four;
Server server_five;
Client client_five;
Server server_six;
Client client_six;
// Sound objects
SoundFile laser_sound;
SoundFile background_music;

// Used to indicate a new message has arrived
float newMessageColor = #ffffff;
// Varibles to save the data
char incomingMessage_one = '0';
char value_received_one = '0';
char incomingMessage_two = '0';
char value_received_two = '0';
char incomingMessage_three = '0';
char value_received_three = '0';
char incomingMessage_four = '0';
char value_received_four = '0';
char incomingMessage_five = '0';
char value_received_five = '0';
char incomingMessage_six = '0';
char value_received_six = '0';
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
  text("MuscleBlazer", 1100, 200);
}

void Watch() {
  fill(255);
  textFont(title);
  text("TIMER", 1170, 50);
  text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 1150, 100);
}

void WiFi_Read_Data() {
  // If a client is available, we will find out
  // If there is no client, it will be"null"
  client_one = server_one.available();
  if (client_one != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_one = client_one.readChar();
    value_received_one = incomingMessage_one;
    println(value_received_one);
    //delay(20);
  }
  // Client two
  client_two = server_two.available();
  if (client_two != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_two = client_two.readChar();
    value_received_two = incomingMessage_two;
    println(value_received_two);
    //delay(20);
  }
  // Client three
  client_three = server_three.available();
  if (client_three != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_three = client_three.readChar();
    value_received_three = incomingMessage_three;
    println(value_received_three);
    //delay(20);
  }
  // Client four
  client_four = server_four.available();
  if (client_four != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_four = client_four.readChar();
    value_received_four = incomingMessage_four;
    println(value_received_four);
    //delay(20);
  }
  // Client five
  client_five = server_five.available();
  if (client_five != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_five = client_five.readChar();
    value_received_five = incomingMessage_five;
    println(value_received_five);
    //delay(20);
  }
  // Client six
  client_six = server_six.available();
  if (client_six != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage_six = client_six.readChar();
    value_received_six = incomingMessage_six;
    println(value_received_six);
    //delay(20);
  }
}

void Serial_Event_PlayerOne() {
  //This is equal to one point because laser impact
  if (value_received_one == 'H') {
    life_PO = life_PO - 1;
    laser_sound.play();
  }
}

void Player_One() {
  textFont(title);
  fill(#FFFFFF);
  text("Player One", 80, 100);
  lifeC_POne.display_one(life_PO);
  value_received_one = '0';
}

void Serial_Event_PlayerTwo() {
  //This is equal to one point because laser impact
  if (value_received_two == 'W') {
    life_PT = life_PT - 1;
    laser_sound.play();
  }
}

void Player_Two() {
  textFont(title);
  fill(#FFFFFF);
  text("Player two", 440, 100);
  lifeC_PTwo.display_two(life_PT);
  value_received_two = '0';
}

void Serial_Event_PlayerThree() {
 //This is equal to one point because laser impact
 if (value_received_three == 'Z') {
   life_PThree = life_PThree - 1;
   laser_sound.play();
 }
}

void Player_Three() {
 textFont(title);
 fill(#FFFFFF);
 text("Player three", 770, 100);
 lifeC_PThree.display_three(life_PThree);
 value_received_three = '0';
}

void Serial_Event_PlayerFour() {
 //This is equal to one point because laser impact
 if (value_received_four == 'P') {
   life_PFour = life_PFour - 1;
   laser_sound.play();
 }
}

void Player_Four() {
 textFont(title);
 fill(#FFFFFF);
 text("Player four", 80, 520);
 lifeC_PFour.display_four(life_PFour);
 value_received_four = '0';
}

void Serial_Event_PlayerFive() {
 //This is equal to one point because laser impact
 if (value_received_five == 'S') {
   life_PFive = life_PFive - 1;
   laser_sound.play();
 }
}

void Player_Five() {
 textFont(title);
 fill(#FFFFFF);
 text("Player five", 430, 520);
 lifeC_PFive.display_five(life_PFive);
 value_received_five = '0';
}

void Serial_Event_PlayerSix() {
 //This is equal to one point because laser impact
 if (value_received_six == 'I') {
   life_PSix = life_PSix - 1;
   laser_sound.play();
 }
}

void Player_Six() {
 textFont(title);
 fill(#FFFFFF);
 text("Player six", 790, 520);
 lifeC_PSix.display_six(life_PSix);
 value_received_six = '0';
}

// The serverEvent function is called whenever a new client connects.
void serverEvent(Server server, Client client) {
  println(client.ip());
  // Reset newMessageColor to black
  newMessageColor = 0;
}

void setup() {
  size(1440, 850);
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
  background_music = new SoundFile(this, "background.mp3");
  //Display life of players knob
  lifeC_POne.position_one(75, 120);
  lifeC_PTwo.position_two(430, 120);
  lifeC_PThree.position_three(785, 120);
  lifeC_PFour.position_four(75, 550);
  lifeC_PFive.position_five(430, 550);
  lifeC_PSix.position_six(785, 550);
  //Color of the background
  background(#B28DFF);
  //Open the port
  // Create the Server on port 5204
  server_one = new Server(this, 3000);
  // Create the Server on port 5205
  server_two = new Server(this, 5205);
  // Create the Server on port 5206
  server_three = new Server(this, 3500);
  // Create the Server on port 5207
  server_four = new Server(this, 3300);
  // Create the Server on port 5200
  server_five = new Server(this, 5208);
  // Create the Server on port 5209
  server_six = new Server(this, 5209);
  // Play background sound
  // background_music.play();
  background_music.loop();
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
