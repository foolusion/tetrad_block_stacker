library tetrad_block_stacker;

import 'dart:html' as html;
import 'dart:math' as math;

part 'game.dart';
part 'input.dart';
part 'screen.dart';
part 'tetrad.dart';

Screen scr;
Game g;
void main() {
  g = new Game(16, 24);
  scr = new Screen('#screen', 16, 24);
  gameLoop();
}

int start = new DateTime.now().millisecondsSinceEpoch;
var tetrad = new Tetrad(i, wI, hI, 'red');

gameLoop([_]) {
  int i = html.window.requestAnimationFrame(gameLoop);
  int time = new DateTime.now().millisecondsSinceEpoch;
  g.update(time);
  scr.context.clearRect(0, 0, scr.canvas.width, scr.canvas.height);
  scr.context.strokeStyle = 'black';
  scr.context.strokeRect(.5, .5, blockSize*g.wBoard-1, blockSize*g.hBoard-1);
  scr.context.save();
  scr.context.translate(blockSize*(g.xPosition)+-.5, blockSize*(g.yPosition)+-.5);
  g.cur.draw(scr.context, g.xPosition, g.yPosition); 
  scr.context.restore();
  
  scr.context.save();
  scr.context.translate(blockSize*(g.wBoard)+-.5, -.5);
  scr.context.strokeRect(0, 0, blockSize*4, blockSize*4);
  scr.context.font = '12pt Roboto';
  var t = scr.context.measureText('Next');
  scr.context.fillText('Next', 2, 2+blockSize*4+t.actualBoundingBoxAscent);
  g.next.draw(scr.context, g.wBoard, 0);
  scr.context.restore();
  g.draw(scr);
  if (g.gameOver) {
    html.window.cancelAnimationFrame(i);
    return;
  }
}


