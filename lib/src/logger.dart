class Logger {

  bool isDebug = false;

  static final Logger _instance = new Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();


  init(bool isDebug) {
    this.isDebug = isDebug;
  }

  log(Object object) {
    if (!isDebug) {
      return;
    } else {
      print(object);
    }
  }
}