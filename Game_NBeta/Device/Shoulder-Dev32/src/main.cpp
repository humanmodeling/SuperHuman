//By the Super Human Team
//Bluetooth

#include <Arduino.h>
#include <IRremote.h>
#include <SimpleTimer.h>

//Functions
void Laser_Sensor();
void repeatEMG();
void IR_Receptor();

//Laser receptor
const int LSpin = 4;// Pin to read the laser sensor
int points = 0;
int LaserValue = 0;

//EMG Sensor
const int emgPin = 2;// Pin to read the EMG sensor
int emg = 0;
int emgfullcharge = 8;//led to indicate full charge
int emg_counter = 0;

//declare objects of SimpleTimer library
SimpleTimer EMG_TIMER; //Don't write "timer" as and object

// IR receptor
int IR_receptorPin = 17;//Pin used to read IR values
IRrecv irrecv(IR_receptorPin);//Create an object
decode_results results;
int IR_Impact = 5;
int IR_counter = 0;

//Death variable
int end = 0;

void setup() {
        // initialize serial communication at 38400 bits per second:
        Serial.begin(38400);
        pinMode(IR_Impact, OUTPUT);//Turn on pin 5 if we received an impact of IR
        pinMode(emgPin, INPUT);//Turn on pin 16 to read the EMG sensor
        pinMode(emgfullcharge, OUTPUT);//Turn on when IR gun is fully charged
        irrecv.enableIRIn(); // Start the receiver
        EMG_TIMER.setInterval(1000, repeatEMG);//repeats every 1 second
        //laser_read.setInterval(100, Laser_Sensor);//repeats every 0.1 seconds can be changed
        //IR_read.setInterval(100, IR_Receptor);//repeats every 0.1 seconds can be changed
}

void loop() {
        //Read laser sensors
        Laser_Sensor();
        //EMG sensor reading
        EMG_TIMER.run();
        //IR reding
        IR_Receptor();
}

//Decode
// Read the laser sensor to count the points
void Laser_Sensor() {
        LaserValue = analogRead(LSpin);
        //laser_value must be changed sometimes
        if(LaserValue > 3000) {
                if(end < 20) {
                        end=+1;
                        Serial.write('1'); // Sends '1' to the master to count as one point
                        delay(500);
                }//If we detect that the end variable is over 20 we will do a infinite bucle
                else {
                        while(1) {
                        }
                }
        }
        LaserValue = 0;
}
//Charge the special gun
void repeatEMG() {
        emg = analogRead(emgPin);
        if(emg > 900) {
                delay(1000);
                emg_counter = emg_counter + 1;
                emg = 0;
        }
        else if (emg_counter>10) {
                emg_counter = 0;
                Serial.write('2');  // Sends '2' to the master to activate the special gun
                Serial.write(0);  // Sends '2' to the master to activate the special gun
        }
}
//Decode the IR pulse
void IR_Receptor() {
        digitalWrite(IR_Impact,LOW);
        if (irrecv.decode(&results)) {
                if (results.decode_type == SONY) {
                        Serial.write('3');
                }
                irrecv.resume(); // Receive the next value
        }
}
