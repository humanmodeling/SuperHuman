#include <Arduino.h>
#include <SimpleTimer.h>

//Declare the functions
void ArduinoM1_Processing();
void ArduinoM2_Processing();

//Objects
SimpleTimer Player_One;//Don't write "timer" as and object
SimpleTimer Player_Two;

//Bluetooth variables
char StateSerial1 = 0;
char StateSerial2 = 0;
int ledPinSOne = 7; // Set the pin to digital I/O 7
int ledPinSTwo = 8; // Set the pin to digital I/O 8

void setup() {
        //Pin to check if we recive data from Slave1
        pinMode(ledPinSOne, OUTPUT); // Set pin as OUTPUT
        //Pin to check if we recive data from Slave2
        pinMode(ledPinSTwo, OUTPUT); // Set pin as OUTPUT
        //We will use this for Master1
        Serial1.begin(38400); // Start serial communication at 38400 bps
        //We will use this for Master2
        Serial2.begin(38400); // Start serial communication at 38400 bps
        //We will use this to send the data to Processing
        Serial.begin(38400);
        //Timer readings
        Player_One.setInterval(500, ArduinoM1_Processing);//repeats every 500 msecond
        Player_Two.setInterval(500, ArduinoM2_Processing);//repeats every 500 msecond
}

void loop() {
        Player_One.run();
        Player_Two.run();
}

void ArduinoM1_Processing() {
        if (Serial1.available()) {
                // If data is available to read,
                StateSerial1 = Serial1.read(); // read it and store it in StateSerial1
                if(StateSerial1 == '1') {
                        Serial.println("Point_One");
                        digitalWrite(ledPinSOne, HIGH);
                        delay(500); // Wait 500 milliseconds for next reading
                        digitalWrite(ledPinSOne, LOW);
                }
        } else {
                digitalWrite(ledPinSOne, LOW);
                delay(500); // Wait 500 milliseconds for next reading
        }
}

void ArduinoM2_Processing() {
        if (Serial2.available()) {
                // If data is available to read,
                StateSerial2 = Serial2.read(); // read it and store it in StateSerial2
                if(StateSerial2 == '2') {
                        Serial.println("Point_Two");
                        digitalWrite(ledPinSTwo, HIGH);
                        delay(500); // Wait 100 milliseconds for next reading
                        digitalWrite(ledPinSTwo, LOW);
                }
        } else {
                digitalWrite(ledPinSTwo, LOW);
                delay(500); // Wait 100 milliseconds for next reading
        }
}
