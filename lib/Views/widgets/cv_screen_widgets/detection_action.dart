import 'package:dash_maze_runner/controller/game_controller.dart';
import 'package:dash_maze_runner/controller/vision_helper.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionAction extends StatefulWidget {
  const DetectionAction({super.key});

  @override
  State<DetectionAction> createState() => _DetectionActionState();
}

class _DetectionActionState extends State<DetectionAction> {
  @override
  Widget build(BuildContext context) {
    final visionHelper = Provider.of<VisionHelper>(context);
    final gameController = Provider.of<GameController>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      height: kBottomNavigationBarHeight,
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: ElevatedButton(
          onPressed: visionHelper.objectDetected
              ? () async {
                  await gameController.completeCvQuest();
                  if (context.mounted) Navigator.of(context).pop();
                }
              : null,
          style: visionHelper.objectDetected
              ? ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor,
                  backgroundColor: buttonBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))
              : null,
          child: const Text(
            "Unlock the door",
            style: TextStyle(fontFamily: "theren"),
          ),
        ),
      ),
    );
  }
}
