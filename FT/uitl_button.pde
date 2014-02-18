abstract class Button {
  PVector pos;
  PVector size;

  String name;

  color c_default;
  color c_hover;

  Button(PVector pos_, PVector size_, String n, color dft, color hvr) {
    pos = pos_.get();
    size = size_.get();

    name = new String(n);

    c_default = dft;
    c_hover = hvr;
  }

  boolean mouseOn(int mx, int my) {
    return (mx > pos.x - size.x * 0.5 && mx < pos.x + size.x * 0.5
      && my > pos.y - size.y * 0.5 && my < pos.y + size.y * 0.5);
  }

  void onClicked(int mx, int my) {
    if (mouseOn(mx, my)) {
      onClickHandler();
    }
  }

  abstract void onClickHandler();

  void display() {
    // draw box
    noStroke();
    rectMode(CENTER);
    if (mouseOn(mouseX, mouseY))  fill(c_hover);
    else                          fill(c_default);
    rect(pos.x, pos.y, size.x, size.y);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(size.y * 0.5);
    text(name, pos.x, pos.y);
  }
}
