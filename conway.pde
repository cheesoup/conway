int rows = 64;
int cols = 48;
cell[][] grid;
int[][] neighbourhood;

void setup() {
  size(640, 480, P2D);
  frameRate(30);
  grid = new cell[rows][cols]; // initialize arrays
  neighbourhood = new int[rows][cols];
  for (int y = 0; y < cols - 1; y++) {
    for (int x = 0; x < rows - 1; x++) {
      println(x, y);
      neighbourhood[x][y] = 0; // initialize objects
    }
  }
  for (int y = 0; y - 1 < cols - 1; y++) {
    for (int x = 0; x - 1 < rows - 1; x++) {
      boolean rand = random(16) > 1;
      grid[x][y] = new cell(x, y, rand); // initialize objects
      if (rand) addNeigh(x, y);
    }
  }
}

void draw() {
  for (int y = 0; y < cols; y++) {
    for (int x = 0; x < rows; x++) {
      grid[x][y].update();
    }
  }
  //saveFrame("frame-######.bmp");
}

class cell {
  boolean state;
  int[] coord;
  int[] max;
  
  cell(int x, int y, boolean s) {
   coord = new int[2];
   max = new int[2];
   state = s;
   coord[0] = x;
   coord[1] = y;
  }
  
  void update() {
    if (state && (neighbourhood[coord[0]][coord[1]] == 2 || neighbourhood[coord[0]][coord[1]] == 3)) {
      fill(255);
    } else if (state == false && neighbourhood[coord[0]][coord[1]] == 3) {
      addNeigh(coord[0], coord[1]);
      state = true;
      fill(255);
    } else if (state) {
      subNeigh(coord[0], coord[1]);
      state = false;
      fill(0);
    } else if (state == false) {
      fill(0);
    }
    rect(coord[0] * (width / rows), coord[1] * (height / cols), width / rows, height / cols);
  }
}

void addNeigh(int x, int y) {
  if(x - 1 > 0 && y - 1 > 0) neighbourhood[x - 1][y - 1]++;
  if(x - 1 > 0) neighbourhood[x - 1][y]++;
  if(x - 1 > 0 && y + 1 < cols) neighbourhood[x - 1][y + 1]++;
  if(y - 1 > 0) neighbourhood[x][y - 1]++;
  if(y + 1 < cols) neighbourhood[x][y + 1]++;
  if(x + 1 < rows && y - 1 > 0) neighbourhood[x + 1][y - 1]++;
  if(x + 1 < rows) neighbourhood[x + 1][y]++;
  if(x + 1 < rows && y + 1 < cols) neighbourhood[x + 1][y + 1]++;
}

void subNeigh(int x, int y) {
  if(x - 1 > 0 && y - 1 > 0) neighbourhood[x - 1][y - 1]--;
  if(x - 1 > 0) neighbourhood[x - 1][y]--;
  if(x - 1 > 0 && y + 1 < cols) neighbourhood[x - 1][y + 1]--;
  if(y - 1 > 0) neighbourhood[x][y - 1]--;
  if(y + 1 < cols) neighbourhood[x][y + 1]--;
  if(x + 1 < rows && y - 1 > 0) neighbourhood[x + 1][y - 1]--;
  if(x + 1 < rows) neighbourhood[x + 1][y]--;
  if(x + 1 < rows && y + 1 < cols) neighbourhood[x + 1][y + 1]--;
}
