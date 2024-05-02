import 'package:camera/camera.dart';

class CameraHelper {
  late CameraController cameraController;
  late List<CameraDescription> _cameras;
  bool _isLoaded = false;

  Future<String?> initCamera() async {
    String? errorText;
    _cameras = await availableCameras();
    cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await cameraController.initialize().then((_) {
      _isLoaded = true;
    }).onError((error, stackTrace) {
      errorText = error.toString();
    });
    return errorText;
  }

  bool get isCameraInitialized => _isLoaded;

  double? get aspectRation => _isLoaded ? cameraController.value.aspectRatio : null;
  
  Future<void> closeCamera() async {
    _isLoaded = false;
    await cameraController.dispose();
  }
}