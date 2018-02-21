# Arduino Shoulder

## Serial values

**This values are the ones that are used for the Bluetooth**

Number |   Purpose
:----: | :---------:
  0    | Null Value
  1    | Laser Point
  2    | Special Gun
  3    |  IR Point

### Note that the Laser Point and the IR Point are impacts that we received because we were hit

## Map of Micro controller PIN usage

**This PIN are defined for an Arduino Nano**

PIN |         Purpose
:-: | :----------------------:
A0  |      Laser receptor
A1  |        EMG sensor
A2  |       IR receptor
 5  |     Impact received
 7  | led to indicate charging
 8  |  led to indicate charge
 
## Bluetooth Module Configuration

Name |  Role  | Baud Rate |    Address
:--: | :----: | :-------: | :------------:
 S1  | SLAVE  |  115200   | 98d3,31,fc767a
 M1  | MASTER |  115200   | 98d3,31,fd5cd0
 S2  | SLAVE  |  115200   |   21,13,e57b
 M2  | MASTER |  115200   |  21,13,13882
 S3  | SLAVE  |  115200   |  21,13,1388b
 M3  | MASTER |  115200   |   21,13,e621
 S4  | SLAVE  |  115200   |  21,13,22f38
 M4  | MASTER |  115200   |   21,13,a2ce
 S5  | SLAVE  |  115200   |   21,13,e72f
