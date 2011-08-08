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


float radius = 100;
int centX = 250;
int centY = 150;
float startNoise, noiseStep;

// float eyeRootx, eyeRooty, eyeXnoise, eyeYnoise;
// float eyeDistRootX, eyeDistRootY, eyeDistXnoise, eyeDistYnoise;

void setup () {
  size(500,300);
  background(255);
  strokeWeight(5);
  smooth();
  frameRate(12);
  
  stroke(0, 30);
  noFill();
  ellipse(centX,centY,radius*2,radius*2);
  
  startNoise = random(10);
  noiseStep = 0.1;
  
 /*  eyeRootx = (width/2) - 50;
  eyeRooty = height/2;
  eyeXnoise = random(10);
  eyeYnoise = random(10);
  eyeDistRootX = 30;
  eyeDistRootY = 0;
  eyeDistXnoise = random(10);
  eyeDistYnoise = random(10);    */
  
  strokeWeight(1);
}

float stepStep = 0.01;

void draw() {
  // there's a disco going on in the background
  fill(255, random(10));
  noStroke();
  rect(0,0,width,height);
  fill(20, 50, 70, random(50));
  rect(0,0,width,height);
  
  startNoise += 0.01;
  noiseStep += stepStep;
  if (noiseStep > 5) {
    stepStep *= -1;
  } else if (noiseStep < -5) {
    stepStep *= -1;
  }
  
  float x, y;
  float noiseval = startNoise;
  
  fill(255, 150);
  stroke(20, 50, 70);
  beginShape();
  vertex((width/2)-20, height);
  
  for (float ang = 90; ang <= 430; ang += 15) {
    
    noiseval += noiseStep;
    float radVariance = 40 * customNoise(noiseval);
    
    float thisRadius = radius + radVariance;
    float rad = radians(ang);
    x = centX + (thisRadius * cos(rad));
    y = centY + (thisRadius * sin(rad));
    
    curveVertex(x,y);
  }
  
  curveVertex((width/2)+20, height);
  curveVertex((width/2)+20, height);
  vertex((width/2)-20, height);
  endShape();
   
  
  /* eyeXnoise += 0.01;
  eyeYnoise += 0.01;
  
  float eye1x = eyeRootx + (noise(eyeXnoise) * 40) - 20;
  float eye1y = eyeRooty + (noise(eyeYnoise) * 20) - 10;
  float eyeDistX = eyeDistRootX + (noise(eyeXnoise) * 20) - 10;
  float eyeDistY = eyeDistRootY + (noise(eyeYnoise) * 40) - 20;
  stroke(0);
  fill(255);
  ellipse(eye1x, eye1y, 20, 20);
  ellipse(eye1x+eyeDistX, eye1y+eyeDistY, 20, 20);
  fill(0);
  ellipse(eye1x, eye1y, 5, 5);
  ellipse(eye1x+eyeDistX, eye1y+eyeDistY, 5, 5);
  */
  
}

float customNoise(float value) {   // returns value -1 to +1
   float retValue = sin(value);
    int count = int((value % 10));
   for (int i = 0; i < count; i++) {
     retValue *= sin(value);
   }
   return retValue; 
}
 


