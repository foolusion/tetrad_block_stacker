library tetrad_block_stacker;

import 'dart:async' as async;
import 'dart:html' as html;
import 'dart:math' as math;

part 'clock.dart';
part 'game.dart';
part 'input.dart';
part 'screen.dart';
part 'tetrad.dart';

Game g;
html.DivElement score;
void main() {
  var game = html.querySelector('#game');
  game.className = 'active';
  g = new Game(16, 24, '#screen');
  g.gameLoop(html.window.performance.now());
}
