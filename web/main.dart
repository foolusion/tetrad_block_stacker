library tetrad_block_stacker;

import 'dart:async' as async;
import 'dart:html' as html;
import 'dart:math' as math;

part 'game.dart';
part 'input.dart';
part 'screen.dart';
part 'tetrad.dart';

Screen scr;
Game g;
void main() {
  scr = new Screen('#screen');
  g = new Game();
  gameLoop();
}

int start = new DateTime.now().millisecondsSinceEpoch;
var tetrad = new Tetrad(i, wI, hI, 'red');

var x = 0;
var y = 0;

gameLoop([_]) {
  async.Future<num> f = html.window.animationFrame;
  f.then(gameLoop);
  int time = new DateTime.now().millisecondsSinceEpoch;
  g.update(time);
  scr.context.clearRect(0, 0, scr.canvas.width, scr.canvas.height);
  g.cur.draw(scr.context, g.xPosition, g.yPosition); 
  g.draw(scr);
}


