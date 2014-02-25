class Idle extends Passive {
  PShape front;

  Idle (int w, int h) {
    super (w, h);

    PVector btn_pos = new PVector(width * 0.5, height * 0.85);
    PVector btn_size = new PVector(width * 0.3, height * 0.1);
    color c_dft = color(225, 102, 83);
    color c_hvr = color(195, 42, 23);
    btnNext = new ButtonNext(btn_pos, btn_size, "START", c_dft, c_hvr);

    front = loadShape("svg/front.svg");
  }

  void update() {
  }

  void display() {
    //background(0);
    shapeMode(CORNER);
    shape(bg, 0, 0, width, height);
//    shape(front, 0, 0, height, height);
    shapeMode(CENTER);
    shape(front, width / 2, height / 2, height, height);

    btnNext.display();
  }
}
