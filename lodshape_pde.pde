//import processing.sound.*; //<>// //<>//

Audio file = new Audio();
Audio file1 = new Audio();
Audio file2 = new Audio();

//SoundFile file, file1, file2;

PImage s, s1, s2, s3, s4, s5, s6, s7, s8, s9, breadImageNumber;


// some buttons
int[][] buttons = { {300, 240}, {350, 240}, {300, 485}, {350, 485}};
//int[][]startButton = {{800, 240}};
int[][] filamentRods = {{350, 161}, {365, 511}, {405, 179}, {405, 466}};
int door[] = {508, 136};
int doorX = 230;
int doorY = 10;
int filament1[] = {580, 8};
int filament2[] = {480, 8};
int powerOn[]= {10, 100};
int startButton[]= {890, 230};
int preheat[]={890, 430};
int heatingMode[] = {300, 300};
int items[] = {10, 200};
int shadeControl[] = {300, 370};
int temperature[] = {300, 430};
int buttonX = 40;
int buttonY = 40;
int preheatX = 95;
int preheatY = 40;
int startButtonX = 95;
int startButtonY = 40;
int heatingModeX = 95;
int heatingModeY = 40;
int temperatureX = 90;
int temperatureY = 40;
String startOptions[] = {"START", "PAUSE", "DONE"};
String modes[] = {"Mode", "TOAST", "BAGEL", "BAKE", "BROIL", "PIZZA", "CONV."};
//String itemName[] = {"<Pick>", "Bread", "Chicken"};
String itemName[] = {"Bread"};
String shade[] = {"Shade", "LIGHT", "MEDIUM", "DARK"};
int mode = 0;
int item = 0;
int shadeChoice = 0;
boolean modeFlag = false;
boolean powerFlag = false;
boolean start = false;
boolean timerFlag = false;
boolean paused = true;
boolean temperatureFlag =false;
int mousepressed = 0;
int pausedTime = 0;
boolean isPaused = false;
boolean loadBread = false;
boolean isPreheat = false;


float frGreen = 255;

//triangle() Triangle1, Triangle2;
int currentTime;
boolean doneToasting = false;
boolean doorOpen = false;


//int minutes = inputTime -1;
int seconds;
int reset = 60;
int x, y, startTime, total, display;

PFont f;

int inputTime;

int fahrenheit;
float roomTempFahrenheit;

HashMap<String, Integer> hm = new HashMap<String, Integer>();

void temperatureSet(){
  
  hm.put("toastlight",fahrenheit+10);
  hm.put("toastmedium",fahrenheit+20);
  hm.put("toastdark", fahrenheit+30);
  hm.put("bagellight",fahrenheit+40);
  hm.put("bagelmedium",fahrenheit+50);
  hm.put("bageldark", fahrenheit+60);
  hm.put("bakelight",fahrenheit+70);
  hm.put("bakemedium",fahrenheit+80);
  hm.put("bakedark", fahrenheit+90);
  hm.put("broillight",fahrenheit+100);
  hm.put("pizzamedium",fahrenheit+110);
  hm.put("pizzadark", fahrenheit+120);
  hm.put("pizzadark", fahrenheit+130);
}

int getTemperature(){
  if(mode != 0 && shadeChoice != 0){
    String tempVariable = (modes[mode] + shade[shadeChoice]).toLowerCase();
    println(tempVariable);
    return hm.get(tempVariable);
  }
  return fahrenheit;
}

int fahrenheit_Celsius(int f) {
  return round((f-32) * 5/9);
}

void loadSounds(){
  file.setAttribute("src", "toaster-oven-ding.mp3");
  file1.setAttribute("src", "openDoor.mp3");
  file2.setAttribute("src", "closeDoor.mp3");

}


int timerSeconds() {
  if (start == true) {
    println(round(display));
    if (round(display) == 1) {
      file.play();
      
      //text(text[2],960,240);
    }
    display = total - startTime + inputTime * 60;
    seconds = display%60;
    //println(display);
    if (seconds>=0)
      return floor(seconds);
    else return 0;
  } else return 0;
}

int timerMinutes() {
  int minutes = display/60;
  //println("Minutes=",minutes);
  return floor(minutes);
}

void colorFill() {
  if (isPreheat == true && roomTempFahrenheit < fahrenheit) { 
    frGreen = frGreen - 1;
    //fill(255, frGreen, frGreen);
    roomTempFahrenheit = roomTempFahrenheit + 0.25;
    //println("FrGreen=", frGreen);
  }
}


