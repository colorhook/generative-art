
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

float margin = 100;

float xnoise, ynoise, znoise;
float xstart, ystart, zstart;
float seednoise, zoom;

//================================= init

void setup() {
  size(500, 300, P3D);
  frameRate(12);
  
  xstart = 0;
  ystart = 0;
  zstart = 0;
  seednoise = random(1);
  zoom = 0;
  
  noStroke();
}


void clearBackground() {
  background(170);
}

//================================= frame loop


void draw() {
  clearBackground();
  
  seednoise += 0.01;
  if (zoom > -1600) { zoom -= 4; }
  
  // Center and spin
  translate(width/2, height/2, zoom);
  rotateY(frameCount * 0.02);
  rotateX(frameCount * 0.01);
  rotateZ(frameCount * 0.005);
  
  xstart = noise(seednoise) * 10;
  ystart = xstart;
  zstart = ystart;
  
  xnoise = xstart;
  float inc = 0.1;

  // Build grid using multiple translations 
  for (float i =- 900+margin; i <= 900-margin; i += margin){
    pushMatrix();
    xnoise += inc;
    ynoise = ystart;
    for (float j =- 900+margin; j <= 900-margin; j += margin){
      pushMatrix();
      ynoise += inc;
      znoise = zstart;
      for (float k =- 300+margin; k <= 600-margin; k += margin){
        pushMatrix();
        znoise += inc;
        
        float boxSize = noise(xnoise, ynoise, znoise) * 255;
        float gr = 255 - boxSize;

        float alph = boxSize;
        if (alph > 100) {
          translate(k, j, i);
           if (alph > 150) {
              fill(255, 35);
           } else {
              fill(20, gr + 50, 200, 35);
           }
          box(boxSize, boxSize, boxSize);
        }
        
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
  
  
         translate(150, 0, 0);
         stroke(255,  70);
         noFill();
         box(850, 1800, 1800);
         noStroke();
}

