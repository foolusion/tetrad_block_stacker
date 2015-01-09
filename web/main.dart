import 'dart:html' as html;
import 'dart:async' as async;

var canvas;
var ctx;

void main() {
  canvas = html.querySelector('#screen');
  canvas.width = html.window.innerWidth;
  canvas.height = html.window.innerHeight;
  ctx = canvas.context2D;
  draw();
}

int start = new DateTime.now().millisecondsSinceEpoch;
var tetrad = new Tetrad(i, wI, hI, 'red');

var x = 0;

draw([_]) {
  async.Future<num> f = html.window.animationFrame;
  f.then(draw);
  int time = new DateTime.now().millisecondsSinceEpoch;
  
  if ((time - start) > (1000~/2)) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    if (x > 20) {
      x = 0;
    }
    x++;
    tetrad.rotate();
    tetrad.draw(ctx, 10, x);
//    ctx.fillStyle = 'yellow';
//    ctx.fillRect(10*blockSize, x*blockSize, blockSize, blockSize);
    start = time;
  }
}

const blockSize = 16;

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
  final List config;
  int width, height;
  int currentConfig = 0;
  int xCenter;
  int yCenter;
  final String color;
  
  Tetrad(this.config, this.width, this.height, this.color) {
    xCenter = width~/2;
    yCenter = height~/2;
  }
  
  rotate() {
    currentConfig = (currentConfig + 1) % config.length;
    var temp = width;
    width = height;
    height = temp;
    xCenter = width~/2;
    yCenter = height~/2;
  }
  
  draw(ctx, x, y) {
    ctx.save();
    ctx.translate(blockSize*(x-xCenter), blockSize*(y-yCenter));
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
  }
}

class Game {
  int wBoard, hBoard;
  int xTetrad, yTetrad;
}

