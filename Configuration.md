# Watch

## Serial values

**This values are the ones that are used for the Bluetooth Connected to the Shoulder**

Number |   Purpose
:----: | :---------:
  0    | Null Value
  1    | Laser Point
  2    | Special Gun
  3    |  IR Point

**This values are the ones that are used for the Bluetooth Connected to the server**

Number |        Purpose
:----: | :-------------------:
  0    |      Null Value
  1    |      Laser Point
  2    |       IR Point
  3    |      Laser Shoot
  4    | Special Gun Available
  5    |  Special Gun Shooted

### Note that the Laser Point and the IR Point are impacts that we received because we were hit

## Map of Micro controller PIN usage

**This PIN are defined for an Arduino Mega**

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