/* @pjs font="custom.ttf"; */
void setup() {
  size(1280, 800);
  
  // The file "bot.svg" must be in the data folder
  // of the current sketch to load successfully
  s = loadImage("ToasterOvenOff.png");
  s1 = loadImage("DoorClosedOff.png");
  s2 = loadImage("ToasterOvenOn2.png");
  s3 = loadImage("DoorClosedOn.png");
  s4 = loadImage("DoorOpenOff.png");
  s5 = loadImage("DoorOpenOn.png");
  s6 = loadImage("slice-of-bread-normal.png");
  s7 = loadImage("slice-of-bread-light.png");
  s8 = loadImage("slice-of-bread-medium.png");
  s9 = loadImage("slice-of-bread-dark.png");
  f = loadFont("custom.ttf");
  inputTime = 0;
  fahrenheit = 105;
  roomTempFahrenheit = int(random(68,77));
  temperatureSet();
  //println(PFont.list());
  loadSounds();

  //file = new SoundFile(this, "toaster-oven-ding.wav");
  //file1 = new SoundFile(this, "openDoor.mp3");
  //file2 = new SoundFile(this, "closeDoor.mp3");
}

void draw() {
  String timeStringMinutes, timeStringSeconds;

  background(0);
  fill(127);
  rect(powerOn[0], powerOn[1], 70, 70, 7);
  fill(255);
  textFont(f);
  textSize(35);
  textAlign(CENTER);
  //to update input time on increment decrement
  //total = x + inputTime *60;

  //image(s6, 400, 300, 200, 100);

  if (powerFlag == true) {
    fill(127);
    rect(items[0], items[1], 150, 40, 7);
    //text(itemName[item], 80, 230);
    fill(0, 255, 0);
    text("On", 45, 145);
    text("Bread", 80, 230);

  } else text("Off", 45, 145);
  startTime= millis()/1000;
  if (start==false) {
    image(s, 220, 100, 850, 500);
    if (loadBread == true)
      image(s6, 550, 275, 200, 100);
    if (doorOpen == false) 
      image(s1, 280, 130, 720, 420);
    else image(s4, 200, 560, 880, 200);
  } else {
    image(s2, 220, 100, 850, 500);
    if (loadBread == true)
      image(s6, 550, 275, 200, 100);
    if (doorOpen == false)
      image(s1, 280, 130, 720, 420);
    else image(s5, 200, 560, 880, 200);
  }

  if (powerFlag == true) {
    
    if (doorOpen == false) {
      //if(frGreen >= 0) colorFill();
      if(isPreheat == true){
      colorFill();
      fill(255, frGreen, frGreen);
      }else fill(0);
     
      rect(preheat[0], preheat[1], preheatX, preheatY,7);
      
      fill(255, frGreen, frGreen);
      rect(filamentRods[0][0], filamentRods[0][1], filament1[0], filament1[1], 10);
      rect(filamentRods[1][0], filamentRods[1][1], filament1[0], filament1[1], 10);
      rect(filamentRods[2][0], filamentRods[2][1], filament2[0], filament2[1], 10);
      rect(filamentRods[3][0], filamentRods[3][1], filament2[0], filament2[1], 10);
      fill(0);
      for (int loopCounter=0; loopCounter < buttons.length; loopCounter++)
        rect(buttons[loopCounter][0], buttons[loopCounter][1], buttonX, buttonY, 7);

      rect(startButton[0], startButton[1], startButtonX, startButtonY, 7);
      rect(heatingMode[0], heatingMode[1], heatingModeX, heatingModeY, 7);
      rect(shadeControl[0], shadeControl[1], heatingModeX, heatingModeY, 7);
      rect(temperature[0], temperature[1], temperatureX, temperatureY, 7);
      
      //colorFill();
      //fill(255, frGreen, frGreen);
      //rect(preheat[0], preheat[1], preheatX, preheatY,7);
  
      fill(127);
      

      fill(255);
      triangle(310, 270, 320, 250, 330, 270);
      triangle(360, 250, 370, 270, 380, 250);
      triangle(310, 515, 320, 495, 330, 515);
      triangle(360, 510, 370, 490, 380, 510);
      triangle(360, 520, 370, 500, 380, 520);


      fill(255);
      triangle(410, 315, 420, 305, 410, 315);
      //triangle(360, 515, 370, 495, 360, 515);
      //triangle(360, 525, 370, 505, 360, 525);

      fill(0);
      rect(300, 190, 100, 30, 7);

      fill(0, 255, 0);
      textAlign(CENTER);
      //timerMinutes();

      if (timerFlag == false && isPaused == false) {
        timeStringMinutes = str(hour());
        timeStringSeconds = str(minute());
      } else {
        timeStringMinutes = str(inputTime);
        timeStringSeconds = "00";
      }

      if (start == false) {
        text(startOptions[0], 940, 260);                                      
      } else if (start == true) {
        if (frGreen >= 0) colorFill();
        fill(255, 0, 0);
        if (display > 0)
          text(startOptions[1], 940, 260);
        else {
          fill(0, 255, 0);
          text(startOptions[2], 940, 260);
        }

        if (timerMinutes() >= 0) {
          timeStringMinutes = "0" + str(timerMinutes());
          if (seconds < 10) {
            timeStringSeconds = "0" + str(timerSeconds());
          } else { 
            timeStringSeconds = str(timerSeconds());
          }
        } else {
          timeStringMinutes = "00";
          if (seconds != 0) {
            if (seconds < 10) {
              timeStringSeconds = "0" + str(timerSeconds());
            } else {
              timeStringSeconds = str(timerSeconds());
            }
          } else {
            timeStringSeconds = "00";
            if (display == 0)
            {
              text(startOptions[2], 940, 260);
            }
          }
        }
      }
      fill(0, 255, 0);
      text(timeStringMinutes, 325, 215);
      text(":", 350, 215);
      text(timeStringSeconds, 375, 215);
      //if(modeFlag==true)
      //{
      text(modes[mode], 345, 330);
      text(shade[shadeChoice], 345, 400);
      
      if (temperatureFlag == false) {
        text(fahrenheit, 335, 460);
        text("F", 370, 460);
        text(floor(roomTempFahrenheit), 925, 460);
        text("F", 960, 460);
      } else {
        //text("|", 395, 470);
        text(fahrenheit_Celsius(fahrenheit), 335, 460);
        text("C", 370, 460);
        text(fahrenheit_Celsius(floor(roomTempFahrenheit)), 925, 460);
        text("C", 960, 460);
      }
    }
  }

  if (doorOpen == false) {
    fill(100);
    rect(door[0], door[1], doorX, doorY, 7);
  }
}



