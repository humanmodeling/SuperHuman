//By the Super Human Team
// Library to activate the GPIO 
import processing.io.*;

// Counter for the high pulses 
int pulses = 0;

void setup() {
  GPIO.pinMode(17, GPIO.INPUT);
}
 
void loop() {
        //Check how many shoots recived the player
        IR();
}
 
//Activate the laser gun
void IR() {

  if (GPIO.digitalRead(17) == GPIO.HIGH) {
    pulses = pulses + 1;
    if (pulses == 8) {
      
    }
  }
}
