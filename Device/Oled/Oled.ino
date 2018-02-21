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

void setup() {                
  Serial.begin(9600);
  display.begin(SSD1306_SWITCHCAPVCC);
  display.display();
  delay(1000);
  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(BLACK, WHITE);
}

void loop() {
  oled_display();
}

void oled_display() {
  display.clearDisplay();
  display.setCursor(0,0);
  display.print("Shoots recived: ");
  //display.print(x);//counter
  display.print("\n");
  display.print("Shoots: ");
  //display.print(x);//counter
  display.print("\n");
  display.print("Air Pressure: ");
  //display.print(x);//counter
  display.print("\n");
  display.print("Timer: ");
  timer();
  display.display();  
}

void timer() {
  long t= millis()/1000 ;
  int horas = t/3600 ;
  int minutos = (t % 3600) / 60;
  int segs = (t - horas*3600 - minutos * 60) % 60 ;
  int n = sprintf(buffer, "%02d:%02d:%02d", horas, minutos, segs);  
  display.print(buffer);
}

