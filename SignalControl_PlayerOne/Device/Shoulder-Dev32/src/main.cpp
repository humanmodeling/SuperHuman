//By the Super Human Team
//Bluetooth

#include <Arduino.h>
#include <IRremote.h>
#include <SimpleTimer.h>

//Functions
void Laser_Sensor();
void repeatEMG();
void IR_Receptor();
void IndicateCharging();

//Laser receptor
const int LSpin = 4;// Pin to read the laser sensor
int points = 0;
int LaserValue = 0;

//EMG Sensor
const int emgPin = 2;// Pin to read the EMG sensor
int emg = 0;
int emgfullcharge = 8;//led to indicate full charge
int emg_counter = 0;
int emgchargeLED1 = 27;
int emgchargeLED2 = 26;
int emgchargeLED3 = 32;
int emgchargeLED4 = 33;

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
        EMG_TIMER.setInterval(500, repeatEMG);//repeats every 1 second
        pinMode(emgchargeLED1,OUTPUT);
        pinMode(emgchargeLED2,OUTPUT);
        pinMode(emgchargeLED3,OUTPUT);
        pinMode(emgchargeLED4,OUTPUT);
}

void loop() {
        //Read laser sensors
        Laser_Sensor();
        //Indicate how much charging now
        IndicateCharging();
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
        else if (emg_counter>9){
                digitalWrite(emgchargeLED1,LOW); // Turn off the indicateCharging
                digitalWrite(emgchargeLED2,LOW);
                digitalWrite(emgchargeLED3,LOW);
                digitalWrite(emgchargeLED4,LOW);
                emg_counter = 0;
                Serial.write('2');  // Sends '2' to the master to activate the special gun
                Serial.write(0);  // Sends '0' to the master to be stable.
        }
}

void IndicateCharging() {
  if (emg_counter==2){
    digitalWrite(emgchargeLED1,HIGH);
  }
  else if (emg_counter==4){
    digitalWrite(emgchargeLED1,HIGH);
    digitalWrite(emgchargeLED2,HIGH);
  }
  else if (emg_counter==6){
    digitalWrite(emgchargeLED1,HIGH);
    digitalWrite(emgchargeLED2,HIGH);
    digitalWrite(emgchargeLED3,HIGH);
  }
  else if (emg_counter==8){
    digitalWrite(emgchargeLED1,HIGH);
    digitalWrite(emgchargeLED2,HIGH);
    digitalWrite(emgchargeLED3,HIGH);
    digitalWrite(emgchargeLED4,HIGH);
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
