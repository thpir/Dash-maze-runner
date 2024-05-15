import 'package:dash_maze_runner/views/widgets/cv_screen_widgets/detection_action.dart';
import 'package:dash_maze_runner/views/widgets/cv_screen_widgets/detection_appbar.dart';
import 'package:dash_maze_runner/views/widgets/cv_screen_widgets/detection_view.dart';
import 'package:dash_maze_runner/views/widgets/home_screen_widgets/background.dart';
//import 'package:dash_maze_runner/controller/flutter_vision_helper.dart';
import 'package:dash_maze_runner/controller/pytorch_lite_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        /* Uncomment if you are using the FlutterVisionHelper */
        //create: (_) => FlutterVisionHelper(),
        /* Uncomment if you are using the PytorchLiteHelper */
        create: (_) => PytorchLiteHelper(),
        builder: (context, child) {
          return const Scaffold(
            appBar: DetectionAppbar(),
            body: Stack(
              children: [
                Background(),
                DetectionView(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DetectionAction(),
                )
              ],
            ),
          );
        });
  }
}
