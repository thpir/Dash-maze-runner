import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:dash_maze_runner/controller/ocr_helper.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcrAction extends StatelessWidget {
  const OcrAction({super.key});

  @override
  Widget build(BuildContext context) {
    final ocrHelper = Provider.of<OcrHelper>(context);
    final gameController = Provider.of<GameController>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      height: kBottomNavigationBarHeight,
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            List<String> result =
                await ocrHelper.takeSnapshotForTextRecognition();
            for (String text in result) {
              for (String wordToFind in gameController.wordsToDetect) {
                if (!gameController.detectedWords.contains(wordToFind)) {
                  if (text.toLowerCase().contains(wordToFind)) {
                    gameController.detectedWords.add(wordToFind);
                  }
                }
              }
            }
            if (gameController.detectedWords.length ==
                gameController.wordsToDetect.length) {
              gameController.completeOcrQuest();
            }
            if (context.mounted) Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: buttonTextColor,
              backgroundColor: buttonBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: const Text(
            "Scan text",
            style: TextStyle(fontFamily: "theren"),
          ),
        ),
      ),
    );
  }
}
