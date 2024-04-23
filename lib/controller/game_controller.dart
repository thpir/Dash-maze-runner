import 'package:dash_maze_runner/data/mazes.dart';
import 'package:dash_maze_runner/storage/shared_prefs.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  late int _currentX;
  late int _currentY;
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
    notifyListeners();
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
    notifyListeners();
  }

  Future<void> _saveDashPosition() async {
    await _sharedPrefs.setDashPosition(_currentX, _currentY);
  }

  void moveUp() async {
    if (_currentY > 0) {
      if (canMove(0, -1)) {
        _currentY--;
        await _saveDashPosition();
        notifyListeners();
      }
    }
  }

  void moveDown() async {
    if (_currentY < 10) {
      if (canMove(0, 1)) {
        _currentY++;
        await _saveDashPosition();
        notifyListeners();
      }
    }
  }

  void moveLeft() async {
    if (_currentX > 0) {
      if (canMove(-1, 0)) {
        _currentX--;
        await _saveDashPosition();
        notifyListeners();
      }
    }
  }

  void moveRight() async {
    if (_currentX < 10) {
      if (canMove(1, 0)) {
        _currentX++;
        await _saveDashPosition();
        notifyListeners();
      }
    }
  }

  bool canMove(int deltaX, int deltaY) {
    if (mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "e" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "s" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "f" ||
        mazeLevel001[_currentY + deltaY][_currentX + deltaX] == "l") {
      return true;
    } else {
      return false;
    }
  }
}
