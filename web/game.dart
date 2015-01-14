part of tetrad_block_stacker;

const blockSize = 16;

List<String> intColors = ['black', 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet'];

Map<String, int> colorInts = {
  'red': 1,
  'orange': 2,
  'yellow': 3,
  'green': 4,
  'blue': 5,
  'indigo': 6,
  'violet': 7
};

class Game {
  int score = 0;
  int startTime;
  int wBoard, hBoard;
  int xPosition, yPosition; // position of the current falling block.
  List<int> blocks; // static blocks on the bottom of the screen.
  Tetrad cur, next;
  int dropTime = 1000 ~/ 5;
  Input input;
  bool gameOver = false;
  final int loseLine = 3;
  Screen scr;

  Game(this.wBoard, this.hBoard, String screenQuery) {
    startTime = new DateTime.now().millisecondsSinceEpoch;
    xPosition = wBoard ~/ 2;
    yPosition = 0;
    blocks = new List<int>.filled(wBoard * hBoard, 0);
    cur = Tetrad.makeRandomTetrad(this);
    next = Tetrad.makeRandomTetrad(this);
    input = new Input(this);
    scr = new Screen(screenQuery, wBoard, hBoard);
  }

  update(int time) {
    if (cur == null) {
      swapToNextTetrad();
    }
    int dt = time - startTime;
    Function action = input.getAction(dt);
    action(this);
    if (dt > dropTime) {
      moveTetradDown(this);
      startTime = time;
    }
    if (gameOver) {
      print('You Lose');
    }
    checkForFullLines();
  }

  void checkForFullLines() {
    var numLines = 0;
    for (int i = 0; i < hBoard; i++) {
      bool fullLine = true;
      for (int j = 0; j < wBoard; j++) {
        if (blocks[j+i*wBoard] == 0) {
          fullLine = false;
        }
      }
      if (fullLine) {
        numLines++;
        clearLine(i);
      }
    }
    score += numLines * numLines * wBoard;
  }
  
  void clearLine(int row) {
    for (int i = (row+1)*wBoard-1; i > 0; i--) {
      if (i-wBoard < 0) {
        blocks[i] = 0;
        continue;
      } 
      blocks[i] = blocks[i-wBoard];
    }
  }
  
  void swapToNextTetrad() {
    cur = next;
    next = Tetrad.makeRandomTetrad(this);
    xPosition = wBoard ~/ 2;
    yPosition = 0;
  }

  static void moveTetradDown(Game g) {
    final Tetrad t = new Tetrad.copy(g.cur);
    if (g.yPosition + t.height == g.hBoard || g.intersects(t, g.xPosition, g.yPosition + 1, g.blocks)) {
      g.mergeBlocks();
      if (g.gameOver) {
        return;
      }
      g.swapToNextTetrad();
      return;
    }
    g.yPosition++;
  }

  static void moveTetradLeft(Game g) {
    final Tetrad t = new Tetrad.copy(g.cur);
    if (g.xPosition - 1 < 0 || g.intersects(t, g.xPosition - 1, g.yPosition, g.blocks)) {
      return;
    }
    g.xPosition--;
  }

  static void moveTetradRight(Game g) {
    final Tetrad t = new Tetrad.copy(g.cur);
    if (g.xPosition + 1 + t.width > g.wBoard || g.intersects(t, g.xPosition + 1, g.yPosition, g.blocks)) {
      return;
    }
    g.xPosition++;
  }

  static void rotateTetrad(Game g) {
    final Tetrad t = new Tetrad.copy(g.cur);
    t.rotate();
    if (g.yPosition + t.height > g.hBoard || g.intersects(t, g.xPosition, g.yPosition, g.blocks)) {
      return;
    } else if (g.xPosition + t.width > g.wBoard) {
      if (g.intersects(t, g.xPosition - 1, g.yPosition, g.blocks)) {
        return;
      }
      g.xPosition -= 1;
    }
    g.cur.rotate();
  }

  intersects(Tetrad t, int x, int y, List<int> blocks) {
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i] == 0) {
        continue;
      }
      int xBlock = i % wBoard;
      int yBlock = i ~/ wBoard;
      if (xBlock < x || xBlock > x + math.max(t.width, t.height) || yBlock < y || yBlock > y + math.max(t.width, t.height)) {
        continue;
      }
      for (int j = 0; j < t.config[t.currentConfig].length; j++) {
        if (t.config[t.currentConfig][j] == '1') {
          int xTetrad = j % t.width;
          int yTetrad = j ~/ t.width;
          if (xBlock == xTetrad + x && yBlock == yTetrad + y) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void mergeBlocks() {
    if (yPosition <= loseLine) {
      gameOver = true;
      return;
    }
    score++;
    final Tetrad t = new Tetrad.copy(g.cur);
    for (int i = 0; i < t.config[t.currentConfig].length; i++) {
      if (t.config[t.currentConfig][i] == '0') {
        continue;
      }
      int xTetrad = i % t.width;
      int yTetrad = i ~/ t.width;
      blocks[xPosition + xTetrad + (yPosition + yTetrad) * wBoard] = colorInts[t.color];
    }
  }

  draw() {
    scr.drawBackground(wBoard, hBoard);
    scr.drawLoseLine(loseLine, wBoard);
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i] == 0) {
        continue;
      }
      int x = i % wBoard;
      int y = i ~/ wBoard;
      scr.context.fillStyle = intColors[blocks[i]];
      scr.drawBlock(intColors[blocks[i]], x, y);
    }
    cur.draw(xPosition, yPosition); 
    next.draw(wBoard, 0);
  }
}
