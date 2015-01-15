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
    keys[38] = 'up';
    keys[39] = 'right';
    keys[40] = 'down';
    keys[32] = 'pause';
    actions['left'] = false;
    actions['right'] = false;
    actions['up'] = false;
    actions['down'] = false;
    actions['pause'] = false;
    keyDownSub = html.window.onKeyDown.listen(keydown);
    keyUpSub = html.window.onKeyUp.listen(keyup);
  }

  shutdown() {
    keyDownSub.cancel();
    keyUpSub.cancel();
  }

  static Function makeTimedAction(double time, void action(Game g), Game g) {
    var a = time;
    return (double dt, bool pressed) {
      if (pressed && a > dt) {
        a -= dt;
      } else if (pressed) {
        action(g);
        a += time;
      } else if (!pressed) {
        a = 0.0;
      }
    };
  }

  static Function makeButtonPressAction(void action(Game g), Game g) {
    bool buttonPressed = false;
    return (bool pressed) {
      if (!buttonPressed && pressed) {
        buttonPressed = true;
        action(g);
        return;
      }
      if (!pressed) {
        buttonPressed = false;
      }
    };
  }

  keydown(html.KeyboardEvent e) {
    actions[keys[e.keyCode]] = true;
    print(e.which);
  }

  keyup(html.KeyboardEvent e) {
    actions[keys[e.keyCode]] = false;
    print(e.which);
  }

}
