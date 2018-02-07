//code values
const int inputPin = 2;  //pin for pullup resistor
int value = 0;
int ledLaser =  13;         //pin for IR led  
int lastvalue = 0;     // previous state of the button

//decode
//counter to begin the game
int count = 0;
//Receptor
int points = 0;
const int analogInPin = A0;
int LaserValue = 0;

int PointC = A1;//By this pin we will send the data to the OLED display for points

void setup() {  
  pinMode(ledLaser, OUTPUT);  //Set pin 13 as output
  Serial.begin(9600);      //Start serial communication  
  pinMode(PointC, OUTPUT);  //Set pin 11 as output
}

void loop(){     
  value = digitalRead(inputPin);  //read the digital input
  PullUp(); 
  LaserValue = analogRead(analogInPin);
  delay(10);
//  Serial.print(LaserValue);
//  Serial.print("\n");
  Points();
}
//Encode
void PullUp(){       
  if (value != lastvalue) {
    if (value == HIGH) {
        SendPluse(); //I call the function pulse
        delay(10);
    }
  }   
  lastvalue = value;//Evaluate the last state of the push buttom 
}

void SendPluse(){ 
  //We will send 1 pulse
  digitalWrite(ledLaser, HIGH);
  delay(1000);
  digitalWrite(ledLaser, LOW);
  delay(2);        
}
//decode
void Points() {
  if(LaserValue > 180) {
    digitalWrite(PointC, HIGH);
    delay(1000);
    digitalWrite(PointC, LOW);;  
  }  
  LaserValue = 0;
}
