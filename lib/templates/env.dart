class Env {
  final String ip = 'http://192.168.0.6:3000';

  static Env env = Env();

  static Env get() {
    return env;
  }
}
