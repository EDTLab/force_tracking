class States {
  /*
   * constructor
   */
  private State state = null;
  private int width;
  private int height;
  private float duration;

  States(int w, int h, float dur) {
    width = w;
    height = h;
    duration = dur;
    state = new Idle(width, height);
  }

  /*
   * next()
   */
  void next() {
    if (state instanceof Idle) {
      state = new Game(width, height, duration, Game.EASY);
    } else if (state instanceof Game) {
      switch (((Game)state).getDifficulty()) {
        case 1:
          state = new Game(width, height, duration, Game.NORMAL);
          break;
        case 2:
          state = new Game(width, height, duration, Game.HARD);
          break;
        default :
          state = new Test(width, height, duration, ((Game)state).getCourse());
          break;
      }
    } else if (state instanceof Test) {
      state = new Result(width, height, ((Test)state).getData());
    } else {
      state = new Idle(width, height);
    }
  }

  /*
   * goTest()
   */
  void goTest() {
    state = new Test(width, height, duration);
  }
  /*
   * draw()
   */
  void display() {
    state.update();
    state.display();
  }
}
