public class Test extends Active {

  Test (int w, int h, float dur, Course c) {
    super(w, h, dur);
    course.init(c);
  }

  Test (int w, int h, float dur) {
    super(w, h, dur);
    course.init(Game.HARD, h * 0.5);
  }

  void update() {
    stepForward();
  }

  void display() {
    background(0);

    showTitle("Test Stage");

    drawGrid(width / duration / 10);
    course.display(active_x);

    showTimePassed(); //<>//

    // display the character
    fill(255, 0, 255);
    ellipse(active_x, getInput(), 20, 20);
  }

  void drawGrid(float interval) {
    stroke(0, 64, 0);
    for(int i = 0; i < width / interval; ++i) {
      if(i % 5 == 0)
        strokeWeight(2);
      else
        strokeWeight(0.5);
      float x = i * interval;
      line(x, 0, x , height);
    }

    for (int i = 0; i < height / interval; ++i) {
      if(i % 5 == 0)
        strokeWeight(2);
      else
        strokeWeight(0.5);
      float y = i * interval;
      line(0, y, width, y);
    }
  }

  float[][] getData() {
    float[][] tmp = new float[2][];
    tmp[0] = course.getDatas();
    tmp[1] = input_data;
    return tmp;
  }
}
