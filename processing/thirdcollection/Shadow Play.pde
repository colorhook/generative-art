// Nov 2009
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

Bubble[] _growArr = {};
Bubble[] _allArr = {};

//================================= init

void setup() {
  size(500, 300);
  smooth(); 
  restart();
}

void restart() {
  _growArr = (Bubble[])expand(_growArr, 0); 
  _allArr = (Bubble[])expand(_allArr, 0); 
}

void mousePressed() {
  restart();
}

//================================= frame 

void draw() {
  fill(255, 5);
  noStroke();
  rect(0,0,width, height);
  
  // grow
  for (int x=0; x < _growArr.length; x++){
    _growArr[x].growMe();
  }
 // create a few new ones
 Bubble newBubb = new Bubble();
 _growArr = (Bubble[])append(_growArr, newBubb); 
 _allArr = (Bubble[])append(_allArr, newBubb); 

 // draw them 
  for (int x=0; x < _allArr.length; x++){
    _allArr[x].drawMe();
  }
}

//================================= object

class Bubble {
  float radius, x, y;
  
  Bubble() {
    radius = 0.5;
    boolean touching = true; 
    while(touching) {
      x = random(width);
      y = random(height);
      touching = checkTouching(this);
    }
  }
  
  void growMe() {
    radius += 0.5;
    // check overlap
    if (checkTouching(this)) {
       stopGrowing(this); 
    }
  }

  void drawMe() {
    float diam = radius * 2;
    stroke(0, 180);
    fill(255, 20);
    strokeWeight(0.5);
    ellipse(x, y, diam, diam); 
  }
}

//================================= object mgmt

void stopGrowing(Bubble bubb) {
   // remove from _growArr 
   Bubble[] tempArr = {};
   for (int x=0; x < _growArr.length; x++){
     if (_growArr[x] != bubb) {
       tempArr = (Bubble[])append(tempArr, _growArr[x]); 
     }
   }
   _growArr = tempArr;
}

boolean checkTouching(Bubble bubb) {
  for (int x=0; x < _allArr.length; x++){
    Bubble otherBubb = _allArr[x];
    if (otherBubb != bubb) {
      if (isOverlap(bubb, otherBubb)) { 
        return true; 
      }
    }
  }
  return false;
}

boolean isOverlap(Bubble bubb1, Bubble bubb2) {
  float diff = dist(bubb1.x, bubb1.y, bubb2.x, bubb2.y);
  float olap = diff - bubb1.radius - bubb2.radius;
  if (olap > -10) {
    stroke(0, 2);
    noFill();
    ellipse(bubb1.x, bubb1.y, olap, olap);
    return false;
  } else {
    return true;
  }
}

