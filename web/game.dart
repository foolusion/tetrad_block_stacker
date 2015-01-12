part of tetrad_block_stacker;

const blockSize = 16;

class Game {
  int startTime;
  int wBoard, hBoard;
  int xPosition, yPosition; // position of the current falling block.
  List<int> blocks; // static blocks on the bottom of the screen.
  Tetrad cur, next;
  int dropTime = 1000~/10;
  Input input;
  
  Game() {
    startTime = new DateTime.now().millisecondsSinceEpoch;
    wBoard = 20;
    hBoard = 40;
    xPosition = wBoard~/2;
    yPosition = 0;
    blocks = new List<int>.filled(wBoard*hBoard, 0);
    cur = Tetrad.makeRandomTetrad();
    next = Tetrad.makeRandomTetrad();
    input = new Input();
  }
  
  update(int time) {
    if (cur == null) {
      swapToNextTetrad();
    }
    Function action = input.getAction();
    action(this);
    if (time - startTime > dropTime) {
      moveTetradDown(this);
      startTime = time;
    }
  }
  
  void swapToNextTetrad() {
    cur = next;
    next = Tetrad.makeRandomTetrad();
    xPosition = wBoard~/2;
    yPosition = 0;
  }
  
  void moveTetradDown(Game g) {
    final Tetrad t = g.cur;
    if (yPosition + t.height == hBoard || intersects(t, xPosition, yPosition+1, blocks)) {
      mergeBlocks();
      swapToNextTetrad();
      return;
    }
    yPosition++;
  }
  
  intersects(Tetrad t, int x, int y, List<int> blocks) {
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i] == 0) {
        continue;
      }
      int xBlock = i % wBoard;
      int yBlock = i ~/ wBoard;
      if (xBlock < x || xBlock > x + math.max(t.width, t.height) ||
          yBlock < y || yBlock > y + math.max(t.width, t.height)) {
        continue;
      }
      for (int j = 0; j < t.config[t.currentConfig].length; j++) {
        if (t.config[t.currentConfig][j] == '1') {
          int xTetrad = j%t.width;
          int yTetrad = j~/t.width;
          if (xBlock == xTetrad + x && yBlock == yTetrad + y) {
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void mergeBlocks() {
    final Tetrad t = g.cur;
    for (int i = 0; i < t.config[t.currentConfig].length; i++) {
      if (t.config[t.currentConfig][i] == '0') {
        continue;
      }
      int xTetrad = i%t.width;
      int yTetrad = i~/t.width;
      blocks[xPosition+xTetrad+(yPosition+yTetrad)*wBoard] = 1;
    }
  }
  
  draw(Screen s) {
    s.context.save();
    s.context.fillStyle = 'red';
    s.context.strokeStyle = 'black';
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i] == 0) {
        continue;
      }
      int x = i%wBoard;
      int y = i~/wBoard;
      s.context.fillRect(x*blockSize, y*blockSize, blockSize, blockSize);
      s.context.strokeRect(x*blockSize, y*blockSize, blockSize, blockSize);
    }
    s.context.restore();
  }
}