int points = 0;
const int analogInPin = A0;
int LaserValue = 0;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Serial.print("The game started"); 
  Serial.print("\n"); 
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  LaserValue = analogRead(analogInPin);
  // print out the value you read:
  Serial.println("The value of the sensor is: ");
  Serial.println(LaserValue);
  Serial.print("\n"); 
  Points();  
  delay(300);
}

void Points() {
  if(LaserValue > 908) {
      points = points + 1;    
      delay(1000);  
  }  
  Serial.print("you have been hurt ");
  Serial.print(points); 
  Serial.print("\n");
  LaserValue = 0;
}

