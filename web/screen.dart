part of tetrad_block_stacker;

class Screen {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D context;

  Screen(String s, int width, int height) {
    canvas = html.querySelector(s);
    canvas.width = (width + 6) * blockSize;
    canvas.height = height * blockSize;
    context = canvas.context2D;
  }

  shutdown(int score) {
    context.fillStyle = 'rgba(255, 255, 255, 0.25)';
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.fillStyle = 'white';
    context.font = '32px sans-serif';
    var t = context.measureText('GAME OVER');
    context.fillText('GAME OVER', (canvas.width - t.width) ~/ 2, canvas.height  ~/ 2);
    t = context.measureText('${score}');
    context.fillText('${score}', (canvas.width - t.width) ~/ 2, canvas.height ~/ 2 + 32);
  }

  drawBlock(String color, int x, int y) {
    context.save();
    context.translate(blockSize * (x) + -.5, blockSize * (y) + -.5);
    context.fillStyle = color;
    context.strokeStyle = 'white';
    context.fillRect(0, 0, blockSize, blockSize);
    context.strokeRect(0, 0, blockSize, blockSize);
    context.restore();
  }

  drawLoseLine(int height, int width) {
    context.save();
    context.translate(-.5, -.5);
    context.strokeStyle = 'white';
    context.beginPath();
    context.moveTo(0, (height + 1) * blockSize);
    context.lineTo(width * blockSize, (height + 1) * blockSize);
    context.stroke();
    context.restore();
  }

  drawBackground(int w, int h) {
    context.fillStyle = 'black';
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.strokeStyle = 'white';
    context.strokeRect(.5, .5, blockSize * w - 1, blockSize * h - 1);
  }

  drawNext(int x, int y) {
    context.save();
    context.translate(blockSize * x - .5, y - .5);
    context.strokeRect(0, blockSize, blockSize * 4, blockSize * 4);
    context.fillStyle = 'white';
    context.font = '${blockSize}px sans-serif';
    context.fillText('Next', 0, blockSize - 2);
    context.restore();
  }

  drawScore(int x, int y) {
    context.save();
    context.translate(blockSize * x - .5, blockSize * y - .5);
    context.font = '${blockSize}px sans-serif';
    context.fillStyle = 'white';
    context.fillText('Score', 0, blockSize - 2);
    context.font = '${2*blockSize}px sans-serif';
    context.fillText('${g.score}', 0, blockSize * 3 - 2);
    context.restore();
  }

  drawPausedScreen() {
    context.fillStyle = 'rgba(255,255,255, .3)';
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.fillStyle = 'rgba(255,255,255,1.0)';
    context.font = '32px sans-serif';
    html.TextMetrics t = context.measureText('PAUSED');
    context.fillText('PAUSED', (canvas.width - t.width) ~/ 2, (canvas.height - 32) ~/ 2 + 32);
  }
}
