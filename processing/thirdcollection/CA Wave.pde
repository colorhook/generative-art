
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
int _cellSize = 10;      // size of each cell
int _numX, _numY;        // dimensions of grid

void setup() { 
  size(500, 300);
  _numX = floor(width/_cellSize);
  _numY = floor(height/_cellSize);
  restart();
} 

void restart() {
  _cellArray = new Cell[_numX][_numY];	
  for (int x = 0; x<_numX; x++) {
    for (int y = 0; y<_numY; y++) {	
      Cell newCell = new Cell(x, y);	
      _cellArray[x][y] = newCell;	   
    }				
  }					

  
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {	
      
      int above = y-1;		
      int below = y+1;		
      int left = x-1;			
      int right = x+1;			
      
      if (above < 0) { above = _numY-1; }	
      if (below == _numY) { below = 0; }	
      if (left < 0) { left = _numX-1; }	
      if (right == _numX) { right = 0; }	

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
  background(200);
  					
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].calcNextState();
    }
  }
  						
  translate(_cellSize/2, _cellSize/2);  	
						
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].drawMe();
    }
  }
}

void mousePressed() {
  restart();
}

//================================= object

class Cell {
  float x, y;
  float state;  		
  float nextState;  
  float lastState = 0; 
  Cell[] neighbours;
  
  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;
    nextState = ((x/500) + (y/300)) * 14;  
    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell); 
  }
  
  void calcNextState() {
    			
    float total = 0;				
    for (int i=0; i < neighbours.length; i++) {	
       total += neighbours[i].state;		
    }					
    float average = int(total/8);
    			
    if (average == 255) {
      nextState = 0;
    } else if (average == 0) {
      nextState = 255;
    } else {
      nextState = state + average;
      if (lastState > 0) { nextState -= lastState; }	 
      if (nextState > 255) { nextState = 255; }
      else if (nextState < 0) { nextState = 0; }
    }
 
    lastState = state;	
  }
  
  void drawMe() {
    state = nextState;
    stroke(0);
    fill(state);    
    ellipse(x, y, _cellSize, _cellSize);
  }
  
}


