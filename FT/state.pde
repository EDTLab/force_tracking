abstract class State {
  int width;
  int height;

  State(int w, int h) {
    width = w;
    height = h;
  }

  abstract void update();
  abstract void display();
}
