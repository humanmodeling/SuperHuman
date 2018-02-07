
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
    //We will send 1 pulse
    digitalWrite(ledIR, HIGH);
    delay(100);
    digitalWrite(ledIR, LOW);
    delay(2);        
  }
    
  void PullUp(){       
    if (value != lastvalue) {
      if (value == HIGH) {
          Serial.println("ON");
          SendPluse(); //I call the function pulse
          Serial.println("Sent!");
          delay(10);
      }
    }   
    lastvalue = value;//Evaluate the last state of the push buttom 
  }
