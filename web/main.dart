library tetrad_block_stacker;

import 'dart:async' as async;
import 'dart:html' as html;
import 'dart:math' as math;

part 'game.dart';
part 'input.dart';
part 'screen.dart';
part 'tetrad.dart';

Game g;
html.DivElement score;
void main() {
  var start = html.querySelector('#startScreen');
  start.querySelector('a.start').onClick.first.then((e) {
    start.className = 'hidden';
    var game = html.querySelector('#game');
    game.className = 'active';
    g = new Game(16, 24, '#screen');
    g.gameLoop();
    });
}

