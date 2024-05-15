import 'package:camera/camera.dart';
import 'package:dash_maze_runner/controller/camera_helper.dart';
import 'package:flutter/material.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class PytorchLiteHelper extends ChangeNotifier {
  CameraHelper cameraHelper = CameraHelper();
  List<ResultObjectDetection> yoloResults = [];
  bool _isLoaded = false;
  bool _isDetecting = false;
  bool _isBusy = false;
  bool _objectDetected = false;
  CameraImage? cameraImage;
  late ModelObjectDetection objectModel;

  bool get isVisionInitialized => _isLoaded;

  bool get hasDetectionStarted => _isDetecting;

  bool get objectDetected => _objectDetected;

  /// Method to initialize the camera, load the yolomodel
  /// and start detecting object on every frame.
  Future<String?> initVision() async {
    String? errorMessage;
    await cameraHelper.initCamera().then((feedbackMessage) async {
      if (feedbackMessage != null) {
        errorMessage = feedbackMessage;
        return errorMessage;
      }
      await loadYoloModel().then((_) {
        yoloResults = [];
        startDetection();
      }).onError((error, stackTrace) {
        errorMessage = error.toString();
      });
    });
    return errorMessage;
  }

  /// Load the yolomodel from the assets folder.
  Future<void> loadYoloModel() async {
    objectModel = await PytorchLite.loadObjectDetectionModel(
        "assets/models/model_for_pytorch_lite.torchscript", 1, 640, 640,
        labelPath: "assets/models/labels.txt",
        objectDetectionModelType: ObjectDetectionModelType.yolov8);
    _isLoaded = true;
  }

  /// Method to start an image stream with the help of the CameraHelper class
  /// and apply YOLOv8 on every frame.
  Future<void> startDetection() async {
    _isDetecting = true;
    if (cameraHelper.cameraController.value.isStreamingImages) {
      return;
    }
    await cameraHelper.cameraController.startImageStream((image) async {
      if (_isDetecting) {
        cameraImage = image;
        if (!_isBusy) yoloOnFrame(image);
      }
    });
  }

  /// Method to apply yolo on every frame of a camerastream.
  /// The result is mapped in yoloResults.
  Future<void> yoloOnFrame(CameraImage cameraImage) async {   
      _isBusy = true;
      final result = await objectModel.getCameraImagePrediction(cameraImage, 0,
          minimumScore: 0.1, iOUThreshold: 0.1);
      yoloResults = result;
      if (result.isNotEmpty) {
        _objectDetected = true;
      } else {
        _objectDetected = false;
      }
      _isBusy = false;
      if (_isDetecting) {
        notifyListeners();
      } 
  }

  /// Close the camera with the help of the CameraHelper class
  void closeVision() {
    _isLoaded = false;
    _isDetecting = false;
    cameraHelper.closeCamera();
  }
}
