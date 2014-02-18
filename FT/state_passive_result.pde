public class Result extends Passive {
  float[] course_data;
  float[] input_data;

  Result (int w, int h, float[][] data) {
    super(w, h);

    PVector btn_pos = new PVector(width * 0.5, height * 0.725);
    PVector btn_size = new PVector(width * 0.3, height * 0.1);
    color c_dft = color(225, 102, 83);
    color c_hvr = color(195, 42, 23);
    btnNext = new ButtonNext(btn_pos, btn_size, "DONE", c_dft, c_hvr);

    ttl_p = new PVector(width * 0.5, height * 0.4);
    ttl_s = height * 0.1;

    course_data = data[0];
    input_data = data[1];
  }

  void update() {
  }

  void display() {
    background(0);

    strokeWeight(1);
    for(int x = 1; x < course_data.length; x++) {
      stroke(0, 255, 255);
      line(x - 1, course_data[x - 1], x, course_data[x]);
    }

    stroke(255, 255, 0);
    int x_prev = -1;
    for(int x = 0; x < input_data.length; x++) {
      if(input_data[x] <= 0)
        continue;
      if(x_prev < 0) {
        x_prev = x;
        continue;
      }

      line(x_prev, input_data[x_prev], x, input_data[x]);
      x_prev = x;
    }

    noStroke();
    fill(255);
    textSize(ttl_s);
    text("Result State", ttl_p.x, ttl_p.y);

    btnNext.display();
  }
}
