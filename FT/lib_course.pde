import java.util.Date;

class Course {
  private float[] datas;
  private float[] amplifiers;
  private final int period_length_min = width / 8;
  private color c_pssd = color(255, 255, 0);
  private color c_dflt = color(0, 255, 255);
  private APeriod[] periods;

  Course() {
    randomSeed((new Date()).getTime());
    datas = new float[width];
    amplifiers = new float[]{
      height / 4,
      height / 5,
      height / 6,
      height / 7,
      height / 8
    };
  }

  /*
   * generate a period of sine data
   */
  float[] generateAPeriod(float amp, int period, float baseline) {
    float[] tmp = new float[period];
    for (int i = 0; i < tmp.length; i++) {
      tmp[i] = sin(TWO_PI / tmp.length * i) * amp + baseline;
    }
    return tmp;
  }

  /*
   * initiate datas
   */
  void init(int num, float baseline) {
    // generate lengths of periods
    int[] prds = new int[num];

    int sum = datas.length + 1;
    int remainder;
    while (sum > datas.length - period_length_min) {
      sum = 0;
      remainder = datas.length - period_length_min;
      for(int i = 0; i < num - 1; i++) {
        prds[i] = (int)random(period_length_min, remainder);
        remainder -= prds[i];
        sum += prds[i];
      }
    }
    prds[prds.length - 1] = datas.length - sum;

    // shuffle the order of the periods
    if(prds.length > 1) {
      int idx, tmp;
      for(int i = 0; i < prds.length; i++) {
        idx = (int)random(prds.length);
        tmp = prds[i];
        prds[i] = prds[idx];
        prds[idx] = tmp;
      }
    }

    // generate sine curves
    int index = 0;
    periods = new APeriod[prds.length];
    for(int i = 0; i < prds.length; i++) {
      periods[i] = new APeriod();
      periods[i].amp = amplifiers[(int)random(amplifiers.length)];
      periods[i].prd = prds[i];
      periods[i].x = index;
      periods[i].y = baseline;
      
      float[] src = generateAPeriod(periods[i].amp, periods[i].prd, periods[i].y);
      arrayCopy(src, 0, datas, index, periods[i].prd);
      
      index += periods[i].prd;
    }
  }

  /*
   * initiate datas
   */
  void init(Course crs) {
    periods = new APeriod[crs.periods.length];
    arrayCopy(crs.periods, periods);
    arrayCopy(crs.datas, datas);
  }

  float[] getDatas() {
    return datas;
  }

  int getPoint(float x, float y, float size) {
    float boundary = size * 2;
    float point = 0;
    if (x < datas.length)
      point = constrain(boundary - abs(datas[(int)x] - y), 0, boundary);
    point = point / boundary * 100;
    return (int)point;
  }

  void display() {
    display(-1);
  }

  void display(float x) {
    drawDefault();
    drawPassed(x);
  }

  void drawDefault() {
    stroke(c_dflt);
    for(APeriod p : periods)
      p.display();
  }

  void drawPassed(float x_passed) {
    stroke(c_pssd);
    float prev = datas[0];
    for(int x = 1; x < x_passed; x++) {
      line(x - 1, prev, x, datas[x]);
      prev = datas[x];
    }
  }

  float distance(int x, float y) {
    return abs(datas[x] - y);
  }

  void printData() {
    for(int i = 0; i < datas.length; i++)
      print(" " + datas[i]);
    println("");
  }

  class APeriod {
    int prd;
    float amp;
    float x, y;

    void display() {
      noFill();
      pushMatrix();
        translate(x, y);
        beginShape();
          vertex(0, 0);
          bezierVertex(prd * 0.14, amp * 0.9, prd * (0.25 - 0.05), amp, prd * 0.25, amp);
          bezierVertex(prd * (0.25 + 0.05), amp, prd * (0.5 - 0.14), amp * 0.9, prd * 0.5, 0);
          bezierVertex(prd * (0.5 + 0.14), -amp * 0.9, prd * (0.75 - 0.05), -amp, prd * 0.75, -amp);
          bezierVertex(prd * (0.75 + 0.05), -amp, prd * (1 - 0.14), -amp * 0.9, prd, 0);
        endShape();
      popMatrix();
    }
  }
}
