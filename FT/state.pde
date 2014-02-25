abstract class State {
  int width;
  int height;

  PShape bg;

  State(int w, int h) {
    width = w;
    height = h;

    bg = loadShape("svg/background.svg");
  }

  abstract void update();
  abstract void display();
}
