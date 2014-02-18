class Coins {
  final float interval = 0.5;  // coins are placed with every 0.5 second;
  int step;
  final float coin_radius = height * 0.01;
  final int max_point = 1000;

  ACoin[] coins;

  Coins(float[] course) {
    int num = (int)(duration / interval);
    step = course.length / num;

    coins = new ACoin[num];
    for(int i = 0; i < num; i++) {
      coins[i] = new ACoin(i * step, course[i * step], coin_radius);
    }
  }

  void display() {
    for(ACoin c : coins) {
      c.display();
    }
  }

  int collision_detection(float x, float y, float size) {
    for(ACoin c : coins) {
      if(c.collisionCheck(x, y, size)) {
        return c.collide(y, size);
      }
    }
    return 0;
  }

  private class ACoin {
    float radius;

    final int ALIVE = 2;
    final int FADE = 1;
    final int DONE = 0;
    int state = ALIVE;

    int fade_duration = 50;
    int point = 0;

    PVector pos;
    
    ACoin(float x, float y, float r) {
      pos = new PVector(x, y);
      radius = r;
    }

    void display() {
      switch(state) {
        case ALIVE:
          // draw a coin
          strokeWeight(1);
          stroke(0);
          fill(255, 255, 0);
          ellipse(pos.x, pos.y, radius * 2, radius * 2);
          break;
        case FADE:
          if(fade_duration == 0) {
            state = DONE;
          } else {
            // draw the point
            strokeWeight(1);
            stroke(0);
            fill(255, fade_duration * 2);
            textSize(radius * 3);
            textAlign(CENTER, CENTER);
            pos.y -= radius * 0.25; // point text goes up
            text(point, pos.x, pos.y);
            fade_duration--;
          }
          break;
        case DONE:
        default:
      }
    }

    boolean collisionCheck(float x, float y, float size) {
      float boundary = radius + size;
      if(state == ALIVE && abs(pos.x - x) < (boundary * 2)) {
        return (dist(pos.x, pos.y, x, y) < boundary);  // TODO : collision condition
      } else {
        return false;
      }
    }

    int collide(float y, float size) {
      // calculate point from distance
      float boundary = radius + size;
      float distance = boundary - abs(pos.y - y);
      if(distance > 0) {
        // algorithm for ceiling out 1's number
        point = (int)(distance / boundary * max_point / 10) + 1;
        if(point == 11) point = 10;
        point *= 10;
      }

      audio_coin.play(0);

      state = FADE;
      pos.y -= boundary;

      return point;
    }
  }
}
