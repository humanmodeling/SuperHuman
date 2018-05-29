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

public class Raspberry_ESP extends PApplet {

// Import the libraries



// Declare objects
Server server;
Client client;

// Used to indicate a new message has arrived
float newMessageColor = 255;
String incomingMessage = "";

public void setup() {
  
  //frameRate(30);
  // Create the Server on port 5204
  server = new Server(this, 5204);
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
}

public void incoming_read() {
  // If a client is available, we will find out
  // If there is no client, it will be"null"
  client = server.available();
  if (client != null) {
    // Receive the message
    // The message is read using readString().
    incomingMessage = client.readString();
    /////////////////////////////////////////
    // The trim() function is used to remove the extra line break that comes in with the message.
    incomingMessage = incomingMessage.trim();
    //incomingMessage = "";
    delay(20);
    server.write("The value received is hello world" + "\n"); // A reply is sent using write().
  }
  // Write message back out (note this goes to ALL clients)
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
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Raspberry_ESP" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
