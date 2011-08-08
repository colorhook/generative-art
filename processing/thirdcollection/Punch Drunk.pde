// Jan 2010 
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




Cell[][] _cellArray;     // two dimensional array of cells
int _cellSize = 3;      // size of each cell
int _numX, _numY;        // dimensions of grid



void setup() { 
  size(500, 300);
  frameRate(6);
  _numX = floor(width/_cellSize);
  _numY = floor((height/2)/_cellSize);
  
  sampleColour();
  
  restart();
} 


void restart() {;
  // create a grid of cells
  _cellArray = new Cell[_numX][_numY];
  for (int x = 0; x<_numX; x++) {
    for (int y = 0; y<_numY; y++) {
      Cell newCell = new Cell(x, y);          // create a cell at this x,y
      _cellArray[x][y] = newCell;             // add it to the array
    }
  }
  // once all created do a second pass to tell each object it's neighbours
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
      // positions to the sides of this cell
      int above = y-1;
      int below = y+1;
      int left = x-1;
      int right = x+1;
      // wrap positions if on the edge
      if (above < 0) { above = _numY-1; }
      if (below == _numY) { below = 0; }
      if (left < 0) { left = _numX-1; }
      if (right == _numX) { right = 0; }
      // pass array references to cells is 8 surrounding positions
      // going anticlockwise
     _cellArray[x][y].addNeighbour(_cellArray[left][above]);
     _cellArray[x][y].addNeighbour(_cellArray[left][y]);
     _cellArray[x][y].addNeighbour(_cellArray[left][below]);
     _cellArray[x][y].addNeighbour(_cellArray[x][below]);
     _cellArray[x][y].addNeighbour(_cellArray[right][below]);
     _cellArray[x][y].addNeighbour(_cellArray[right][y]);
     _cellArray[x][y].addNeighbour(_cellArray[right][above]);
     _cellArray[x][y].addNeighbour(_cellArray[x][above]);
    }
  }
}


void draw() {
  background(0);
  
  _ycol++;
  if (_ycol > 255) { _ycol = 0; }
  
  // calculate the next state of each cell before we draw it
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].calcNextState();
    }
  }
  // draw all the cells in the array
  translate(_cellSize/2, _cellSize/2);  // offset slightly
  //int y = 0;
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].drawMe();
    }
  }
  kaleidoscope();
  
  // println(frameCount);
}

void mousePressed() {
  restart();
}

//================================= object

class Cell {
  float x, y;
  float state;  // 0 to 255
  float nextState;  
  float lastState = 0; 
  color col;
  Cell[] neighbours;
  
  
int xmin, xmax, ymin, ymax;
  
  Cell(float ex, float why) {
    
    xmin = int(random(width/2));
    xmax = int(random(width/2)) + width/2;
    ymin = int(random(height/2));
    ymax = int(random(height/2)) + height/2;
  
    x = ex * _cellSize;
    y = why * _cellSize;
    if ((x < xmax) && (x > xmin) && (y < ymax) && (y > ymin)) {
      nextState = 0;
    } else {
     nextState = random(255); 
    }  
    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell); 
  }
  
  void calcNextState() {
    // calculate neighbourhood average
    float total = 0;
    for (int i=0; i < neighbours.length; i++) {
       total += neighbours[i].state;
    }
    float average = int(total/8);
    // calc next state
    if (average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
      nextState = state + average;
      if (lastState > 0) { nextState -= lastState; }
      // limit the value to be within the range 0 to 255
      if (nextState > 255) { nextState = 255; }
      else if (nextState < 0) { nextState = 0; }
    }
    // remember the neighbourhood average for the next calculation
    lastState = state;
  }
  
  void drawMe() {
    state = nextState;
    col = color(colArr[_ycol][int(state)]);
    stroke(col, 10); 
    strokeWeight(15);
    line(x,y,x, 150);
  }
  
}



//================================= colour sampling

int numcols = 256;
color[][] colArr = new color[numcols][numcols];
int _ycol = 0;    // yindex

void sampleColour() {
  PImage img = loadImage("gradient6.jpg");
  image(img,0,0);
  for (int x=0; x < numcols; x++){
    for (int y=0; y < numcols; y++) {
        color c = get(x,y);
        colArr[x][y] = c;
    }
  }
}


//================================= mirror

void kaleidoscope() {
  // bottom, mirror top
  loadPixels();
  for (int yyy = int(height/2); yyy < height; yyy++) {
    for (int xx = 0; xx < width; xx++) {
      pixels[xx+(yyy*width)] = pixels[xx+( (height-yyy)*width )];
    }
  }
  updatePixels();
}

