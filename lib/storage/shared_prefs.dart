import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const dashPositionX = 'dashPositionX';
  static const dashPositionY = 'dashPositionY';
  static const cvQuestStatus = 'cvQuestStatus';
  static const ocrQuestStatus = 'ocrQuestStatus';

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

  setCvQuestStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(cvQuestStatus, status);
  }

  Future<bool> getCvQuestStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(cvQuestStatus) ?? false;
  }

  setOcrQuestStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ocrQuestStatus, status);
  }

  Future<bool> getOcrQuestStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ocrQuestStatus) ?? false;
  }
}
