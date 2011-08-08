
// Feb 2009
// http://www.abandonedart.org
// http://www.zenbullets.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://www.zenbullets.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// These conditions can be waived if you want to do something groovy with it 
// though, so feel free to email me via http://www.zenbullets.com


//================================= global vars

int _num = 8;    
Circle[] pArr = new Circle[_num];

//================================= init

void setup() {
  size(500, 300);
  smooth(); 
  frameRate(30);
  
  clearBackground();
  
  for (int i=0;i<_num;i++) {
    pArr[i] = new Circle(i);
    pArr[i].init(width/2, height/2, random(height/2));
  }
}

void clearBackground() {
  background(255);
}

//================================= frame loop

void draw() {
  
  for (int i=0;i<_num;i++) {
    pArr[i].update();
  }
  
  fill(200,0,0);
  noStroke();
  rect(0, (height/2)-25, width, 50);
}



//================================= interaction

void mousePressed() { 
  clearBackground();
  for (int i=0;i<_num;i++) {
    pArr[i].init(mouseX, mouseY, random(height/2));
  }
}


//================================= objects


class Circle {
  int id;
  float angnoise, radiusnoise;
  float widnoise, heinoise;
  float angle = 180;
  float radius = 100;
  float centreX = width/2;
  float centreY = height/2;
  float strokeCol = 254;
  float lastX = 9999;
  float lastY, lastAng;
  
  Circle (int num) {
    id = num;
    // init();
  }
  
  void trace(String str) {
    println("Particle " + id + ": " + str);
  }
  
  void init(float ex, float why, float r) {
    trace("init");
    centreX = ex;
    centreY = why;
    radius = r;
  
    angnoise = random(10);
    radiusnoise = random(10);
    widnoise = random(10);
    heinoise = random(10);
    strokeCol = 254;
  }
  
  void update() {
    radiusnoise += 0.005;
    radius = (noise(radiusnoise) * (width/1.5));
  
    angnoise += 0.005;
    angle += (noise(angnoise) * 6) - 3;
    if (angle > 360) { angle -= 360; }
    if (angle < 0) { angle += 360; }
    
    widnoise += 0.05;
    float wid = (noise(widnoise) * 12);
  
    float rad = radians(angle);
    float x1 = centreX + (radius * cos(rad));
    float y1 = centreY + (radius * sin(rad));
    
    float diff = abs(angle-lastAng);
    strokeCol = diff * 150;
    
    if (strokeCol > 250) {
      noStroke();
    } else {
      stroke(strokeCol);
    }
    strokeWeight(wid);
    if (lastX != 9999) {
      line(x1, y1, lastX, lastY);
    }
    lastX = x1;
    lastY = y1;
    lastAng = angle;
  }
  
}