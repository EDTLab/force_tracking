class Course {
  private FloatList datas;
  private int number_of_datas;
  private int step = x_step;
  private int[] periods;
  private float[] amplifiers;

  Course(int num) {
    number_of_datas = width / x_step;
    datas = new FloatList();
    periods = new int[]{
      number_of_datas / 1,
      number_of_datas / 2,
      number_of_datas / 3,
      number_of_datas / 4,
      number_of_datas / 5,
      number_of_datas / 6
    };
    amplifiers = new float[]{
      height / 8,
      height / 7,
      height / 6,
      height / 5,
      height / 4,
      height / 3
    };
    println("Course/Course()");

    // this.setup(num);
  }

  float[] genOnce(float amp, int period) {
    float[] tmp = new float[period];
    for (int i = 0; i < tmp.length; i++) {
      tmp[i] = (cos(TWO_PI / tmp.length * i) - 1) * amp;
    }
    return tmp;
  }

  float[] getData() {
    return datas.array();
  }

  void setup(int num) {
    int remainder = number_of_datas;
    int current_num = number_of_datas + 1;
    float amp = amplifiers[(int)random(amplifiers.length)];
    datas.clear();
    for(int i = 0; i < num - 1; i++) {
      while(remainder > periods[periods.length - 1] && remainder < current_num) {
        int idx = (int)random(periods.length);
        current_num = periods[idx];
      }
      amp = amplifiers[(int)random(amplifiers.length)];
      datas.append(genOnce(amp, current_num));
      remainder -= current_num;
    }
    println("Course/setup()");
    if(remainder > 0)
      datas.append(genOnce(amp, remainder));
  }

  void draw(float baseline) {
    // drawBorder(baseline);
    stroke(0, 255, 255);
    drawCourse(baseline);
  }

  void drawCourse(float baseline) {
    int x = 0;
    float prev = datas.get(0) + baseline;
    for(int i = 1; i < datas.size(); i++) {
      float now = datas.get(i) + baseline;
      line(x, prev, x + step, now);

      x += step;
      prev = now;
    }
  }

  void drawBorder(float baseline) {
    for(int i = 0; i < 10; i++) {
      stroke(255, 127, 127, 50 - 5 * i);
      strokeWeight(10);
      drawCourse(baseline + 10 * i);
      drawCourse(baseline - 10 * i);
      strokeWeight(1);
    }
  }

  float distance(float baseline, int x, float y) {
    int idx = x / step;
    float tmp_height = datas.get(idx);
    float cur_height = tmp_height + baseline;
    float distance = abs(cur_height - y);
    return distance;
  }

  void printData() {
    for(int i = 0; i < datas.size(); i++)
      print(" " + datas.get(i));
    println("");
  }
}