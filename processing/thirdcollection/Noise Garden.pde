// Sep 2009
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

float xoff = 0; 
float yoff = 0;
float driftXN = 0; 
float driftYN = 0; 

void setup() {
  size(500,300);
  frameRate(12);
  smooth();
  background(255);
  drawGrid();
}

void draw() {
  fill(255,5);
  noStroke();
  rect(0,0,width, height);
  driftXN += 0.01;
  driftYN += 0.01;
  xoff += (noise(driftXN) * 0.2) - 0.1;
  yoff += (noise(driftXN) * 0.2) - 0.1;
  drawGrid();
}


void drawGrid() {
  pushMatrix();
  translate(250,150);
  float inc = 0.02;
  float xnoise = xoff + inc;
  float ynoise = yoff + inc;
  for (int y = -100; y < 100; y+=4) {
    for (int x = -100; x < 100; x+=4) {
      drawShape(x, y, 0, 0, noise(xnoise,ynoise));
      xnoise += inc;
    }
    xnoise = xoff + inc;
    ynoise += inc;
  }
  popMatrix();
}

void drawShape(float x, float y, float wid, float hei, float factor) {
  stroke(int(factor *60), int(factor *180), int(factor *255), 50);
  pushMatrix();
  translate(x, y);
  int rot = int(factor * 720);
  rotate(radians(rot));
  line(0, 0, 600, 0);
  popMatrix();
}