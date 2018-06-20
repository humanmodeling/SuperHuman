# ESP Server
## Requirement
ESP32 : 1  
M5Stack : 1  
Raspberry Pi : 1  

## PIN
| PIN No. | Material |
|:-: |:-:|
| 25 | valve1 |
| 26 | valve2 |
| 32 | valve3 |
| 33 | valve4 |

## Parameter
### lifeCount:
Number of payer life.  
Initial value : 5  
When player get hitting, this value minus 1.

### c:
The values are sent from M5Stack.  
c = 'H' : "Hitting"  
c = 'R' : "Recovering"  

# Transmitter watch
## Requirement
M5Stack : 1  
IR LED : 1  
Switch : 1  
IR receiver(38kHz) : 1  
FSR sensor : 1  

## PIN
| PIN No. | Material |
|:-: |:-:|
| 2 | Switch |
| 3 | IR LED |
| 17 | IR receiver |
| 35 | FSR sensor |

## Parameter
### switchOut
Output from switch.  
Initial value is 0.

### last_switchOut:
Last time output from switch.  
Initial value is 0.

### shootCount:
Number of shoot.  
Initial value is 0.

### lifeCount:
Number of payer life.  
Initial value : 5
When player get hitting, this value minus 1.

### recoverFlag:
Flag of recovering.  
Initial value : 0  
If recoverFlag = 0, player can recover 1 muscle. After use recover item, this flag = 1.  
 
### Dev32 PIN MAP

<img src="https://github.com/totovr/SuperHuman/blob/master/Images/esp32_pinmap.png" width="600">
