
// Apr 2009
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

import processing.opengl.*;

float _noiseSeed, _noiseInc;
float _yRot = 90;
float _xRot = 90;
float _rotNoise, _zoomNoise;
int _r, _g, _b;


//================================= init

void setup() {
  size(500, 300, OPENGL);
  smooth(); 
  frameRate(24);

  _rotNoise = random(10);
  _zoomNoise = random(10);
  restart();
}

void restart() {
   _noiseSeed = random(10);
   _noiseInc = random(0.01); 
   _r = int(random(255));
   _g = int(random(255));
   _b = int(random(255));
}

//================================= frame loop

void draw() {
  
  if (frameCount % 50 == 0) {  restart(); }
  _noiseInc += 0.0001;
  
  translate(350, 300, - 100 - (noise(_zoomNoise) * 250));
  _rotNoise += 0.005;
  _zoomNoise += 0.005;
  rotateY(_yRot + (noise(_rotNoise) * 15));
  rotateX(90);
  
  background(0);
  
  float rad;
  float noiseFactor = _noiseSeed;
  
  strokeWeight(5);
  stroke(_r, _g, _b, 50);
  for (float x = 0; x <= 300; x += 0.25) {
    pushMatrix();
    fill(0, 150);
    translate(0, 0, x);
    rad = 100 + (noise(noiseFactor) * 200); 
    noiseFactor += _noiseInc;
    ellipse(0, 0, rad, rad);
    popMatrix();
  }
}



//================================= interaction

void mousePressed() { 
  restart();
}
