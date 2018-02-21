# Watch

## Serial values

**This values are the ones that are used for the Bluetooth Connected to the Shoulder**
> Apply for all the players

Number |   Purpose
:----: | :---------:
  0    | Null Value
  1    | Laser Point
  2    | Special Gun
  3    |  IR Point

> Apply for all the players

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
  
**This values are used in the server for serial communication to connect with Processing for player one**

Number |       Purpose
:----: | :-----------------:
  0    |     Null Value
  1    | Life (Laser Impact)
  2    |  Life (IR Impact)
  3    |    Laser Shoot 
  4    | Special Gun Charged
  5    | Special Gun Shotted
  O    |  Activate the Player

> letters value are in [ASCII](http://www.theasciicode.com.ar/extended-ascii-code/capital-letter-o-acute-accent-ascii-code-224.html), example "O" = 79
  
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
  
> letters value are in [ASCII](http://www.theasciicode.com.ar/extended-ascii-code/capital-letter-o-acute-accent-ascii-code-224.html), example "O" = 79

## Map of Micro controller PIN usage

**This PINS are defined for an Arduino Mega**

PIN |       Purpose
:-: | :-----------------:
 2  |    Laser Bottom
 6  |    Super Gun LED
 7  | Super Weapon Bottom
 8  |        OLED
 9  |        OLED
10  |        OLED
11  |        OLED
12  |        OLED
13  |      Laser LED
A3  |       IR LED

**This PINS are defined for an Arduino Dev32**

PIN |         Purpose
:-: | :----------------------:
 4  |      Laser receptor
 2  |        EMG sensor
17  |       IR receptor
 5  |     Impact received
 7  | led to indicate charging
 8  |  led to indicate charge
 
 

## Bluetooth Module Configuration

Name |  Role  | Baud Rate |    Address
:--: | :----: | :-------: | :------------:
 S1  | SLAVE  |  115200   | 98d3,31,fc767a
 M1  | MASTER |  115200   | 98d3,31,fb70f8
 S2  | SLAVE  |  115200   |   21,13,e57b
 M2  | MASTER |  115200   |  21,13,13882
 S3  | SLAVE  |  115200   |  21,13,1388b
 M3  | MASTER |  115200   |   21,13,e621
 S4  | SLAVE  |  115200   |  21,13,22f38
 M4  | MASTER |  115200   |   21,13,a2ce
 S5  | SLAVE  |  115200   |   21,13,e72f
 
 ### Dev32 PIN MAP

<img src="https://github.com/totovr/SuperHuman/blob/master/Images/esp32_pinmap.png" width="600">

### Arduino Mega PIN MAP

<img src="https://github.com/totovr/SuperHuman/blob/master/Images/arduino-mega-pinmap.png" width="800">
