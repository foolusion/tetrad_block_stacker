library tetrad_block_stacker;

import 'dart:html' as html;
import 'dart:math' as math;

part 'game.dart';
part 'input.dart';
part 'screen.dart';
part 'tetrad.dart';

Game g;
html.DivElement score;
void main() {
  g = new Game(16, 24, '#screen');
  score = new html.DivElement();
  html.querySelector('body').append(score);
  gameLoop();
}

int start = new DateTime.now().millisecondsSinceEpoch;
var tetrad = new Tetrad(i, wI, hI, 'red', g);

gameLoop([_]) {
  int i = html.window.requestAnimationFrame(gameLoop);
  int time = new DateTime.now().millisecondsSinceEpoch;
  g.update(time);
  g.draw();
  if (g.gameOver) {
    html.window.cancelAnimationFrame(i);
    return;
  }
  score.text = '${g.score}';
}


