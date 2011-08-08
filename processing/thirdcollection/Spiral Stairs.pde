
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


float _xnoise, _ynoise;
int _timeToNext = 25;
float x, y;

void setup() {
  size(500,300);
  background(255);
  strokeWeight(0.5);    
  strokeCap(SQUARE);
  smooth(); 
  frameRate(6);
  _xnoise = random(10);
  _ynoise = random(10);
}


void draw() {  
  fill(255, 5);
  noStroke();
  rect(0,0,width, height);
  
  // wobble centre
  _xnoise += 0.01;
  _ynoise += 0.01;
  float centreX = width/2 + (noise(_xnoise) * width/2) - 100;
  float centreY = height/2 + (noise(_ynoise) * height/2) - 100;

  float lastx = centreX;
  float lasty = centreY;
  float radiusNoise = random(10);
  float radius = 10;
  color sc = color(random(20), random(50), random(70));
  float alph = 255;
  int startangle = int(random(360));       
  int anglestep =  5 + int(random(3));  
  color fc = color(150+random(10), 150+random(10), 150+random(70));
  fill(fc, 17);
  
  beginShape();
  for (float ang = startangle; ang <= startangle + 1080; ang += anglestep) {    
    radiusNoise += 0.05;
    radius += 1;
    float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
    float rad = radians(ang);
    x = centreX + (thisRadius * cos(rad));
    y = centreY + (thisRadius * sin(rad));
    stroke(sc, alph);
    curveVertex(x,y);
    if (_timeToNext == 0) {
      if (lastx > -999) {
        stroke(0, alph);
        strokeWeight(noise(radiusNoise) * 9);
        line(x,y,lastx,lasty);
      }
    }
    if (_timeToNext < 5) {
      stroke(0, _timeToNext * 5);
      strokeWeight(0.3);
      line(x,y,centreX,centreY);
    }
    lastx = x;
    lasty = y;  
    if (alph > 0) { 
        alph--; 
    } else {
        alph = 0;
        break; 
    }    
  }
  stroke(sc, 0);
  strokeWeight(0.1);
  vertex(centreX, centreY);
  endShape();
    
  if (_timeToNext == 0) {
    _timeToNext = 10 + int(random(25));
  }
  _timeToNext--;
}



