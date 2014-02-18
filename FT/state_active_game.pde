class Game extends Active {
  private int difficulty;
  public static final int EASY = 1;
  public static final int NORMAL = 2;
  public static final int HARD = 3;

  final float radius = height * 0.03;

  // for point
  Coins coins;
  long coin_points = 0;
  final float guide_points_interval = 0.1;  // time interval in second
  float guide_time_prev,
        guide_time;
  long  guide_points = 0,
        guide_points_total = 0;

  ButtonTest btnTest;

  Game (int w, int h, float dur, int df) {
    super(w, h, dur);
    difficulty = df;
    course.init(df, h * 0.5);

    coins = new Coins(course.getDatas());
    guide_time_prev = seconds();

    // skip button
    PVector btnPos = new PVector(w * 0.9, h * 0.05);
    PVector btnSize = new PVector(w * 0.1, h * 0.05);
    color dft = color(225, 102, 83);
    color hvr = color(195, 42, 23);
    btnTest = new ButtonTest(btnPos, btnSize, "Skip to Test", dft, hvr);
  }

  int getDifficulty() {
    return difficulty;
  }

  void update() {
    stepForward();

    float input = getInput();

    // calculate coin point
    coin_points += coins.collision_detection(active_x, input, radius);

    // calculate guide point
    guide_time = seconds() - guide_time_prev;
    if(guide_time > guide_points_interval) {
      guide_points = course.getPoint(active_x, input, radius * 5);
      guide_points_total += guide_points;
      guide_time_prev = seconds();
    }
  }

  void display() {
    background(0);

    showTitle("Game Stage " + difficulty);

    course.display(active_x);
    coins.display();

    showTimePassed();
    // display coin point
    text("coin   : " + coin_points, 50, 100);
    text("course : " + guide_points_total + " (+" + guide_points + ")", 50, 150);

    // display the character
    fill(255, 0, 255);
    ellipse(active_x, mouseY, radius * 2, radius * 2);

    btnTest.display();
  }

  /*
   * ButtonTest Class
   */
  class ButtonTest extends Button {
    ButtonTest(PVector pos, PVector size, String n, color dft, color hvr) {
      super(pos, size, n, dft, hvr);
    }

    void onClickHandler() {
      states.goTest();
    }
  }
}
