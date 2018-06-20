#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
// If using software SPI (the default case):
#define OLED_MOSI  11   //D1
#define OLED_CLK   12   //D0
#define OLED_DC    9
#define OLED_CS    8
#define OLED_RESET 10
char buffer[10];
Adafruit_SSD1306 display(OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

//Receptor
int points = 0;
int LaserValue = 0;
const int PointPin = A0;
int PointState = 0;
int lastPointState = 0;
//Emisor

int shoots = 0;
int ShootValue = 0;
const int ShootPin = A1;
int ShootState = 0;
int lastShootState = 0;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  display.begin(SSD1306_SWITCHCAPVCC);
  display.display();
  //delay(1000);
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(BLACK, WHITE); 
  //TheGame();
  //Set the pin has input
  pinMode(PointPin, INPUT);
  pinMode(ShootPin, INPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  //Just will set this display for the first 5 seconds
  oled_timer();
  //Read the input on analog pin 0:  
  PointState = digitalRead(PointPin);  
  Points();
  ShootState = digitalRead(ShootPin);  
  Shoots();
  //delay(300);
}

void TheGame() {
  //Draw a counter of the time to begin the game  
  for (int i=0; i < 6; i++) {
    display.clearDisplay();
    display.setCursor(0,0);
    int xy = i;
    display.print("          ");
    display.print("  Ready?      ");
    display.print(xy);
    display.print("               ");
    delay(1000);
    display.display();
  }   
}

void Points() {
  if (PointState != lastPointState) {
    if (PointState == HIGH) {
      points = points + 1; 
      oled_LF(); 
    }
  }   
  lastPointState = PointState;//Evaluate the last state of the push buttom 
}

void Shoots() {
  if (ShootState != lastShootState) {
    if (ShootState == HIGH) {
      shoots = shoots + 1; 
      oled_LF(); 
    }
  }   
  lastShootState = ShootState;//Evaluate the last state of the push buttom 
}

void oled_timer() {
  display.clearDisplay();
  display.setCursor(0,0);
  timer();
  display.display();
  //delay(500);  
}

void oled_LF() {
  display.clearDisplay();
  display.setCursor(0,0);
  shoot_life();
  display.display();
  delay(1000);
}

void shoot_life() {
  display.print("  Shoots  ");
  display.print("    ");
  display.print(shoots);//counter
  display.print("     ");
  display.print(" Impacts  ");
  display.print("    ");
  display.print(points);//counter  
  display.print("     ");   
}

void timer() {
  display.print("          ");
  display.print("  TIMER    ");
  calculateTime();
  display.print("          ");
  display.display();
}

void calculateTime(){
  long t= millis()/1000 ;
  int horas = t/3600 ;
  int minutos = (t % 3600) / 60;
  int segs = (t - horas*3600 - minutos * 60) % 60 ;
  int n = sprintf(buffer, "%02d:%02d:%02d ", horas, minutos, segs);  
  display.print(buffer); 
}

