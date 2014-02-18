/*
 * global variables for step progress
 */
FTPhidget mp;
States states;
float duration = 10; // duration of each active state in second
/*
 * global variables for audio
 */
import ddf.minim.*;
Minim minim;
AudioPlayer audio_coin;

/*
 * override method: setup()
 */
void setup() {
//  size(displayWidth, displayHeight);
  size(800, 450);

  states = new States(width, height, duration);

  // for exit procedure
//  mp = new FTPhidget();

  // for audio
  minim = new Minim(this);
  audio_coin = minim.loadFile("coin.mp3");
  
  prepareExitHandler();
}

/*
 * override method: draw()
 */
void draw() {
  states.display();
}

/*
 * override method: mouseClicked()
 */
void mouseClicked() {
  if(states.state instanceof Passive) {
    ((Passive)states.state).btnNext.onClicked(mouseX, mouseY);
  } else if(states.state instanceof Game) {
    ((Game)states.state).btnTest.onClicked(mouseX, mouseY);
  }
}

// for exit procedure
private void prepareExitHandler() {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      //TODO: here comes shutdown hook
      try {
//        mp.onStop();

        audio_coin.close();
        minim.stop();

        stop();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }));
}
