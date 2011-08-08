
// Oct 2009
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


float _a, _b, _centx, _centy, _x, _y;
int _num = 12;
color _col;
float _noiseoff;
int _angle;

void setup()
{
  size(500, 300);
  smooth(); 
  frameRate(12);
  background(0);
  
  _centx = (width / 2);
  _centy = (height / 2);
  _noiseoff = random(1);
  
  _col = color(random(25)+230, random(25)+230, random(25)+230);
  _angle = 1;
  
  restart();
}

void restart() {
   _noiseoff = _noiseoff + .001;
   _a = (noise(_noiseoff) * 40);
   _b = _a + (noise(_noiseoff) * 10) - 5;
   _angle++;
   if (_angle == 360) { _angle = 0; }
  // println(_angle + " : " + _a + " : " + _b);
}


void clearBackground() {
  background(0);
}

void draw() {
  clearBackground();
  
  translate(_centx, _centy);
  noFill();
 stroke(255);
  strokeWeight(0.3);
  float lastx = -999;
  float lasty = -999;
  for (int i=0 ;i < 720; i += 1) {    
    _x = sin(_a * i + radians(_angle) + PI / 2) * 230;  
    _y = sin(_b * i + radians(_angle)) * 140; 
    if (lastx != -999) {
     line(_x, _y, lastx, lasty);
    }
    lastx = _x;
    lasty = _y;
  }
  restart();
}
