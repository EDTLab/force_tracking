abstract class Active extends State {
  float active_x;
  float duration;
  float time_start, time_passed;
  String tp;

  Course course;
  float course_point_interval = 0.1; // adding a point every 0.1 sec
  int course_point;

  float[] input_data;

  Active(int w, int h, float dur) {
    super(w, h);
    duration = dur;
    active_x = 0;
    time_start = seconds();
    course = new Course();

    input_data = new float[w];
  }

  Course getCourse() {
    return course;
  }

  float getInput() {
    float input = mp.getValue(RIGHT);
    if(active_x < input_data.length)
      input_data[(int)active_x] = input;
    return input;
  }
  
  void stepForward() {
    time_passed = seconds() - time_start;
    active_x = width * time_passed / duration;
    if (time_passed > duration) {
      states.next();
    }
  }
  
  float seconds() {
    return millis() / 1000.0;
  }

  void showTitle(String s) {
    textAlign(CENTER, CENTER);
    textSize(height * 0.2);
    fill(255, 50);
    text(s, width * 0.5, height * 0.5);
  }

  void showTimePassed() {
    tp = nf(time_passed, 2, 3);
    textAlign(LEFT, CENTER);
    textSize(20);
    fill(255);
    text(tp + " sec", 50, 50);
  }
}
