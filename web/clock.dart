part of tetrad_block_stacker;

class Clock {
  int nanoSeconds;
  double timeScale;
  bool isPaused;
  int dt;

  static int cyclesPerMilliSecond = 1000;

  Clock(double startTimeMilliSeconds) {
    nanoSeconds = milliSecondsToNanoSeconds(startTimeMilliSeconds);
    timeScale = 1.0;
    isPaused = false;
    dt = 0;
  }

  double calcDeltaSeconds(final Clock c) {
    int dt = nanoSeconds - c.nanoSeconds;
    return cyclesToMilliSeconds(dt);
  }

  void update(double dtRealMilliSeconds) {
    var start = nanoSeconds;
    if (!isPaused) {
      int dtScaledCycles = milliSecondsToNanoSeconds(dtRealMilliSeconds * timeScale);
      nanoSeconds += dtScaledCycles;
    }
    dt = nanoSeconds - start;
  }

  void singleStep() {
    if (isPaused) {
      int dtScaledCycles = milliSecondsToNanoSeconds((1.0 / 60.0) * timeScale);
      nanoSeconds += dtScaledCycles;
    }
  }

  double get dtMs => cyclesToMilliSeconds(dt);

  double cyclesToMilliSeconds(int timeCycles) => timeCycles / cyclesPerMilliSecond;

  int milliSecondsToNanoSeconds(double startTimeMilliSeconds) => (startTimeMilliSeconds * cyclesPerMilliSecond).toInt();
}
