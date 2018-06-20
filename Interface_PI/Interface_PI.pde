//Libraries
import processing.net.*;
import controlP5.*;

//General objects
StopWatchTimer sw;
//Player one objects
ControlP5 cp5_one;
Knob myKnobA;
Slider Shoots_One_Slider;
//Player two ObjectsControlP5 cp5_one;
ControlP5 cp5_two;
Knob myKnobB;
Slider Shoots_Two_Slider;

// Declare server objects
Server server;
Client client;

// Used to indicate a new message has arrived
float newMessageColor = #ffffff;
char incomingMessage = '0';
char value_received = '0';

//Player one
//Player one knob Variables
int life_PO = 5;
int background_death_one = color(0, 160, 100);
//Slider player one variables Shoot
int sliderValue_ShootOne = 0;
//Activation variables for player one
String flag_one = "Yes";
String activation_one = "No";

//Player two
//Player two knob Variables
int life_PT = 5;
int background_death_two = color(0, 160, 100);
//Slider player one variables Shoot
int sliderValue_ShootTwo = 0;
//Activation variables for player two
String flag_two = "Yes";
String activation_two = "No";

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

void WiFi_Read_Data() {
  // If a client is available, we will find out
  // If there is no client, it will be"null"
  client = server.available();
  if (client != null) {
    // Receive the message
    // The message is read using readChar().
    incomingMessage = client.readChar();
    value_received = incomingMessage;
    //println(value_received);
    /////////////////////////////////////////
    // The trim() function is used to remove the extra line break that comes in with the message.
    //incomingMessage = incomingMessage.trim();
    //incomingMessage = "";
    //value_received = incomingMessage;
    println(value_received);
    delay(20);
  }
  //if(activation_one == "No") {
  //  println(value_received);
  //  if(value_received == "A") {
  //    flag_one = "Yes";
  //    activation_one = "Yes";
  //  }
  //}
  //if(activation_two == "No") {
  //  println(value_received);
  //  if(value_received == "B") {
  //          flag_two = "Yes";
  //          activation_two = "Yes";
  //  }
  //}
}

void Serial_Event_PlayerOne(){
  //This is equal to one point because laser impact
  if(value_received == 'H') {
          life_PO = life_PO - 1;
          myKnobA.setValue(life_PO);
          value_received = '0';
  }
}

void Player_One() {
        textFont(title);
        fill(#FFFFFF);
        text("Kishishita", 85, 210);
        //Generate the ellipse above the name
        if(life_PO > 3) {
                noStroke();
                fill(69,252,131);
                ellipse(143,150,40,40);
        }
        if((life_PO <= 3) && (life_PO > 1)) {
                //If the user end the game change the color to yellow
                noStroke();
                fill(#fff74d);
                ellipse(143,150,40,40);
                background_death_one = color(#fff74d);
                myKnobA.setColorForeground(#794DFF);
                myKnobA.setColorBackground(background_death_one);
                myKnobA.setColorValueLabel(#05A73F);
        }
        if (life_PO <= 1) {
                //If the user end the game change the color to red
                noStroke();
                fill(#ff2301);
                ellipse(143,150,40,40);
                background_death_one = color(#ff2301);
                myKnobA.setColorBackground(background_death_one);
                myKnobA.setColorValue(255);
        }
}

void Serial_Event_PlayerTwo() {
  //This is equal to one point because laser impact
  if(value_received == 'W') {
          life_PT = life_PT - 1;
          myKnobB.setValue(life_PT);
          value_received = '0';
  }
}

void Player_Two() {
  textFont(title);
  fill(#FFFFFF);
  text("Sue",528,210);
  //Generate the ellipse above the name
  if(life_PT > 3) {
          noStroke();
          fill(#45fc83);
          ellipse(553,150,40,40);
  }
  if((life_PT <= 3) && (life_PT > 1)) {
          //If the user end the game change the color to yellow
          noStroke();
          fill(#fff74d);
          ellipse(553,150,40,40);
          background_death_two = color(#fff74d);
          myKnobB.setColorForeground(#794DFF);
          myKnobB.setColorBackground(background_death_one);
          myKnobB.setColorValueLabel(#05A73F);
  }
  if (life_PT <= 1) {
          //If the user end the game change the color to red
          noStroke();
          fill(#ff2301);
          ellipse(553,150,40,40);
          background_death_two = color(#ff2301);
          myKnobB.setColorBackground(background_death_two);
          myKnobB.setColorValue(#ffffff);
  }
}

// The serverEvent function is called whenever a new client connects.
void serverEvent(Server server, Client client) {

  println(client.ip());
  // Reset newMessageColor to black
  newMessageColor = 0;
}

void setup() {
        size(800,600);
        frameRate(120);
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
                  .setRange(0,5)
                  .setValue(life_PO)
                  .setPosition(25,250)
                  .setRadius(120)
                  .hideTickMarks()
                  .setNumberOfTickMarks(5)
                  .setTickMarkLength(8)
                  .setTickMarkWeight(3)
                  .snapToTickMarks(true)
                  .setColorForeground(color(#baffc9,191))
                  .setColorBackground(background_death_one)
                  //.setColorActive(color(255,255,0))
                  .setDragDirection(Knob.VERTICAL)
        ;
        //New cp5_two Knob constructor for player two
        cp5_two = new ControlP5(this);
        myKnobB = cp5_two.addKnob("Life")
                  .setFont(life_title)
                  .setViewStyle(3)
                  .setRange(0,5)
                  .setValue(life_PT)
                  .setPosition(430,250)
                  .setRadius(120)
                  .hideTickMarks()
                  .setNumberOfTickMarks(5)
                  .setTickMarkLength(8)
                  .setTickMarkWeight(3)
                  .snapToTickMarks(true)
                  .setColorForeground(color(#baffc9,191))
                  .setColorBackground(background_death_one)
                  //.setColorActive(color(255,255,0))
                  .setDragDirection(Knob.VERTICAL)
        ;
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
                //ellipse(143, 150, frameCount%20, frameCount%20);
        }
        if(flag_two == "Yes") {
                //Check for player two
                Serial_Event_PlayerTwo();
                //Show events life for player two
                Player_Two();
        } else {
                textFont(title);
                fill(#FFFFFF);
                text("Disconnected",460,210);
                noStroke();
                fill(255,35,1);
                ellipse(553, 150, 40, 40);
                //ellipse(553, 150, frameCount%20, frameCount%20);
        }

}