void mouseReleased() {

  if ((mouseX > powerOn[0]) && (mouseX < powerOn[0]+50)
    &&(mouseY > powerOn[1]) && (mouseY < powerOn[1]+50))
  {
    //modeFlag = !modeFlag;
    powerFlag = !powerFlag;
    if (powerFlag == false) {
      start = false;
    }
  }
  if ((mouseX > startButton[0]) && (mouseX < startButton[0]+startButtonX)
    &&(mouseY > startButton[1]) && (mouseY < startButton[1]+startButtonY)) {
   
      mousepressed ++;
      if(mousepressed%2 != 0){
       isPaused = true;
      }
    //store the starttime when the button is pressed
    int startt = startTime; 
    start = !start;
    file.play();
    
    timerFlag = false;
    if (start==true) {
      total = startt + pausedTime;
    }else{
      pausedTime = total - startt;     
    }        
  }

  if ((mouseX > buttons[0][0]) && (mouseX < buttons[0][0]+buttonX)
    &&(mouseY > buttons[0][1]) && (mouseY < buttons[0][1]+buttonY))
  {
    timerFlag = true;
    inputTime++;
  }
  if ((mouseX > buttons[1][0]) && (mouseX < buttons[1][0]+buttonX)
    &&(mouseY > buttons[1][1]) && (mouseY < buttons[1][1]+buttonY)) {
    //selectedOne = loopCounter;
    timerFlag = true;
    inputTime--;
    //playBeep();
  }
  if ((mouseX > heatingMode[0]) && (mouseX < heatingMode[0]+90)
    &&(mouseY > heatingMode[1]) && (mouseY < heatingMode[1]+40))
  {
    //modeFlag = !modeFlag;
    mode++;
    mode = mode%7;
    fahrenheit = getTemperature();
  }
  if ((mouseX > items[0]) && (mouseX < items[0]+150)
    &&(mouseY > items[1]) && (mouseY < items[1]+40))
  {
    //item++;
    //item = item%3;
    loadBread = !loadBread;
    //loadBread();
      //if (loadBread == true)
    //image(s6, 400, 300, 200, 100);
    
  }
  if ((mouseX > shadeControl[0]) && (mouseX < shadeControl[0]+90)
    &&(mouseY > shadeControl[1]) && (mouseY < shadeControl[1]+40))
  {
    shadeChoice++;
    shadeChoice = shadeChoice%4;
    fahrenheit = getTemperature();
  }
  if ((mouseX > temperature[0]) && (mouseX < temperature[0]+temperatureX)
    &&(mouseY > temperature[1]) && (mouseY < temperature[1]+temperatureY))
  {
    temperatureFlag = !temperatureFlag;
  }
  if ((mouseX > buttons[2][0]) && (mouseX < buttons[2][0]+buttonX)
    &&(mouseY > buttons[2][1]) && (mouseY < buttons[2][1]+buttonY))
  {
    fahrenheit = fahrenheit + 10;
  }
  if ((mouseX > buttons[3][0]) && (mouseX < buttons[3][0]+buttonX)
    &&(mouseY > buttons[3][1]) && (mouseY < buttons[3][1]+buttonY))
  {
    fahrenheit = fahrenheit + 50;
  }
  if ((mouseX > door[0]) && (mouseX < door[0]+doorX)
    &&(mouseY > door[1]) && (mouseY < door[1]+30))
  {
    file1.play();
    doorOpen = true;
    if (doorOpen ==false) start = false;
  }
  if (mouseX > 500 && mouseX < 900
    && mouseY > 700 && mouseY < 800)
  {
    file2.play();
    doorOpen = false;
  }
  if ((mouseX > preheat[0]) && (mouseX < preheat[0]+preheatX)
  &&(mouseY > preheat[1]) && (mouseY < preheat[1]+preheatY))
  {
    isPreheat = !isPreheat;
    //println("\n isPreheat: ", isPreheat);
  }
  
}