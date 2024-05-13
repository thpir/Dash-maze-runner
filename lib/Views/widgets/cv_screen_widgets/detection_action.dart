import 'package:dash_maze_runner/controller/game_controller.dart';
//import 'package:dash_maze_runner/controller/flutter_vision_helper.dart';
import 'package:dash_maze_runner/controller/pytorch_lite_helper.dart';
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
    /* Uncomment if you are using the FlutterVisionHelper */
    // final visionHelper = Provider.of<FlutterVisionHelper>(context);
    /* Uncomment if you are using the FlutterVisionHelper */
    final visionHelper = Provider.of<PytorchLiteHelper>(context);
    final gameController = Provider.of<GameController>(context);
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: kBottomNavigationBarHeight,
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: ElevatedButton(
            onPressed: visionHelper.objectDetected
                ? () async {
                    await gameController.completeCvQuest();
                    visionHelper.closeVision();
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
      ),
    );
  }
}
