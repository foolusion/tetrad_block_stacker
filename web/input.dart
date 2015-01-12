part of tetrad_block_stacker;

class Input {
  List<String> keys = new List<String>(256);
  Map<String, bool> actions = new Map<String, bool>();
  
  Input() {
    keys[37] = 'left';
    keys[38] = 'rotate';
    keys[39] = 'right';
    keys[40] = 'down';
    html.window.onKeyDown.listen(keydown);
    html.window.onKeyUp.listen(keyup);
  }
  
  getAction() {
    if (actions['left'] == true) return (Game g) => g.xPosition--;
    if (actions['right']== true) return (Game g) => g.xPosition++;
    if (actions['rotate'] == true) return (Game g) => g.cur.rotate();
    if (actions['down'] == true) return (Game g) => {};
    return (Game g) => {};
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