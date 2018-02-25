//Libraries
#include <Arduino.h>
#include <IRremote.h>
//Code Values
//Bluetooth
void PullUp();
#define button 8 //this is for the shoot
int last_value = 0;
int buttonState = 0;

void setup() {
  pinMode(button, INPUT);
  Serial.begin(38400); // Default communication rate of the Bluetooth module
}

void loop() {
 buttonState = digitalRead(button);
 PullUp();
}

void PullUp() {
 // Reading the button
  if(buttonState != last_value) {
    if (buttonState == HIGH) {
      Serial.write('1'); // Sends '1' to the master to turn on LED
    }
    else {
      Serial.write('0');
    }
  }
  last_value = buttonState;
}
