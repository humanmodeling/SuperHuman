
  const int inputPin = 2;  //pin for pullup resistor
  int value = 0;
  int ledIR =  13;         //pin for IR led  
  int lastvalue = 0;     // previous state of the button

  void setup() {  
    pinMode(ledIR, OUTPUT);  //Set pin 13 as output
    Serial.begin(9600);      //Start serial communication  
  }
  
  void loop(){     
    value = digitalRead(inputPin);  //read the digital input
    PullUp(); 
  }
  
  //Encode
  void SendPluse(){ 
    //We will send 3 pulses
    pulseIR(80);
    delayMicroseconds(9000);
    pulseIR(60);
    delayMicroseconds(9000);
    pulseIR(80);
    delayMicroseconds(9000);        
  }
  
  void pulseIR(long seg){
    /*It generates the 38KHz frequency pulses for x microseconds.
     · Parameters: microseg */  
    while (seg > 0) {
      /*38KHz are approx. 13microseg in HIGH and 13microseg in LOW digital instructionWrite
      late 3microseg in running so we do two delays of 10 instead of 13. In total the cycle
      lasts 26microseg, when it is completed, we subtract the time it has to be sending the pulse*/
      digitalWrite(ledIR, HIGH);
      delayMicroseconds(100000);
      digitalWrite(ledIR, LOW);
      delayMicroseconds(100000);
      seg -= 26;
    }
  }
  
  void PullUp(){       
    if (value != lastvalue) {
      if (value == HIGH) {
          Serial.println("ON");
          SendPluse(); //I call the function pulse
          Serial.println("Sent!");
          delay(2000);
      }
    }   
    lastvalue = value;//Evaluate the last state of the push buttom 
  }
