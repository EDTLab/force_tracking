abstract class Passive extends State {
  ButtonNext btnNext;
  PVector ttl_p;
  float ttl_s;

  Passive(int w, int h) {
    super(w, h);
  }

  class ButtonNext extends Button {
    ButtonNext(PVector pos, PVector size, String n, color dft, color hvr) {
      super(pos, size, n, dft, hvr);
    }

    void onClickHandler() {
      states.next();
    }
  }
}
