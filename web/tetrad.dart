part of tetrad_block_stacker;

const List<String> l = const ['101011', '111100', '110101', '001111'];
const int wL = 2;
const int hL = 3;
const List<String> j = const ['010111', '100111', '111010', '111001'];
const int wJ = 2;
const int hJ = 3;
const List<String> t = const ['010111', '101110', '111010', '011101'];
const int wT = 3;
const int hT = 2;
const List<String> z = const ['110011', '011110'];
const int wZ = 3;
const int hZ = 2;
const List<String> s = const ['011110', '101101'];
const int wS = 3;
const int hS = 2;
const List<String> o = const ['1111'];
const int wO = 2;
const int hO = 2;
const List<String> i = const ['1111'];
const int wI = 1;
const int hI = 4;

class Tetrad {
  List<String> config;
  int width, height;
  int currentConfig = 0;
  String color;
  static math.Random r = new math.Random();
  Game g;

  Tetrad(this.config, this.width, this.height, this.color, this.g) {
  }

  Tetrad.copy(Tetrad t) {
    config = t.config;
    width = t.width;
    height = t.height;
    currentConfig = t.currentConfig;
    color = t.color;
    g = t.g;
  }

  static Tetrad makeRandomTetrad(Game g) {
    switch (r.nextInt(7)) {
      case 0:
        return new Tetrad(l, wL, hL, 'red', g);
      case 1:
        return new Tetrad(j, wJ, hJ, 'orange', g);
      case 2:
        return new Tetrad(t, wT, hT, 'yellow', g);
      case 3:
        return new Tetrad(z, wZ, hZ, 'green', g);
      case 4:
        return new Tetrad(s, wS, hS, 'blue', g);
      case 5:
        return new Tetrad(o, wO, hO, 'indigo', g);
      case 6:
        return new Tetrad(i, wI, hI, 'violet', g);
    }
    return new Tetrad(l, wL, hL, 'red', g);
  }

  rotate() {
    currentConfig = (currentConfig + 1) % config.length;
    var temp = width;
    width = height;
    height = temp;
  }

  draw(int x, int y) {
    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        if (config[currentConfig][i + j * width] == '1') {
          g.scr.drawBlock(color, x+i, y+j);
        }
      }
    }
  }
}
