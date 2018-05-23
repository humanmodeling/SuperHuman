//By the Super Human Team
// Library to activate the GPIO 
import processing.io.*;

// Counter for the high pulses 
int pulses = 0;

void setup() {
  GPIO.pinMode(17, GPIO.INPUT);
}
 
void draw() {
        //Check how many shoots recived the player
        IR();
}
 
//Activate the laser gun
void IR() {
  // sense the input pin
  if (GPIO.digitalRead(17) == GPIO.HIGH) {
    pulses = pulses + 1;
    println(pulses);
    fill(255);
  } else {
    fill(204);
  }
  stroke(255);
  ellipse(width/2, height/2, width*0.75, height*0.75);
}
