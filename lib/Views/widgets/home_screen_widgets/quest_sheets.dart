import 'package:dash_maze_runner/Views/screens/cv_screen.dart';
import 'package:dash_maze_runner/Views/screens/ocr_screen.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';

void showCvQuest(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: darkBackground,
      builder: (context) => SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You arrive at a door with a lock. The keyhole shows a somewhat familiar shape:',
                      style: TextStyle(
                          fontFamily: 'super_boys', color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/images/lock_flutter.png",
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Can you find an object around you with the same shape to unlock the door?',
                      style: TextStyle(
                          fontFamily: 'super_boys', color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CvScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: buttonTextColor,
                            backgroundColor: buttonBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Find key",
                          style: TextStyle(fontFamily: "theren"),
                        ))
                  ],
                )),
          )));
}

void showOcrQuest(BuildContext context, List<Widget> wordsToDetect) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: darkBackground,
      builder: (context) => SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You arrive at a door with a lock. There is a grid with random letters, underneath the grid four words are shown:',
                      style: TextStyle(
                          fontFamily: 'super_boys', color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    ...wordsToDetect,
                    const SizedBox(height: 20),
                    const Text(
                      'Scan text around you containing these words to unlock the door.',
                      style: TextStyle(
                          fontFamily: 'super_boys', color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const OcrScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: buttonTextColor,
                            backgroundColor: buttonBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Find words",
                          style: TextStyle(fontFamily: "theren"),
                        ))
                  ],
                )),
          )));
}