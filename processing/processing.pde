
//MyPhidget mp;

Course course;
Coins coins;

int number_of_courses = 5;

int gx = 0;
int x_step = 10;
int game_plain_threshold = 5;
float[] game_plain_direction;
float amplifier = 8;
long game1_point = 0;
long game2_point = 0;

float baseline_rate = 0.9;
float baseline_for_signal;
float baseline_for_course;
float[] val, val_prev;

Stage stage;

void setup() {
 /*
 * 전체화면 (displayWidth, displayHeight)
 */
 size(displayWidth, displayHeight);
 background(0);
 randomSeed(hour() * 3600 + minute() * 60 + second());

// mp = new MyPhidget(10);

 course = new Course(number_of_courses);
 coins = new Coins(40, 20);

 baseline_for_signal = height * baseline_rate;
 baseline_for_course = baseline_for_signal * 0.9;

 game_plain_direction = new float[2];
 val = new float[2];
 val_prev = new float[2];

 stage = new Stage();

 // for exit procedure
 prepareExitHandler();
}

void draw() {
 val[mp.RIGHT] = map(mp.v[mp.RIGHT] * amplifier, mp.max, 0, height, 0);
 val[mp.LEFT] = map(mp.v[mp.LEFT] * amplifier, mp.max, 0, height, 0);

  stage.drawIdle();
  // drawGraph();
  // drawGame();
  // drawGame2();

 val_prev[mp.RIGHT] = val[mp.RIGHT];
 val_prev[mp.LEFT] = val[mp.LEFT];
  gx = (gx + x_step) % width;
}

void drawGrid(int interval) {
 stroke(0, 64, 0);
 for(int i = 0; i < width / interval; ++i) {
   if(i % 5 == 0)
     strokeWeight(2);
   else
     strokeWeight(0.5);
   int gx = i * interval;
   line(gx, 0, gx , height);
 }

  for (int i = 0; i < height / interval; ++i) {
    if(i % 5 == 0)
      strokeWeight(2);
    else
      strokeWeight(0.5);
    int y = i * interval;
    line(0, y, width, y);
  }
}

void drawGraph() {
  if(gx == 0) {
    background(0);
    drawGrid(25);
    course.setup((int)random(3) + 2);
    course.draw(baseline_for_course);
  }

  strokeWeight(1);
  stroke(255, 0, 255);
  line(gx, baseline_for_signal - val_prev[mp.RIGHT], gx + x_step, baseline_for_signal - val[mp.RIGHT]);
  // stroke(0, 255, 0);j
  // line(gx, baseline_for_signal - val_prev[mp.LEFT], gx + x_step, baseline_for_signal - val[mp.LEFT]);
}

void drawGame() {
  if(gx == 0) {
    course.setup((int)random(3) + 2);
    coins.setup(course.getData());
    game1_point = 0;
  }
  background(0);
  drawGrid(25);
  course.draw(baseline_for_course);
  coins.draw(baseline_for_course);

  int tmpx = gx;
  float tmpy;
  noStroke();
  /*
  * case : fix direction of airplain
  */
  tmpy = baseline_for_signal - val_prev[mp.RIGHT];
  game1_point += coins.collision_detection((int)baseline_for_course, tmpx, tmpy, 20);
  fill(255);
  textSize(30);
  text("POINT : " + game1_point, 50, 50);
  fill(255, 0, 255);
  triangle(tmpx + 20, tmpy, tmpx - 20, tmpy + 10, tmpx - 20, tmpy - 10);
  // tmpy = baseline_for_signal - val_prev[mp.LEFT];
  // coins.collision_detection((int)baseline_for_course, tmpx, tmpy, 20);
  // fill(0, 255, 0);
  // triangle(tmpx + 20, tmpy, tmpx - 20, tmpy + 10, tmpx - 20, tmpy - 10);
}

void drawGame2() {
  if(gx == 0) {
    course.setup((int)random(3) + 2);
    game2_point = 0;
  }
  int tmpx = gx;
  float tmpy;

  tmpy = baseline_for_signal - val_prev[mp.RIGHT];
  float distance = course.distance(baseline_for_course, tmpx, tmpy);

  background(distance, 0, 0);
  drawGrid(25);
  course.draw(baseline_for_course);

  noStroke();
  /*
  * calculate the point
  */
  int tmp_point = (int)sq(constrain(400 - distance, 0, 400));
  fill(255);
  textSize(30);
  text("DISTANCE: " + distance, 50, 50);
  text("POINT: " + tmp_point, 50, 100);
  game2_point += tmp_point;
  text("TOTAL: " + game2_point, 50, 150);

  fill(255, 0, 255);
  triangle(tmpx + 20, tmpy, tmpx - 20, tmpy + 10, tmpx - 20, tmpy - 10);
}

// for exit procedure
private void prepareExitHandler() {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      //TODO: here comes shutdown hook
      try {
        mp.onStop();
        stop();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }));
}
