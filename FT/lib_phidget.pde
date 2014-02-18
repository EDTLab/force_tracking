import com.phidgets.event.BridgeDataListener;
import com.phidgets.BridgePhidget;
import com.phidgets.event.BridgeDataEvent;
import com.phidgets.event.ErrorListener;
import com.phidgets.event.ErrorEvent;

class FTPhidget {
  BridgePhidget b;
  BridgeDataListener bdl;
  ErrorListener el;
  final int RIGHT = 0;
  final int LEFT = 1;
  float[] v;
  float min, max;

  FTPhidget() {
    v = new float[2];

    try {
      b = new BridgePhidget();
      b.openAny();
      println("Waiting for Phidget");
      b.waitForAttachment();

      el = new ErrorListener() {
        public void error(ErrorEvent ex) {
          println("\n--->Error: " + ex.getException());
        }
      };
      b.addErrorListener(el);
      println("OK ready to go");

      // show phidget info
      println("Phidget Information");
      println("==============================");
      println("Version: " + b.getDeviceVersion());
      println("Name: " + b.getDeviceName());
      println("Serial #: " + b.getSerialNumber());
      println("# Bridges: " + b.getInputCount());

      // set enable for only 0, 1
      for(int i = 2; i < b.getInputCount(); i++)
        b.setEnabled(i, false);
      b.setEnabled(LEFT, true);
      b.setEnabled(RIGHT, true);
      b.setGain(LEFT, BridgePhidget.PHIDGET_BRIDGE_GAIN_128);
      b.setGain(RIGHT, BridgePhidget.PHIDGET_BRIDGE_GAIN_128);
      max = (float)b.getBridgeMax(RIGHT);
      min = (float)b.getBridgeMin(RIGHT);

      println("Device RIGHT Max, Min: (" + b.getBridgeMax(RIGHT) + ", " + b.getBridgeMin(RIGHT) + ")");
      println("Device LEFT Max, Min: (" + b.getBridgeMax(LEFT) + ", " + b.getBridgeMin(LEFT) + ")");

      b.setDataRate(10);  // read data at every 10 milliseconds

      bdl = new BridgeDataListener() {
        public void bridgeData(BridgeDataEvent bde) {
          if(bde.getIndex() < 2)
            v[bde.getIndex()] = (float)bde.getValue();
        }
      };
      b.addBridgeDataListener(bdl);
    } catch (Exception e) {
      println("ERROR");
      println(e);
    }
  }

  void onStop() {
    try {
      b.removeBridgeDataListener(bdl);
      b.removeErrorListener(el);

      b.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    b = null;
    println("\nTurning off Phidget Bridge");
  }
};
