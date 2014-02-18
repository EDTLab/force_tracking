class Idle extends Passive {
  Idle (int w, int h) {
    super (w, h);

    PVector btn_pos = new PVector(width * 0.5, height * 0.725);
    PVector btn_size = new PVector(width * 0.3, height * 0.1);
    color c_dft = color(225, 102, 83);
    color c_hvr = color(195, 42, 23);
    btnNext = new ButtonNext(btn_pos, btn_size, "START", c_dft, c_hvr);

    ttl_p = new PVector(width * 0.5, height * 0.4);
    ttl_s = height * 0.1;
  }

  void update() {
  }

  void display() {
    background(0);

    noStroke();
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(ttl_s);
    text("Force Tracking Test", ttl_p.x, ttl_p.y);

    btnNext.display();
  }
}
