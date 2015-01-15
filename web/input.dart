part of tetrad_block_stacker;

class Input {
  Game g;
  List<String> keys = new List<String>(256);
  Map<String, bool> actions = new Map<String, bool>();
  bool rotateReleased = true;
  bool pauseReleased = true;
  double leftTime = horizontalSpeed;
  double rightTime = horizontalSpeed;
  static const double horizontalSpeed = 1000 / 10;
  async.StreamSubscription keyDownSub;
  async.StreamSubscription keyUpSub;

  Input(this.g) {
    keys[37] = 'left';
    keys[38] = 'rotate';
    keys[39] = 'right';
    keys[40] = 'down';
    keys[32] = 'pause';
    actions['left'] = false;
    actions['right'] = false;
    actions['rotate'] = false;
    actions['down'] = false;
    actions['pause'] = false;
    keyDownSub = html.window.onKeyDown.listen(keydown);
    keyUpSub = html.window.onKeyUp.listen(keyup);
  }
  
  shutdown() {
    keyDownSub.cancel();
    keyUpSub.cancel();
  }

  Function getAction(double dt) {
    if (actions['left'] == true && leftTime > dt) {
      leftTime -= dt;
    } else if (actions['left'] == true) {
      leftTime += horizontalSpeed;
      return Game.moveTetradLeft;
    } else if (actions['left'] == false) {
      leftTime = 0.0;
    }

    if (actions['right'] == true && rightTime > dt) {
      rightTime -= dt;
    } else if (actions['right'] == true) {
      rightTime += horizontalSpeed;
      return Game.moveTetradRight;
    } else if (actions['right'] == false) {
      rightTime = 0.0;
    }

    if (actions['rotate'] == true) return rotate();
    if (actions['rotate'] == false) rotateReleased = true;
    if (actions['down'] == true) return Game.moveTetradDown;
    
    if (actions['pause'] == true) return pause();
    if (actions['pause'] == false) pauseReleased = true;
    return ([_]) {};
  }

  Function rotate() {
    if (rotateReleased) {
      rotateReleased = false;
      return Game.rotateTetrad;
    }
    return ([_]) {};
  }
  
  Function pause() {
    if (pauseReleased) {
      pauseReleased = false;
      return (Game g) { g.paused = !g.paused; };
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
