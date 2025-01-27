# Home Security System

## Objective

The **Home Security and Fire Alarm System** is a Verilog-based project that combines advanced security features and fire detection capabilities to ensure the safety of a home or building. The system is equipped with functionalities like password protection, fire detection (temperature and smoke monitoring), and automated room management (AC and light control based on human presence) to offer a comprehensive and efficient solution.

## Features of the System

### 1. Password Protection and Security
- Password is securely stored in ROM (Read-Only Memory).
- Allows the user to input a 4-digit password for authentication.
- **Correct Password**: Unlocks the door.
- **Incorrect Password**: Triggers an alarm.
- **Password Retry Limitation**: After 3 incorrect attempts, the system triggers a security alarm to prevent brute-force attacks.

### 2. Fire Detection
- Monitors **smoke levels** in the environment.
- **Fire Alarm Trigger**: If smoke level exceed predefined threshold values, the system activates the fire alarm.

### 3. Door Control System
- Automatically closes the door after **2 minutes** if it remains open to enhance security and ensure safety.

### 4. Human Presence Detection
- Detects human presence in the room:
  - If **human is present** and **temperature > 30°C**:
    - Automatically turns on the **AC** for comfort.
  - If **no human is present**:
    - Turns off **AC** to conserve energy.

## How It Works
1. **Authentication**: 
   - User inputs the password for authentication.
   - Password is verified against the one stored in ROM.
2. **Fire Monitoring**:
   - Continuously monitors smoke levels.
   - Alerts the system and triggers the alarm if thresholds are crossed.
3. **Room Automation**:
   - Automatically manages AC based on human presence and temperature.

## Project Implementation
This project is implemented in **Verilog**, utilizing a hardware description language to ensure accurate control and monitoring of each feature. 

## Contact

I'm here to assist you on your journey with the SnaCake - A Snake and Cake Game. If you need help or want to share feedback, feel free to reach out to me at [israttasnimesha1046@gmail.com](mailto:israttasnimesha1046@gmail.com).

## Author

**Israt Tasnim Esha**  
**CSE 4224	- Digital System Design Laboratory**  
*Department of Computer Science and Engineering*  
*Khulna University of Engineering and Technology*      
**Year:** 2024
