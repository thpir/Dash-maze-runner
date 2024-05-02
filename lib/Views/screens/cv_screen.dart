import 'package:dash_maze_runner/Views/widgets/cv_screen_widgets/detection_action.dart';
import 'package:dash_maze_runner/Views/widgets/cv_screen_widgets/detection_appbar.dart';
import 'package:dash_maze_runner/Views/widgets/cv_screen_widgets/detection_view.dart';
import 'package:dash_maze_runner/Views/widgets/home_screen_widgets/background.dart';
import 'package:dash_maze_runner/controller/vision_helper.dart';
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
      create: (_) => VisionHelper(),
      builder: (context, child) {
        return const Scaffold(
            appBar: DetectionAppbar(),
            body: Stack(
              children: [
                Background(),
                DetectionView(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DetectionAction(),)
              ],
            ),
          );
      }
    );
  }
}
