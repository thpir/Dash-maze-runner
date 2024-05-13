import 'package:camera/camera.dart';
import 'package:dash_maze_runner/controller/camera_helper.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';

class FlutterVisionHelper extends ChangeNotifier {
  CameraHelper cameraHelper = CameraHelper();
  FlutterVision flutterVision = FlutterVision();
  CameraImage? cameraImage;
  bool _isLoaded = false;
  bool _isDetecting = false;
  bool _objectDetected = false;
  List<Map<String, dynamic>> yoloResults = [];

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
    await flutterVision.loadYoloModel(
        labels: 'assets/models/labels.txt',
        modelPath: 'assets/models/model_for_flutter_vision.tflite',
        modelVersion: "yolov8",
        quantization: true,
        numThreads: 2,
        useGpu: true);
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
        yoloOnFrame(image);
      }
    });
  }

  /// Method to apply yolo on every frame of a camerastream.
  /// The result is mapped in yoloResults.
  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await flutterVision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty) {
      yoloResults = result;
      _objectDetected = true;
      notifyListeners();
    } else {
      EasyThrottle.throttle('clear-screen', const Duration(milliseconds: 2000),
          () {
        yoloResults.clear();
        _objectDetected = false;
        notifyListeners();
      });
    }
  }

  /// Close the camera with the help of the CameraHelper class
  Future<void> closeVision() async {
    _isLoaded = false;
    _isDetecting = false;
    EasyThrottle.cancel('clear-screen');
    await cameraHelper.cameraController.stopImageStream();
    flutterVision.closeYoloModel();
    await cameraHelper.closeCamera();
  }
}
