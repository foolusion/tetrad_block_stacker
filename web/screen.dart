part of tetrad_block_stacker;

class Screen {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D context;

  Screen(String s, int width, int height) {
    canvas = html.querySelector(s);
    canvas.width = width * blockSize;
    canvas.height = height * blockSize;
    context = canvas.context2D;
  }

  shutdown() {
    var s = canvas.toDataUrl();
    context.fillStyle = 'black';
    context.fillRect(0, 0, canvas.width, canvas.height);
    return s;
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
//    context.save();
//    context.translate(blockSize * (w) + -.5, -.5);
//    context.strokeRect(0, 0, blockSize * 4, blockSize * 4);
//    context.fillStyle = 'white';
//    context.font = '12pt sans-serif';
//    context.fillText('Next', 0, blockSize*5);
//    context.restore();
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
