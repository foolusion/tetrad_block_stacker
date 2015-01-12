part of tetrad_block_stacker;

const List<String> l = const ['101011', '111100','110101','001111'];
const int wL = 2;
const int hL = 3;
const List<String> j = const ['010111', '100111','111010','111001'];
const int wJ = 2;
const int hJ = 3;
const List<String> t = const ['010111','101110','111010','011101'];
const int wT = 3;
const int hT = 2;
const List<String> z = const ['110011','011110'];
const int wZ = 3;
const int hZ = 2;
const List<String> s = const ['011110','101101'];
const int wS = 3;
const int hS = 2;
const List<String> o = const ['1111'];
const int wO = 2;
const int hO = 2;
const List<String> i = const ['1111'];
const int wI = 4;
const int hI = 1;

class Tetrad {
  final List<String> config;
  int width, height;
  int currentConfig = 0;
  final String color;
  
  Tetrad(this.config, this.width, this.height, this.color) {
  }
  
  static Tetrad makeRandomTetrad() {
    return new Tetrad(l, wL, hL, 'blue');
  }
  
  rotate() {
    currentConfig = (currentConfig + 1) % config.length;
    var temp = width;
    width = height;
    height = temp;
  }
  
  draw(ctx, x, y) {
    ctx.save();
    ctx.translate(blockSize*(x), blockSize*(y));
    ctx.fillStyle = color;
    ctx.strokeStyle = 'black';
    for (var i = 0; i < width; i++) {
      for (var j = 0; j < height; j++) {
        if (config[currentConfig][i+j*width] == '1') {
          ctx.fillRect(i*blockSize,j*blockSize, blockSize, blockSize);
          ctx.strokeRect(i*blockSize,j*blockSize, blockSize, blockSize);
        }
      }
    }
    ctx.restore();
    ctx.strokeStyle = 'yellow';
    ctx.strokeRect(x*blockSize, y*blockSize, blockSize, blockSize);
  }
}