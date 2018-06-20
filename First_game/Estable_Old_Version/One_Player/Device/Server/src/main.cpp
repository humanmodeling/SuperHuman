#include <Arduino.h>

//Declare the functions
void Serial_Universal_Read();//Read the serial port
void Serial_Event_Uno();//Events of the player one

//Flag variables
String Activation_one = "No";
String flag_one = "No";

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
        delay(2000);
}

void loop() {
        Serial_Universal_Read();
        if(flag_one == "Yes") {
                Serial_Event_Uno();
        }
}

void Serial_Universal_Read() {
        //Read Serial One
        if(Serial1.available()) {
                StateSerial1 = Serial1.read();
                Serial.print(StateSerial1);
                //This will check if the Watch is activated
                if(Activation_one == "No") {
                        //79 correspond to an O
                        if(StateSerial1 == 79) {
                                //Send a O to activate the player in the interface
                                Serial.write('O');
                                StateSerial1 = 0;
                                //Activate the flag of the Serial events of player one
                                flag_one = "Yes";
                                //If watch was activated this bucle will run just one time
                                Activation_one = "Yes";
                        }
                }
        }
}

void Serial_Event_Uno() {
        //User was damaged by laser -1 point
        if(StateSerial1 == '1') {
                StateSerial1 = 0;
                Serial.write(1);
                digitalWrite(ledPinSOne, HIGH);
                delay(500);         // Wait 500 milliseconds for next reading
        } else if(StateSerial1 == '2') {
                //User was damaged by IR -5 points

                StateSerial1 = 0;
                Serial.write(2);
                digitalWrite(ledPinSOne, HIGH);
                delay(500);         // Wait 500 milliseconds for next reading
        } else if(StateSerial1 == '3') {
                //User activate the laser gun

                StateSerial1 = 0;
                Serial.write(3);
                digitalWrite(ledPinSOne, HIGH);
                delay(500);         // Wait 500 milliseconds for next reading
        } else if(StateSerial1 == '4') {
                //User charged the special weapon

                StateSerial1 = 0;
                Serial.write(4);
                digitalWrite(ledPinSOne, HIGH);
                delay(500);         // Wait 500 milliseconds for next reading
        } else if(StateSerial1 == '5') {
                //User shotted the special weapon
                StateSerial1 = 0;
                digitalWrite(ledPinSOne, HIGH);
                Serial.write(5);
                delay(500);         // Wait 500 milliseconds for next reading
        } else {
                digitalWrite(ledPinSOne, LOW);
                StateSerial1 = 0;
        }

}
