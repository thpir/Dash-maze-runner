import 'package:dash_maze_runner/views/widgets/home_screen_widgets/background.dart';
import 'package:dash_maze_runner/views/widgets/ocr_screen_widgets/ocr_action.dart';
import 'package:dash_maze_runner/views/widgets/ocr_screen_widgets/ocr_appbar.dart';
import 'package:dash_maze_runner/views/widgets/ocr_screen_widgets/ocr_view.dart';
import 'package:dash_maze_runner/views/widgets/ocr_screen_widgets/waiting_view.dart';
import 'package:dash_maze_runner/controller/ocr_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OcrHelper(),
      builder: (context, child) {
        return Scaffold(
          appBar: const OcrAppbar(),
          body: Stack(
            children: [
              const Background(),
              const OcrView(),
              const Align(
                alignment: Alignment.bottomCenter,
                child: OcrAction(),
              ),
              if (Provider.of<OcrHelper>(context).textRecognitionActive) const WaitingView(),
            ],
          ),
        );
      },
    );
  }
}
