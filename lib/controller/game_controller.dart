import 'package:dash_maze_runner/views/widgets/home_screen_widgets/quest_sheets.dart';
import 'package:dash_maze_runner/data/mazes.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:dash_maze_runner/storage/shared_prefs.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  late BuildContext context;
  late int _currentX;
  late int _currentY;
  bool cvQuestCompleted = false;
  bool ocrQuestCompleted = false;
  bool gameFinished = false;
  List<List<dynamic>> mazeQuests = [];
  List<String> detectedWords = [];
  List<String> wordsToDetect = ["flutter", "meetup", "belgium", "dash"];
  final SharedPrefs _sharedPrefs = SharedPrefs();

  int get currentX => _currentX;
  int get currentY => _currentY;

  GameController() {
    _setStartLocation();
    _moveToSavedPosition();
  }

  Future<void> resetGame() async {
    _setStartLocation();
    await _saveDashPosition();
    cvQuestCompleted = false;
    ocrQuestCompleted = false;
    gameFinished = false;
    await _sharedPrefs.setCvQuestStatus(cvQuestCompleted);
    await _sharedPrefs.setOcrQuestStatus(ocrQuestCompleted);
    detectedWords = [];
    notifyListeners();
  }

  void shouldShowQuestInfo(int deltaX, int deltaY) {
    if (!cvQuestCompleted &&
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "cv") {
      if (context.mounted) showCvQuest(context);
    }
    if (!ocrQuestCompleted &&
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "ocr") {
      if (context.mounted) {
        showOcrQuest(context, _setWordsToDetect());
      }
    }
  }

  List<Widget> _setWordsToDetect() {
    List<Widget> words = [];
    for (String word in wordsToDetect) {
      if (detectedWords.contains(word)) {
        words.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                word,
                style: const TextStyle(
                    fontFamily: 'super_boys',
                    color: greenBackground,
                ),
              ),
              const Icon(Icons.check, color: greenBackground, size: 20.0)
            ],
          ),
        );
      } else {
        words.add(
          Text(
            word,
            style: const TextStyle(
                fontFamily: 'super_boys', color: buttonBackgroundColor),
          ),
        );
      }
    }
    return words;
  }

  void _setStartLocation() {
    for (int i = 0; i < mazeLevel001.length; i++) {
      for (int j = 0; j < mazeLevel001[i].length; j++) {
        if (mazeLevel001[i][j] == "s") {
          _currentX = j;
          _currentY = i;
        }
      }
    }
  }

  Future<void> _moveToSavedPosition() async {
    var savedDashposition = await _sharedPrefs.getDashPosition();
    if (savedDashposition[0] != null && savedDashposition[1] != null) {
      _currentX = savedDashposition[0]!;
      _currentY = savedDashposition[1]!;
    }
    cvQuestCompleted = await _sharedPrefs.getCvQuestStatus();
    ocrQuestCompleted = await _sharedPrefs.getOcrQuestStatus();
    notifyListeners();
  }

  Future<void> _saveDashPosition() async {
    await _sharedPrefs.setDashPosition(_currentX, _currentY);
  }

  Future<void> completeCvQuest() async {
    cvQuestCompleted = true;
    await _sharedPrefs.setCvQuestStatus(cvQuestCompleted);
    notifyListeners();
  }

  Future<void> completeOcrQuest() async {
    ocrQuestCompleted = true;
    await _sharedPrefs.setOcrQuestStatus(ocrQuestCompleted);
    notifyListeners();
  }

  void moveUp() async {
    if (_currentY > 0) {
      if (canMove(0, -1)) {
        _currentY--;
        await _saveDashPosition();
        notifyListeners();
        checkForWin();
      }
      shouldShowQuestInfo(0, -1);
    }
  }

  void moveDown() async {
    if (_currentY < 10) {
      if (canMove(0, 1)) {
        _currentY++;
        await _saveDashPosition();
        notifyListeners();
        checkForWin();
      }
      shouldShowQuestInfo(0, 1);
    }
  }

  void moveLeft() async {
    if (_currentX > 0) {
      if (canMove(-1, 0)) {
        _currentX--;
        await _saveDashPosition();
        notifyListeners();
        checkForWin();
      }
      shouldShowQuestInfo(-1, 0);
    }
  }

  void moveRight() async {
    if (_currentX < 10) {
      if (canMove(1, 0)) {
        _currentX++;
        await _saveDashPosition();
        notifyListeners();
        checkForWin();
      }
      shouldShowQuestInfo(1, 0);
    }
  }

  checkForWin() {
    if (mazeLevel001[_currentY][_currentX] == "f") {
      gameFinished = true;
      notifyListeners();
    }
  }

  bool canMove(int deltaX, int deltaY) {
    if (mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "cv" &&
        !cvQuestCompleted) {
      return false;
    } else if (mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "ocr" &&
        !ocrQuestCompleted) {
      return false;
    } else if (mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "e" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "s" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "f" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "cv" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "ocr") {
      return true;
    } else {
      return false;
    }
  }
}
