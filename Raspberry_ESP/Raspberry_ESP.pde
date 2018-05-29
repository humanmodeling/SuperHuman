// Import the libraries
import processing.net.*;
import processing.io.*;

// Declare objects
Server server;
Client client;

// Used to indicate a new message has arrived
float newMessageColor = 255;
String incomingMessage = "";

void setup() {
  size(400,200);
  //frameRate(30);
  // Create the Server on port 5204
  server = new Server(this, 5204);
}

void draw() {
  background(newMessageColor);
  // newMessageColor fades to white over time
  newMessageColor = constrain(newMessageColor + 0.3,0,255);
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

void incoming_read() {
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
void serverEvent(Server server, Client client) {
  incomingMessage = "A new client has connected: " + client.ip();
  println(incomingMessage);
  // Reset newMessageColor to black
  newMessageColor = 0;
}
