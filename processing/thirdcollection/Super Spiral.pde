// Feb 2010
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


int range, rangeStep;

HPoint[] _pointArr = {};
int _num = 2000;    

Sphere _theSphere;
int _maxRad = 100;

void setup() {
  size(500, 300, P3D);
  clearBackground();
  
  range = 2000;
  rangeStep = 1;
  _theSphere = new Sphere(0, 0, 0);
  newPoints();
  
}

void clearBackground() {
  background(0);
}

void newPoints() {
 _pointArr = (HPoint[])expand(_pointArr, 0); 
 float s = 0;
 float t = 0;
 
 float lineNoise = random(10);
 float waveNoise = random(10);
 
 for (int x = 0; x <= _num; x++) {
   float noiseFactor = ((noise(s/100, t/100)) * 2) - 1;
    
    lineNoise += 0.5;
    waveNoise += 0.01;
    float lineW = noise(lineNoise) * 6;
    
    HPoint thisPoint = new HPoint(radians(s), radians(t), lineW, waveNoise);
    _pointArr = (HPoint[])append(_pointArr, thisPoint);
    
    s += 13;
    t += 4; 
    
  }
}

void draw() {
  clearBackground();
  
 _theSphere.update();
  for (int x = 0; x < _pointArr.length; x++) {
    HPoint thisHP = _pointArr[x];
    thisHP.update();
  }  
  
  pushMatrix();
  range += rangeStep;
  if ((range > 6000) || (range < 1000)) { rangeStep *= -1; }
  println(range);
  
  translate(width/2, height/2, -range);
  rotateY(frameCount * 0.003);
  rotateX(frameCount * 0.004);
  
  // draw
  for (int y = 0; y < _pointArr.length; y++) {
        
    HPoint fromHP = _pointArr[y];
    if (y > 0) {
      strokeWeight(fromHP.lineW);
      stroke(255, 255 - (fromHP.lineW * 25));
      HPoint toHP = _pointArr[y - 1];
      line(fromHP.x, fromHP.y, fromHP.z, toHP.x, toHP.y, toHP.z);
    }
  }
  
  popMatrix();
}

class Sphere {
  float radius, radNoise;
  color col;
  float x, y, z;
  HPoint[] pointArr = {};
  
  Sphere(float ex, float why, float zed) {
     radNoise = random(10); 
     x = ex;
     y = why;
     z = zed;
     col = color(255, 0, 0);
  }
  
  void update() {
    radius = _maxRad;
  } 
}

class HPoint {
  float s, t;
  float x, y, z;
  int mySphere;
  Sphere myS;
  color col;
  float radNoise;
  
  float lineW;
  float lineSeed;
  float waveSeed;
  
  HPoint(float es, float tee, float lw, float ws) {
    s = es; t = tee;
    lineSeed = lw;
    lineW = lw;
    waveSeed = ws;
    
    myS =_theSphere;
    col = myS.col;
    radNoise = s * t;
    myS.pointArr = (HPoint[])append(myS.pointArr, this);
  }
  
  void update() {
    radNoise += 0.01;
    waveSeed += 0.01;
    
    float thisRad = (myS.radius * (radNoise/1000));
    lineW = lineSeed * thisRad/1000;
    
    x = myS.x + (thisRad * cos(s) * sin(t));
    y = myS.y + (thisRad * sin(s) * sin(t));
    z = myS.z + (thisRad * cos(t));
  } 
}



