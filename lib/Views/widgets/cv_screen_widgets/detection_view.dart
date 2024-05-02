import 'package:camera/camera.dart';
import 'package:dash_maze_runner/controller/vision_helper.dart';
import 'package:dash_maze_runner/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectionView extends StatefulWidget {
  const DetectionView({super.key});

  @override
  State<DetectionView> createState() => _DetectionViewState();
}

class _DetectionViewState extends State<DetectionView> {
  @override
  void initState() {
    super.initState();
    initDetectionScreen();
  }

  Future<void> initDetectionScreen() async {
    final visionHelper = Provider.of<VisionHelper>(context, listen: false);
    await visionHelper.initVision().then((errorText) {
      if (errorText != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorText)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vision initialized succesfully")));
      }
    }).then((_) {});
    setState(() {});
  }
  
  @override
  void deactivate() async {
    super.deactivate();
    final visionHelper = Provider.of<VisionHelper>(context, listen: false);
    await visionHelper.closeVision();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    final controller = Provider.of<VisionHelper>(context, listen: false);
    if (controller.yoloResults.isEmpty) return [];
    // First, we need to aquire the image width and height. This is not
    // necissarily width and height of the shown image. If we are in portrait
    // mode, the width and height of the image will be swapped.
    var imageWidth = controller.cameraImage?.width ?? 1;
    var imageHeight = controller.cameraImage?.height ?? 1;

    // Next, we need to calculate the factor by which we need to multiply the
    // bounding box coordinates to get the correct position on the screen.
    var factorX = screen.width / imageHeight;
    var factorY = (screen.width *
            controller.cameraHelper.cameraController.value.aspectRatio) /
        imageWidth;

    // Now we can create the bounding boxes.
    var boundingBoxes = <Widget>[];
    for (var result in controller.yoloResults) {
      boundingBoxes.add(Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: buttonBackgroundColor, width: 2.0),
            ),
            child: null),
      ));
    }
    return boundingBoxes;
  }

  @override
  Widget build(BuildContext context) {
    final visionHelper = Provider.of<VisionHelper>(context);
    final size = MediaQuery.of(context).size;
    return visionHelper.isVisionInitialized && visionHelper.hasDetectionStarted
        ? Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
                //color: greenBackground,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child:
                    CameraPreview(visionHelper.cameraHelper.cameraController),
              ),
              ...displayBoxesAroundRecognizedObjects(size),
            ],
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: buttonBackgroundColor,
              ),
            ),
          );
  }
}
