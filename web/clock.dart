part of tetrad_block_stacker;

class Clock {
  int timeCycles;
  double timeScale;
  bool isPaused;
  
  static int cyclesPerSecond = 1000;
  
  Clock(double startTimeSeconds) {
    timeCycles = secondsToCycles(startTimeSeconds);
    timeScale = 1.0;
    isPaused = false;
  }
  
  double calcDeltaSeconds(final Clock c) {
    int dt = timeCycles - c.timeCycles;
    return cyclesToSeconds(dt);
  }
  
  void update(double dtRealSeconds) {
    if (!isPaused) {
      int dtScaledCycles = secondsToCycles(dtRealSeconds * timeScale).toInt();
      timeCycles += dtScaledCycles;
    }
  }
  
  void singleStep() {
    if (isPaused) {
      int dtScaledCycles = secondsToCycles((1.0/60.0) * timeScale);
      timeCycles += dtScaledCycles;
    }
  }

  double cyclesToSeconds(int timeCycles) => timeCycles / cyclesPerSecond;

  int secondsToCycles(double startTimeSeconds) => (startTimeSeconds * cyclesPerSecond).toInt();
}