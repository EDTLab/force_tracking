class Coins {
  boolean[] be;
  PVector[] pos;
  int step;
  float radius;

  Coins(int num, float rad) {
    step = width / num;
    radius = rad;

    be = new boolean[num];
    pos = new PVector[num];

    // this.setup();
  }

  void setup(float[] datas) {
    for(int i = 0; i < be.length; i++) {
      be[i] = true;
      int j = i * datas.length / be.length;
      if(pos[i] == null)
        pos[i] = new PVector(i * step, datas[j]);
      else
        pos[i].set(i * step, datas[j]);
    }
  }

  void draw(float base) {
    stroke(0);
    fill(255, 255, 0);
    for(int i = 1; i < be.length; i++) {
      if(be[i]) {
        ellipse(pos[i].x, pos[i].y + base, radius, radius);
        // TODO : draw a coin!!
      }
    }
  }

  int collision_detection(int base, float x, float y, float size) {
    float boundary = radius + size;
    for(int i = 0; i < be.length; i++) {
      // if(be[i] && x < pos[i].x && pos[i].x - x < (boundary * 2)) {
      if(be[i] && abs(pos[i].x - x) < (boundary * 2)) {
        float distance = dist(pos[i].x, pos[i].y + base, x, y);
        // println("" + i + " collision_detection: (" + pos[i].x + ", " + (pos[i].y + base) + ", " + x + ", " + y + ")");
        // println("" + i + " collision_detection: (" + distance + ")");
        if(distance < boundary) {
          be[i] = false;
          println("BANG BANG BANG !!! " + i);
          // TODO : a collision happen!!
          return 5000;
        }
      }
    }
    return 0;
  }
}