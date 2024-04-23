import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const dashPositionX = 'dashPositionX';
  static const dashPositionY = 'dashPositionY';

  setDashPosition(int x, int y) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(dashPositionX, x);
    prefs.setInt(dashPositionY, y);
  }

  Future<List<int?>> getDashPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? x = prefs.getInt(dashPositionX);
    int? y = prefs.getInt(dashPositionY);
    return [x, y];
  }
}
