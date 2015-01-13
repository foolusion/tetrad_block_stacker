part of tetrad_block_stacker;

class Screen {
  html.CanvasElement canvas;
  html.CanvasRenderingContext2D context;
  
  Screen(String s, int width, int height) {
    canvas = html.querySelector(s);
    canvas.width = (width+4)*blockSize;
    canvas.height = height*blockSize;
    context = canvas.context2D;
  }
}