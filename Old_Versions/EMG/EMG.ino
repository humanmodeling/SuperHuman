#include <IRremote.h>
#include <SimpleTimer.h>

//code values
int emgcharging = 7;
int emgfullcharge = 8;
int IRstate = 0;
int IRon = 9;

//EMG Sensor
int emgPin = A2;
int emg_counter = 0;
int emg = 0;

//IR
IRsend irsend;
const int IRpin = A3;
int IRpinvalue = 0;

// the timer object
SimpleTimer timer;

// EMG function to be executed periodically, each second/ minute (adjust accordingly)
void repeatMe() {
    emg = analogRead(emgPin);
    if(emg>900){
      
      digitalWrite(7,HIGH);
      delay(500);
      digitalWrite(7,LOW);

      emg_counter = emg_counter + 1;
      }

      else if (emg_counter>10) {
        digitalWrite(8,HIGH);
        delay(500);
        digitalWrite(8,LOW);
        emg_counter = 0;  
        IRstate = 1;     
        }

    Serial.print("Uptime (s): ");
    Serial.println(millis() / 1000);
    Serial.print("\n count =");
    Serial.print(emg_counter);
}

void setup() {
    pinMode(7, OUTPUT);
    pinMode(8,OUTPUT);
    pinMode(emgcharging, OUTPUT);
    pinMode(emgfullcharge, OUTPUT);
    pinMode(IRon, OUTPUT);
    Serial.begin(9600);
    timer.setInterval(1000, repeatMe);
       
}

void loop() {
    timer.run();
    IR();
}

void IR(){
  IRpinvalue = analogRead(IRpin);
  if(IRstate == 1 && IRpinvalue > 1000){
  irsend.sendSony(0x68B90, A4);
  //delay(500);
  digitalWrite(IRon, HIGH);
  delay(100);
  digitalWrite(IRon, LOW);
  IRstate = 0;
  }
 
  }
