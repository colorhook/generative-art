// Aug 2009
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

float toplen, botlen;
int numlines = 1200;
float centX, centY;
float topNoise, botNoise;

void setup() {
  size(500, 300);
  smooth();
  centX = width/2;
  centY = height/2;
  stroke(0, 150);
  topNoise = random(10);
  botNoise = random(10);
}

void draw() {
  background(255);
  topNoise += 0.005;
  botNoise += 0.005;
  botlen = width + (noise(topNoise) * 1500);
  toplen = width + (noise(botNoise) * 1500);
  float topStep = toplen / numlines;
  float botStep = botlen / numlines;
  float topx = centX - (toplen/2);
  float botx = centX - (botlen/2);
  for (int t = 0; t < numlines; t++) {
    line(topx, 10, botx, 290);
    topx += topStep;
    botx += botStep;
  }
  fill(255, 0, 0, 50);
  rect(0, 0, width, 10);
  rect(0, 290, width, 10);
}
