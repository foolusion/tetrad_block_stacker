part of tetrad_block_stacker;

class Input {
  Game g;
  List<String> keys = new List<String>(256);
  Map<String, bool> actions = new Map<String, bool>();
  bool rotateReleased = true;
  
  Input(this.g) {
    keys[37] = 'left';
    keys[38] = 'rotate';
    keys[39] = 'right';
    keys[40] = 'down';
    actions['left'] = false;
    actions['right'] = false;
    actions['rotate'] = false;
    actions['down'] = false;
    html.window.onKeyDown.listen(keydown);
    html.window.onKeyUp.listen(keyup);
  }
  
  Function getAction() {
    if (actions['left'] == true) {
      actions['left'] = false;
      return Game.moveTetradLeft;
    }
    if (actions['right']== true) {
      actions['right'] = false;
      return Game.moveTetradRight;
    }
    if (actions['rotate'] == true) return rotate();
    if (actions['rotate'] == false) rotateReleased = true;
    if (actions['down'] == true) return Game.moveTetradDown;
    return ([_]) {};
  }
  
  Function rotate() {
    if (rotateReleased) {
      rotateReleased = false;
      return Game.rotateTetrad;
    }
    return ([_]) {};
  }
  
  keydown(html.KeyboardEvent e) {
    actions[keys[e.keyCode]] = true;
    print(e.keyCode);
  }

  keyup(html.KeyboardEvent e) {
    actions[keys[e.keyCode]] = false;
    print(e.keyCode);
  }
  
}