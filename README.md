# Git-describe for Arduino

This script provides an automatic versioning system for Arduino sketches based on git commit ID. This approach guarantees a strong relationship between source code and the compiled firmware. Moreover, it will enforce the developer to maintain meaningful tags during the project development.

- **Note:** Forked from the excellent [repository](https://github.com/fabianoriccardi/git-describe-arduino) by [Fabiano Riccardi](https://github.com/fabianoriccardi/)

## Features

- it defines the constant GIT_VERSION, visible in your source code, containing version details
- No extraordinary hacking to Arduino IDE
- Available for Window and Linux

## Requirements

- Arduino IDE 1.8.9, 1.8.11 or newer
- Git

> NOTE: on Arduino IDE 1.8.10 the script doesn't work because a regression bug. I didn't test this method on versions older than 1.8.9.

## Installation
  
  1. Clone this repository (e.g. you may locate it inside `/path/to/arduino-workspace/tools/`).
     ```
     git clone https://github.com/tstana/git-version-arduino.git
     ```

  2. **On Linux**, make script executable:  
     ```
     cd /path/to/arduino-workspace/tools/git-describe-arduino
     chmod 755 git-version.sh
     ```
    
     (no need to modify global path)  
     
     **On Windows**, add git-version.bat to global path:
     - Open _Start Menu_
     - Bring up **Control Panel**
     - Search for _Edit the system environment variables_
     - Click **Environment variables...**
     - Select the **Path** variable under _System variables_
     - Click **Edit...** 
     - **Browse** to where you cloned the repo, e.g., `/path/to/arduino-workspace/tools/` (alternatively: copy & paste from an Explorer window)
     - **OK**/**OK**/**OK** until environment variable windows are closed

  3. Add this script to prebuild hooks of Arduino toolchain. Create if it does not exist the file `platform.txt` inside `/path/to/arduino-application/hardware/`. On Windows, append the following line:
     ```
     recipe.hooks.sketch.prebuild.1.pattern=git-version.bat "{build.source.path}"
     ```  
     On Mac/Linux, append the following line:  
     ```
     recipe.hooks.sketch.prebuild.1.pattern=/path/to/arduino-workspace/tools/git-version.sh "{build.source.path}"
     ```

## Usage

To configure your sketch you need to complete few steps:

  1. If your repository is not under git, initialize a reposititory for the sketch and do the first commit.
  2. Modify your sketch to include `git-version.h` and print the current version. Example:
      
     ```cpp
     #include "git-version.h"

     void setup()
     {
       Serial.begin(115200);
       Serial.println();
       Serial.print("Git version: ");
       Serial.println(GIT_VERSION);
     }

     void loop()
     {
       // put your main code here, to run repeatedly: 
     }
     ```

  3. Compile and upload to see the result. Happy versioning!

NOTE: GIT_VERSION is a string several (usually, 6-8) characters long comprising the ID of the latest Git commit, e.g.:

- `916a4b9`
