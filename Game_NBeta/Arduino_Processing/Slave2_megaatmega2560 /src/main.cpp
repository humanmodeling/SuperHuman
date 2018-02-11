#include <Arduino.h>

void ArduinoS_ArduinoM();

int ledPin = 7; // Set the pin to digital I/O 7

void setup() {
        pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
        //Slave
        Serial.begin(38400); // Start serial communication at 38400 bps

}

void loop() {
        ArduinoS_ArduinoM();
}

void ArduinoS_ArduinoM() {
        Serial.write('2');         // read it and store it in val
        digitalWrite(ledPin, HIGH);
        delay(1000); // Wait 10 milliseconds for next reading
        digitalWrite(ledPin, LOW);
        delay(1000); // Wait 10 milliseconds for next reading
}
