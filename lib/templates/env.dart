class Env {
  final String ip = 'https://samanyu13-public-transport-backend.glitch.me';
  // final String ip = 'http://192.168.0.6:3000';

  static Env env = Env();

  static Env get() {
    return env;
  }
}
