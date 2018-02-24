# Serial Configuration

### Shoulder Serial Values

**This values are the ones that are used for the Bluetooth Connected to the Shoulder**

Number |   Purpose
:----: | :---------:
  0    | Null Value
  1    | Laser Point
  2    | Special Gun
  3    |  IR Point

> Apply for all the players

### Watch Serial Values

**This values are the ones that are used for the Serial communication to connected with the server for player one**

Number |        Purpose
:----: | :-------------------:
  0    |      Null Value
  1    |      Laser Point
  2    |       IR Point
  3    |      Laser Shoot
  4    | Special Gun Available
  5    |  Special Gun Shooted
  O    |  Activate the Player
  
**This values are the ones that are used for the Serial communication to connected with the server for player two**

Number |        Purpose
:----: | :-------------------:
  0    |      Null Value
  1    |      Laser Point
  2    |       IR Point
  3    |      Laser Shoot
  4    | Special Gun Available
  5    |  Special Gun Shooted
  T    |  Activate the Player  
 
### Server Serial Values 

**This values are used in Processing to read serial communication of player one**

Number |       Purpose
:----: | :-----------------:
  0    |     Null Value
  1    | Life (Laser Impact)
  2    |  Life (IR Impact)
  3    |    Laser Shoot 
  4    | Special Gun Charged
  5    | Special Gun Shotted
  O    |  Activate the Player
  
> letters value are in [ASCII](http://www.theasciicode.com.ar/extended-ascii-code/capital-letter-o-acute-accent-ascii-code-224.html), for example 'O' in ASCII has a numerical value of 79

**This values are the ones that are used for serial configuration in processing for player two**

Number |       Purpose
:----: | :-----------------:
  0    |     Null Value
  6    | Life (Laser Impact)
  7    |  Life (IR Impact)
  8    |    Laser Shoot 
  9    | Special Gun Charged
  A    | Special Gun Shotted
  
  > letters value are in [ASCII](http://www.theasciicode.com.ar/extended-ascii-code/capital-letter-o-acute-accent-ascii-code-224.html), for example 'A' in ASCII has a numerical value of 10


## Bluetooth Module Configuration

Name |  Role  | Baud Rate |    Address
:--: | :----: | :-------: | :------------:
 S1  | SLAVE  |  115200   | 98d3,31,fb70f8
 M1  | MASTER |  115200   | 18,e4,34c812
 S2  | SLAVE  |  115200   |   21,13,e57b
 M2  | MASTER |  115200   |  21,13,13882
 S3  | SLAVE  |  115200   |  21,13,1388b
 M3  | MASTER |  115200   |   21,13,e621
 S4  | SLAVE  |  115200   |  21,13,22f38
 M4  | MASTER |  115200   |   21,13,a2ce
 S5  | SLAVE  |  115200   |   21,13,e72f
 S6  | SLAVE  |  115200   |  21,13,222ad 
 M6  | MASTER |  115200   |  21,13,2d0ae
 S7  | SLAVE  |  115200   |  98d3,31,fc766f
 M7  | MASTER |  115200   |  98d3,31,fb6fb7
 
 > See this [tutorial](https://github.com/totovr/Arduino/tree/master/HC-05/MASTER_SLAVE) to know how to configure the modules 

# Map of Microcontroller PINS 

### This PINS are defined for an Arduino Mega

PIN |       Purpose
:-: | :-----------------:
 7  | Super Weapon Button
 5  |       OLED (MOSI)
 8  |       OLED (CLK)
 8  |       IR
10  |       OLED (RES)
11  |       OLED (DC)
12  |       OLED (CS)
13  |       Laser
42  | Air pressure indicate LED
44  | Super Gun indicate LED
50  |    Laser Button
A1  | Air pressure sensor

### Arduino Mega PIN MAP

<img src="https://github.com/totovr/SuperHuman/blob/master/Images/arduino-mega-pinmap.png" width="800">

### This PINS are defined for an Arduino Dev32

PIN |         Purpose
:-: | :----------------------:
 4  |      Laser receptor
 2  |        EMG sensor
17  |       IR receptor
 5  |     Impact received
 7  | led to indicate charging
 8  |  led to indicate charge
 
### Dev32 PIN MAP

<img src="https://github.com/totovr/SuperHuman/blob/master/Images/esp32_pinmap.png" width="600">
