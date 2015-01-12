part of tetrad_block_stacker;

class Input {
  final List<String> keys = new List<String>(256);
  final Map<String, bool> actions = {};
  
  Inupt() {
    keys[37] = 'left';
    keys[38] = 'rotate';
    keys[39] = 'right';
    keys[40] = 'down';
  }
  
  getAction() {
    if (actions['left'] == true) return (Game g) => g.xPosition--;
    if (actions['right']== true) return (Game g) => g.xPosition++;
    if (actions['rotate'] == true) return (Game g) => g.cur.rotate();
    if (actions['down'] == true) return (Game g) => {};
    return (Game g) => {};
  }

}