#include <Arduino.h>

//Declare the functions
void Serial_Universal_Read();//Read the serial port
void Serial_Event_Uno();//Events of the player one

//Bluetooth variables
char StateSerial1 = 0;
int ledPinSOne = 13; // Set the pin to digital I/O 7

void setup() {
        //Pin to check if we recive data from Slave1
        pinMode(ledPinSOne, OUTPUT); // Set pin as OUTPUT
        //We will use this for Master1
        Serial1.begin(115200); // Start serial communication at 38400 bps
        //We will use this to send the data to Processing
        Serial.begin(115200);
}

void loop() {
        Serial_Universal_Read();
        Serial_Event_Uno();
}

void Serial_Universal_Read() {
        //Read Serial One
        if(Serial1.available()) {
                StateSerial1 = Serial1.read();
        }
}

void Serial_Event_Uno() {
                //User was damaged by laser -1 point
                if(StateSerial1 == '1') {
                        Serial.write(1);
                        digitalWrite(ledPinSOne, HIGH);
                        delay(500); // Wait 500 milliseconds for next reading
                }
                //User was damaged by IR -5 points
                if(StateSerial1 == '2') {
                        Serial.write(2);
                        digitalWrite(ledPinSOne, HIGH);
                        delay(500); // Wait 500 milliseconds for next reading
                }
                //User activate the laser gun
                if(StateSerial1 == '3') {
                        Serial.write(3);
                        digitalWrite(ledPinSOne, HIGH);
                        delay(500); // Wait 500 milliseconds for next reading
                }
                //User charged the special weapon
                if(StateSerial1 == '4') {
                        Serial.write(4);
                        digitalWrite(ledPinSOne, HIGH);
                        delay(500); // Wait 500 milliseconds for next reading
                }
                //User shotted the special weapon
                if(StateSerial1 == '5') {
                        digitalWrite(ledPinSOne, HIGH);
                        Serial.write(5);
                        delay(500); // Wait 500 milliseconds for next reading
                } else {
                digitalWrite(ledPinSOne, LOW);
                StateSerial1 = 0;

        }
}
