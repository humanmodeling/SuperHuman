import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 
import processing.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Raspberry_Server extends PApplet {

// Import the libraries



// Declare objects
Server server;
Client client;

int elbow_value_right = 0;
int elbow_value_left = 3;

// Used to indicate a new message has arrived
float newMessageColor = 255;
String incomingMessage = "";

public void setup() {
        
        frameRate(30);
        // Create the Server on port 5204
        server = new Server(this, 5204);
        GPIO.pinMode(17, GPIO.OUTPUT);
        GPIO.pinMode(14, GPIO.OUTPUT);
}

public void draw() {
        background(newMessageColor);

        // newMessageColor fades to white over time
        newMessageColor = constrain(newMessageColor + 0.3f,0,255);
        textAlign(CENTER);
        fill(255);

        // The most recent incoming message is displayed in the window.
        text(incomingMessage,width/2,height/2);
        // We should only proceed if the client is not null
        //if (frameCount % 30 == 0){
        //  thread("incoming_read");
        //}
        incoming_read();
        UP_Event();
}

public void incoming_read() {
        // If a client is available, we will find out
        // If there is no client, it will be"null"
        client = server.available();
        if (client != null) {
                // Receive the message
                // The message is read using readString().
                incomingMessage = client.readString();
                elbow_value_right = PApplet.parseInt(incomingMessage);
                println(elbow_value_right + "");
                elbow_value_left = PApplet.parseInt(incomingMessage);
                println(elbow_value_left);
                // The trim() function is used to remove the extra line break that comes in with the message.
                incomingMessage = incomingMessage.trim();
                //incomingMessage = "";
                delay(20);
        }
}

public void UP_Event() {
        // Print to Processing message window
        if(elbow_value_right == 1) {
                GPIO.digitalWrite(17, GPIO.HIGH);
        } else if(elbow_value_right == 0) {
                GPIO.digitalWrite(17, GPIO.LOW);
        }
        if(elbow_value_left == 2) {
                GPIO.digitalWrite(14, GPIO.HIGH);
        } else if(elbow_value_left == 3) {
                GPIO.digitalWrite(14, GPIO.LOW);
        }
        // Write message back out (note this goes to ALL clients)
        server.write("The value received is " + incomingMessage + "\n"); // A reply is sent using write().

        // Reset newMessageColor to black
        newMessageColor = 0;
        delay(20);
}

// The serverEvent function is called whenever a new client connects.
public void serverEvent(Server server, Client client) {
        incomingMessage = "A new client has connected: " + client.ip();
        println(incomingMessage);
        // Reset newMessageColor to black
        newMessageColor = 0;
}
  public void settings() {  size(400,200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Raspberry_Server" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
