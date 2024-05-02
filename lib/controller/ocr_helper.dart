import 'package:dash_maze_runner/controller/camera_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrHelper extends ChangeNotifier {
  bool textRecognitionActive = false;
  CameraHelper cameraHelper = CameraHelper();

  Future<String?> initVision() async {
    String? errorMessage;
    await cameraHelper.initCamera().then((feedbackMessage) async {
      if (feedbackMessage != null) {
        errorMessage = feedbackMessage;
        return errorMessage;
      }
    });
    return errorMessage;
  }

  Future<List<String>> takeSnapshotForTextRecognition() async {
    TextRecognizer textRecognition = TextRecognizer();
    List<String> usableText = [''];
    textRecognitionActive = true;
    notifyListeners();
    try {
      final image = await cameraHelper.cameraController.takePicture();
      final path = image.path;
      final InputImage inputImage = InputImage.fromFilePath(path);
      final recognizedText = await textRecognition.processImage(inputImage);
      for (final textBlock in recognizedText.blocks) {
        usableText.add(textBlock.text);
      }
      textRecognitionActive = false;
      notifyListeners();
      return usableText;
    } catch (e) {
      textRecognitionActive = false;
      notifyListeners();
      return ['Something went wrong. Please try again.'];
    }
  }

  Future<void> closeVision() async {
    await cameraHelper.closeCamera();
  }
}
