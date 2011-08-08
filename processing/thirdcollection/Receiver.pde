
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

float _boost = 0.5;
int _num = 40;
int _nodes = 6;
Particle[] _dotArr = new Particle[_num];
Node[] _nodeArr = new Node[_nodes];

//================================= init

void setup(){
  size(500, 300);
  smooth(); 
  frameRate(12);
  restart();
}

void restart() {
  clearBackground();
  for(int i=0;i<_num;i++){
    _dotArr[i]=new Particle();
  }
  for(int i=0;i<_nodes;i++){
    _nodeArr[i]=new Node();
  }
}

void clearBackground() {
  fill(255, 10);
  noStroke();
  rect(0,0,width,height);
}

//================================= frame loop

void draw(){
  clearBackground();
  for(int i=0;i<_num;i++){
    _dotArr[i].update();
    _dotArr[i].drawMe();
  }
  for(int i=0;i<_nodes;i++){
    _nodeArr[i].drawMe();
  }  
}

//================================= interaction

void mousePressed(){
  restart();
}

//================================= objects

class Particle {
  float xpos, ypos, vx, vy, gain;
  color col;
  Particle() {
    xpos=random(width);
    ypos=random(height);
    if (random(1) > 0.5) {
      col = color(255, 150);
    } else {
      col = color(0, 150);
    }
  }
  
  void update(){
    for(int i=0; i<_nodes; i++){
      gain = dist(xpos, ypos, _nodeArr[i].xpos, _nodeArr[i].ypos);
      if (gain > 1) {
        vx+=((_nodeArr[i].xpos-xpos) * _boost) /gain;
        vy+=((_nodeArr[i].ypos-ypos) * _boost) /gain;
        xpos += vx;
        ypos += vy;
      }
    }
  }
  
  void drawMe() {
    strokeWeight(random(3));
    for(int i=0;i<_num;i++){
      float dis = dist(xpos, ypos, _dotArr[i].xpos, _dotArr[i].ypos);
      if (dis > 50) {
        if (dis > 198) { dis = 198; }
        stroke(col, 200-dis);
        line(xpos, ypos, _dotArr[i].xpos, _dotArr[i].ypos);
      }
    } 
  }
}

class Node {
  float xpos,ypos;
  
  Node(){
   xpos = random(-200, width+200);
   ypos = random(-200, height+200);
  }
  
  void drawMe() {
    noFill();
    strokeWeight(0.5);
    stroke(255, 100);
    ellipse(xpos, ypos, 30, 30);
  }
    
}