part of tetrad_block_stacker;

class Screen {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D context;
  
  Screen(String s) {
    canvas = html.querySelector(s);
    canvas.width = 20*16;
    canvas.height = 40*16;
    context = canvas.context2D;
  }
}