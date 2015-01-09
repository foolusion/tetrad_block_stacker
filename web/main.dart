import 'dart:html' as html;

void main() {
  var canvas = html.querySelector('#screen');
  canvas.width = html.window.innerWidth;
  canvas.height = html.window.innerHeight;
  var ctx = canvas.context2D;
  
  ctx.fillStyle = 'red';
  ctx.fillRect(100, 100, 100, 100);
}
