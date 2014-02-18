class Stage {
  final int IDLE = 0;
  final int GAME0 = 10;
  final int GAME1 = 11;
  final int GAME2 = 12;
  final int GAME3 = 13;
  final int GAME4 = 14;
  final int TEST = 20;
  final int RESULT = 30;

  Stage() {
    setupIdle();
  }

  PVector pos_title;
  PVector pos_button;
  float font_size_title;
  float font_size_button;
  PVector size_button;

  void setupIdle() {
    pos_title = new PVector(width * 0.5, height * 0.4);
    font_size_title = height * 0.1;

    pos_button = new PVector(width * 0.5, height * 0.725);
    font_size_button = font_size_title * 0.5;
    size_button = new PVector(width * 0.3, height * 0.1);
  }

  void drawIdle() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(font_size_title);
    text("Force Tracking Test", pos_title.x, pos_title.y);

    noStroke();
    rectMode(CENTER);
    if((mouseX > pos_button.x - size_button.x * 0.5 && mouseX < pos_button.x + size_button.x * 0.5)
      && (mouseY > pos_button.y - size_button.y * 0.5 && mouseY < pos_button.y + size_button.y * 0.5)) {
      // mouse over
      fill(195, 42, 23);
      if(mousePressed) {
        // onPressEvent
        nextStage();
      }
    } else {
      fill(255, 102, 83);
    }
    rect(pos_button.x, pos_button.y, size_button.x, size_button.y);
    fill(255);
    textSize(font_size_button);
    text("START", pos_button.x, pos_button.y);
  }

  void nextStage() {
    println("Stage.nextStage() BANG!!");
  }
};
