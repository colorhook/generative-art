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

// import traer.physics.*; 
// import processing.opengl.*;


int _width = 500;  
int _height = 300;

HPoint[] _pointArr = {};
int _num = 1000;    

Sphere _theSphere;
int _maxRad = 100;

void setup() {
  size(_width, _height, P3D);
  clearBackground();
  sphereDetail(15);
  
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
 for (int x = 0; x <= _num; x++) {
   float noiseFactor = ((noise(s/100, t/100)) * 2) - 1;
    HPoint thisPoint = new HPoint(radians(s), radians(t));
    _pointArr = (HPoint[])append(_pointArr, thisPoint);
    
    s += 10;
    t++; 
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
  translate(_width/2, _height/2, 0);
  rotateY(frameCount * 0.01);
  rotateX(frameCount * 0.02);
  
  // draw
  for (int y = 0; y < _pointArr.length; y++) {
    stroke(255, 150);    
    HPoint fromHP = _pointArr[y];
    if (y > 0) {
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
  int mySphere, count, countDir;
  Sphere myS;
  color col;
  float radNoise;
  
  HPoint(float es, float tee) {
    s = es; t = tee;
    
    count = 0;
    countDir = 1;
    
    myS =_theSphere;
    
    col = myS.col;
    radNoise = s * t;
    myS.pointArr = (HPoint[])append(myS.pointArr, this);
  }
  
  void update() {
    radNoise += 0.01;
    float thisRad = myS.radius;
    count += countDir;
    if (count > 800) { countDir = -1; }
    if (count < -800) { countDir = 1; }
    thisRad += (noise(radNoise) * (count/2));
    
    x = myS.x + (thisRad * cos(s) * sin(t));
    y = myS.y + (thisRad * sin(s) * sin(t));
    z = myS.z + (thisRad * cos(t));
  } 
}

