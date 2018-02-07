#include <Arduino.h>

//Declare the functions
void ArduinoM1_Processing();
void ArduinoM2_Processing();

char StateSerial1 = 0;
char StateSerial2 = 0;

char val; // Data received from the serial port
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
}

void loop() {
        ArduinoM1_Processing();
        ArduinoM2_Processing();
}

void ArduinoM1_Processing() {
        if (Serial1.available()) {
                // If data is available to read,
                StateSerial1 = Serial1.read(); // read it and store it in val
                if(StateSerial1 == '1') {
                        Serial.write('1');
                } else {
                        Serial.write('0');//maybe this is not necessary
                }
        }
        delay(30); // Wait 30 milliseconds for next reading
}

void ArduinoM2_Processing() {
        if (Serial1.available()) {
                // If data is available to read,
                if(StateSerial2 == '2') {
                        StateSerial2 = Serial2.read(); // read it and store it in val
                        Serial.write('2');
                } else {
                        Serial.write('0');//maybe this is not necessary
                }
        }
        delay(30); // Wait 30 milliseconds for next reading
}
